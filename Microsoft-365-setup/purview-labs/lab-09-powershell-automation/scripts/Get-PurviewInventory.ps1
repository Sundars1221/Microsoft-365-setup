<#
.SYNOPSIS
    Generates a full Microsoft Purview tenant inventory report in HTML.

.DESCRIPTION
    Connects to Security & Compliance PowerShell and collects:
    - Sensitivity Labels and Label Policies
    - DLP Policies and Rules
    - Retention Policies and Labels
    - eDiscovery Cases
    Outputs a self-contained HTML report.

.PARAMETER OutputPath
    Directory to save the HTML report. Defaults to the user's Desktop.

.PARAMETER AdminUPN
    Admin user principal name to connect with.

.EXAMPLE
    .\Get-PurviewInventory.ps1 -AdminUPN admin@contoso.onmicrosoft.com -OutputPath "C:\Reports"

.NOTES
    Requires: ExchangeOnlineManagement module
    Role: Compliance Admin or Global Admin
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$AdminUPN,

    [Parameter(Mandatory = $false)]
    [string]$OutputPath = "$env:USERPROFILE\Desktop"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# ── Helpers ───────────────────────────────────────────────────────────────────

function Write-Step([string]$msg) {
    Write-Host "  → $msg" -ForegroundColor Cyan
}

function ConvertTo-HtmlTable {
    param(
        [object[]]$Data,
        [string]$Title,
        [string]$Color = "#2E75B6"
    )
    if (-not $Data -or $Data.Count -eq 0) {
        return "<h2 style='color:$Color'>$Title</h2><p style='color:#888;font-style:italic'>No data found.</p>"
    }
    $props = ($Data[0] | Get-Member -MemberType NoteProperty).Name
    $headerRow = "<tr>" + ($props | ForEach-Object { "<th>$_</th>" } | Join-String) + "</tr>"
    $bodyRows  = $Data | ForEach-Object {
        $row = $_
        "<tr>" + ($props | ForEach-Object {
            $val = $row.$_
            if ($null -eq $val) { $val = "" }
            "<td>$([System.Web.HttpUtility]::HtmlEncode($val.ToString()))</td>"
        } | Join-String) + "</tr>"
    }
    @"
<h2 style='color:$Color;border-bottom:2px solid $Color;padding-bottom:6px;margin-top:40px'>
  $Title <span style='font-size:13px;font-weight:normal;color:#888'>($(($Data).Count) items)</span>
</h2>
<table>
  <thead>$headerRow</thead>
  <tbody>$($bodyRows | Join-String)</tbody>
</table>
"@
}

# ── Connect ───────────────────────────────────────────────────────────────────

Write-Host "`nMicrosoft Purview Inventory Generator" -ForegroundColor Yellow
Write-Host "======================================" -ForegroundColor Yellow

Write-Step "Connecting to Security & Compliance PowerShell..."
Connect-IPPSSession -UserPrincipalName $AdminUPN | Out-Null

# ── Collect data ──────────────────────────────────────────────────────────────

Write-Step "Collecting sensitivity labels..."
$labels = Get-Label |
    Select-Object Name, Priority, IsEnabled, ContentType,
        @{N="ParentLabel";E={if($_.ParentId){(Get-Label -Identity $_.ParentId).Name}else{"(root)"}}},
        Comment

Write-Step "Collecting label policies..."
$labelPolicies = Get-LabelPolicy |
    Select-Object Name, Enabled,
        @{N="Labels";E={$_.Labels -join ", "}},
        @{N="ModifiedBy";E={$_.ModifiedBy}}

Write-Step "Collecting DLP policies..."
$dlpPolicies = Get-DlpCompliancePolicy |
    Select-Object Name, Mode, Enabled,
        @{N="Workloads";E={$_.Workload -join ", "}},
        WhenCreated, WhenChanged

Write-Step "Collecting DLP rules..."
$dlpRules = Get-DlpComplianceRule |
    Select-Object Name, ParentPolicyName,
        @{N="BlockAccess";E={$_.BlockAccess}},
        @{N="NotifyUser";E={$_.NotifyUser -join ", "}},
        Disabled, GenerateAlert

Write-Step "Collecting retention policies..."
$retentionPolicies = Get-RetentionCompliancePolicy |
    Select-Object Name, Enabled, Mode,
        @{N="ExchangeLocation";E={if($_.ExchangeLocation){"All"}else{"None"}}},
        @{N="SharePointLocation";E={if($_.SharePointLocation){"All"}else{"None"}}},
        WhenCreated

Write-Step "Collecting retention labels..."
$retentionLabels = Get-ComplianceTag |
    Select-Object Name, RetentionAction,
        @{N="RetentionDays";E={$_.RetentionDuration}},
        IsRecordLabel, IsRegulatoryLabel,
        @{N="ReviewerEmail";E={$_.ReviewerEmail -join ", "}}

Write-Step "Collecting eDiscovery cases..."
$cases = try {
    Get-ComplianceCase | Select-Object Name, Status, CaseType, CreatedDateTime,
        @{N="CreatedBy";E={$_.CreatedBy}}
} catch { @() }

Write-Step "Collecting case holds..."
$holds = try {
    Get-CaseHoldPolicy | Select-Object Name, Enabled, Status,
        @{N="Case";E={$_.Case}},
        WhenCreated
} catch { @() }

$tenantName = try {
    (Get-OrganizationConfig).DisplayName
} catch { $AdminUPN.Split("@")[1] }

# ── Build HTML ────────────────────────────────────────────────────────────────

Write-Step "Building HTML report..."
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm UTC"

$html = @"
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Purview Inventory - $timestamp</title>
<style>
  * { box-sizing: border-box; }
  body  { font-family: 'Segoe UI', Arial, sans-serif; margin: 0; padding: 40px; color: #333; background: #f5f7fa; }
  .wrap { max-width: 1200px; margin: 0 auto; background: white; padding: 40px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,.08); }
  h1   { color: #1F4E79; margin: 0 0 4px; }
  .sub { color: #888; font-size: 13px; margin-bottom: 30px; }
  table { border-collapse: collapse; width: 100%; margin-bottom: 20px; font-size: 13px; }
  th   { background: #2E75B6; color: white; padding: 8px 12px; text-align: left; font-weight: 500; }
  td   { padding: 7px 12px; border-bottom: 1px solid #e5e9f0; vertical-align: top; }
  tr:nth-child(even) td { background: #f2f7fb; }
  tr:hover td { background: #deeaf1; }
  .summary { display: grid; grid-template-columns: repeat(auto-fit, minmax(160px, 1fr)); gap: 12px; margin: 24px 0 40px; }
  .card { background: #2E75B6; color: white; padding: 16px; border-radius: 8px; text-align: center; }
  .card-num { font-size: 28px; font-weight: bold; }
  .card-lbl { font-size: 12px; opacity: .8; margin-top: 4px; }
</style>
</head>
<body>
<div class="wrap">
  <h1>Microsoft Purview Inventory Report</h1>
  <p class="sub">Tenant: $tenantName &nbsp;|&nbsp; Generated: $timestamp</p>

  <div class="summary">
    <div class="card"><div class="card-num">$(($labels).Count)</div><div class="card-lbl">Sensitivity Labels</div></div>
    <div class="card"><div class="card-num">$(($labelPolicies).Count)</div><div class="card-lbl">Label Policies</div></div>
    <div class="card"><div class="card-num">$(($dlpPolicies).Count)</div><div class="card-lbl">DLP Policies</div></div>
    <div class="card"><div class="card-num">$(($dlpRules).Count)</div><div class="card-lbl">DLP Rules</div></div>
    <div class="card"><div class="card-num">$(($retentionPolicies).Count)</div><div class="card-lbl">Retention Policies</div></div>
    <div class="card"><div class="card-num">$(($retentionLabels).Count)</div><div class="card-lbl">Retention Labels</div></div>
    <div class="card"><div class="card-num">$(($cases).Count)</div><div class="card-lbl">eDiscovery Cases</div></div>
  </div>

  $(ConvertTo-HtmlTable $labels "Sensitivity Labels")
  $(ConvertTo-HtmlTable $labelPolicies "Label Policies")
  $(ConvertTo-HtmlTable $dlpPolicies "DLP Policies")
  $(ConvertTo-HtmlTable $dlpRules "DLP Rules")
  $(ConvertTo-HtmlTable $retentionPolicies "Retention Policies")
  $(ConvertTo-HtmlTable $retentionLabels "Retention Labels")
  $(ConvertTo-HtmlTable $cases "eDiscovery Cases")
  $(ConvertTo-HtmlTable $holds "Case Hold Policies")

  <p style="color:#aaa;font-size:12px;margin-top:40px;text-align:center">
    Generated by Get-PurviewInventory.ps1 | Microsoft Purview Hands-On Lab Series
  </p>
</div>
</body>
</html>
"@

# ── Save output ───────────────────────────────────────────────────────────────

if (-not (Test-Path $OutputPath)) {
    New-Item -ItemType Directory -Path $OutputPath | Out-Null
}

$reportFile = Join-Path $OutputPath "PurviewInventory_$(Get-Date -Format 'yyyyMMdd_HHmm').html"
$html | Out-File -FilePath $reportFile -Encoding utf8

Write-Host "`n✔ Report saved: $reportFile" -ForegroundColor Green
Start-Process $reportFile
