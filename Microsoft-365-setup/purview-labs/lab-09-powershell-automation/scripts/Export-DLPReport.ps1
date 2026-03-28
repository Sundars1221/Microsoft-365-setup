<#
.SYNOPSIS
    Exports a DLP incident report for a specified date range to CSV.

.PARAMETER AdminUPN
    Admin user principal name.

.PARAMETER DaysBack
    Number of days back to report on. Default: 30.

.PARAMETER OutputPath
    Directory to save the CSV. Default: Desktop.

.PARAMETER PolicyName
    Optional: filter report to a specific DLP policy name.

.EXAMPLE
    .\Export-DLPReport.ps1 -AdminUPN admin@contoso.onmicrosoft.com -DaysBack 7

.EXAMPLE
    .\Export-DLPReport.ps1 -AdminUPN admin@contoso.onmicrosoft.com -DaysBack 30 -PolicyName "Lab - US Financial Data Protection"
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$AdminUPN,

    [Parameter(Mandatory = $false)]
    [int]$DaysBack = 30,

    [Parameter(Mandatory = $false)]
    [string]$OutputPath = "$env:USERPROFILE\Desktop",

    [Parameter(Mandatory = $false)]
    [string]$PolicyName = ""
)

$ErrorActionPreference = "Stop"

# ── Connect ───────────────────────────────────────────────────────────────────

Write-Host "Connecting to Security & Compliance PowerShell..." -ForegroundColor Cyan
Connect-IPPSSession -UserPrincipalName $AdminUPN | Out-Null

# ── Collect DLP events ────────────────────────────────────────────────────────

$startDate = (Get-Date).AddDays(-$DaysBack)
$endDate   = Get-Date

Write-Host "Collecting DLP events from $($startDate.ToString('yyyy-MM-dd')) to $($endDate.ToString('yyyy-MM-dd'))..." -ForegroundColor Cyan

$params = @{
    StartDate = $startDate
    EndDate   = $endDate
}

$rawReport = Get-DlpDetailReport @params

if ($PolicyName) {
    $rawReport = $rawReport | Where-Object { $_.Policy -eq $PolicyName }
    Write-Host "Filtered to policy: $PolicyName" -ForegroundColor Yellow
}

if (-not $rawReport -or $rawReport.Count -eq 0) {
    Write-Host "No DLP events found for the specified period." -ForegroundColor Yellow
    return
}

# ── Format and export ─────────────────────────────────────────────────────────

$report = $rawReport | Select-Object `
    Date,
    Policy,
    Rule,
    @{N="Severity"; E={$_.SeverityLevel}},
    @{N="User";     E={$_.UserName}},
    @{N="Document"; E={$_.DocumentName}},
    @{N="Location"; E={$_.ObjectId}},
    @{N="Action";   E={$_.Action}},
    @{N="Override"; E={$_.Override}},
    @{N="OverrideJustification"; E={$_.OverrideJustification}}

if (-not (Test-Path $OutputPath)) {
    New-Item -ItemType Directory -Path $OutputPath | Out-Null
}

$csvFile = Join-Path $OutputPath "DLPReport_Last${DaysBack}Days_$(Get-Date -Format 'yyyyMMdd').csv"
$report | Export-Csv -Path $csvFile -NoTypeInformation -Encoding utf8

# ── Summary ───────────────────────────────────────────────────────────────────

Write-Host "`n=== DLP Report Summary ===" -ForegroundColor Green
Write-Host "Total events : $($report.Count)"
Write-Host "Period       : Last $DaysBack days"
Write-Host "Policies hit : $(($report | Select-Object -ExpandProperty Policy -Unique).Count)"
Write-Host "Users flagged: $(($report | Select-Object -ExpandProperty User -Unique).Count)"
Write-Host ""
Write-Host "Top 5 policies by event count:"
$report | Group-Object Policy | Sort-Object Count -Descending | Select-Object -First 5 |
    ForEach-Object { Write-Host "  $($_.Count.ToString().PadLeft(4))  $($_.Name)" }

Write-Host "`n✔ Report saved: $csvFile" -ForegroundColor Green
