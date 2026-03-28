# Lab 09 — PowerShell & Graph API Automation

**Duration:** 90 minutes | **Level:** Expert | **Skill Area:** Automation / API

---

## Objectives

- Connect to Security & Compliance PowerShell and run administrative commands
- List, audit, and create Purview objects via PowerShell
- Export DLP incident reports programmatically
- Register an Azure app and authenticate to Microsoft Graph API
- Query Purview data via Graph and build an inventory report

## Learning Outcomes

| Outcome | Validated By |
|---------|-------------|
| Connect to S&C PowerShell | Session established; cmdlets returning data |
| Query DLP via Graph API | JSON response with policy data |
| Build admin scripts | `Get-PurviewInventory.ps1` runs successfully |

---

## Prerequisites

- [ ] PowerShell 7+ installed ([download](https://github.com/PowerShell/PowerShell/releases))
- [ ] `ExchangeOnlineManagement` module installed
- [ ] `Microsoft.Graph` module installed
- [ ] Compliance Admin or Global Admin role
- [ ] Azure subscription (for app registration)

---

## Section A — Security & Compliance PowerShell

### Step 1 — Install required modules

Open **PowerShell 7** as Administrator:

```powershell
# Install ExchangeOnlineManagement (includes Security & Compliance cmdlets)
Install-Module ExchangeOnlineManagement -Force -AllowClobber

# Install Microsoft Graph SDK
Install-Module Microsoft.Graph -Force -AllowClobber

# Verify installations
Get-Module ExchangeOnlineManagement -ListAvailable | Select-Object Name, Version
Get-Module Microsoft.Graph -ListAvailable | Select-Object Name, Version
```

### Step 2 — Connect to Security & Compliance

```powershell
# Connect to the Security & Compliance endpoint
Connect-IPPSSession -UserPrincipalName admin@yourtenant.onmicrosoft.com

# Authenticate in the browser window that opens
# You should see: "Connected to Security & Compliance PowerShell"
```

### Step 3 — Audit all sensitivity labels

```powershell
# List all sensitivity labels with key properties
Get-Label | Select-Object Name, Priority, IsEnabled, ContentType, Settings |
    Format-Table -AutoSize

# Export to CSV for documentation
Get-Label | Select-Object Name, Priority, IsEnabled, ParentId, Comment |
    Export-Csv -Path "$env:USERPROFILE\Desktop\SensitivityLabels.csv" -NoTypeInformation

Write-Host "Exported to Desktop\SensitivityLabels.csv"
```

### Step 4 — Audit DLP policies and rules

```powershell
# List all DLP policies
Get-DlpCompliancePolicy |
    Select-Object Name, Mode, Enabled, Workload |
    Format-Table -AutoSize

# List all DLP rules with their parent policy
Get-DlpComplianceRule |
    Select-Object Name, ParentPolicyName, BlockAccess, NotifyUser, Disabled |
    Format-Table -AutoSize

# Get DLP policy locations
Get-DlpCompliancePolicy | ForEach-Object {
    $policy = $_
    Write-Host "`n=== $($policy.Name) ===" -ForegroundColor Cyan
    Write-Host "Mode: $($policy.Mode)"
    Write-Host "Workloads: $($policy.Workload)"
}
```

### Step 5 — Export DLP incident report (last 30 days)

```powershell
$startDate = (Get-Date).AddDays(-30)
$endDate = Get-Date
$reportPath = "$env:USERPROFILE\Desktop\DLPReport_$(Get-Date -Format 'yyyyMMdd').csv"

Get-DlpDetailReport -StartDate $startDate -EndDate $endDate |
    Select-Object Date, Policy, Rule, SeverityLevel, UserName,
                  DocumentName, Action, Override |
    Export-Csv -Path $reportPath -NoTypeInformation

Write-Host "DLP report exported to: $reportPath"
Write-Host "Total events: $((Import-Csv $reportPath).Count)"
```

### Step 6 — Create a new DLP policy via PowerShell

```powershell
# Create the policy shell
New-DlpCompliancePolicy `
    -Name "PS-Lab-SSN-Policy" `
    -SharePointLocation All `
    -OneDriveLocation All `
    -ExchangeSenderMemberOf $null `
    -Mode TestWithNotifications `
    -Comment "Created via PowerShell lab exercise"

# Add a rule to the policy
New-DlpComplianceRule `
    -Name "PS-Lab-SSN-Rule" `
    -Policy "PS-Lab-SSN-Policy" `
    -ContentContainsSensitiveInformation @{
        Name = "U.S. Social Security Number (SSN)"
        minCount = "1"
        minConfidence = "75"
    } `
    -BlockAccess $false `
    -NotifyUser Owner `
    -GenerateAlert $true `
    -GenerateIncidentReport SiteAdmin

Write-Host "DLP policy created: PS-Lab-SSN-Policy"
```

### Step 7 — List retention and compliance policies

```powershell
# List retention policies
Get-RetentionCompliancePolicy |
    Select-Object Name, Enabled, Mode, ExchangeLocation |
    Format-Table -AutoSize

# List retention labels
Get-ComplianceTag |
    Select-Object Name, RetentionAction, RetentionDuration, IsRecordLabel |
    Format-Table -AutoSize

# List eDiscovery cases
Get-ComplianceCase |
    Select-Object Name, Status, CaseType, CreatedDateTime |
    Format-Table -AutoSize

# List case hold policies
Get-CaseHoldPolicy |
    Select-Object Name, Enabled, Status |
    Format-Table -AutoSize
```

---

## Section B — Microsoft Graph API

### Step 1 — Register an Azure AD Application

1. Go to **https://entra.microsoft.com → App registrations → New registration**
2. Settings:
   - Name: `PurviewLabApp`
   - Supported account types: **Single tenant**
   - Redirect URI: **Web** → `https://localhost`
3. Click **Register**
4. Note the **Application (client) ID** and **Directory (tenant) ID**

### Step 2 — Create a client secret
1. Go to **Certificates & secrets → New client secret**
2. Description: `PurviewLab`
3. Expires: 6 months
4. Click **Add**
5. **Copy the secret value immediately** — it won't be shown again

### Step 3 — Grant API permissions
1. Go to **API permissions → Add a permission → Microsoft Graph**
2. **Application permissions** (not delegated):
   - `InformationProtectionPolicy.Read.All`
   - `Policy.Read.All`
   - `SecurityEvents.Read.All`
3. Click **Grant admin consent** → Confirm

### Step 4 — Get an access token

```powershell
# Store your credentials (replace with your actual values)
$tenantId  = "YOUR-TENANT-ID"
$clientId  = "YOUR-APP-CLIENT-ID"
$clientSecret = "YOUR-CLIENT-SECRET"

# Request an access token using client credentials flow
$tokenBody = @{
    grant_type    = "client_credentials"
    client_id     = $clientId
    client_secret = $clientSecret
    scope         = "https://graph.microsoft.com/.default"
}

$tokenResponse = Invoke-RestMethod `
    -Uri "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token" `
    -Method POST `
    -Body $tokenBody

$accessToken = $tokenResponse.access_token
$headers = @{ Authorization = "Bearer $accessToken" }

Write-Host "Token obtained successfully. Expires in: $($tokenResponse.expires_in) seconds"
```

### Step 5 — Query sensitivity labels via Graph

```powershell
# Get all sensitivity labels
$labelsResponse = Invoke-RestMethod `
    -Uri "https://graph.microsoft.com/v1.0/security/informationProtection/sensitivityLabels" `
    -Headers $headers `
    -Method GET

# Display results
$labelsResponse.value | Select-Object name, id, priority, isEnabled |
    Format-Table -AutoSize

Write-Host "Total labels found: $($labelsResponse.value.Count)"
```

### Step 6 — Query DLP policies via Graph

```powershell
# Get DLP policies (beta endpoint)
$dlpResponse = Invoke-RestMethod `
    -Uri "https://graph.microsoft.com/beta/security/dataLossPreventionPolicies" `
    -Headers $headers `
    -Method GET

$dlpResponse.value | Select-Object displayName, state, mode |
    Format-Table -AutoSize
```

### Step 7 — Build a Purview inventory report

Save the following as `Get-PurviewInventory.ps1` (also in the `scripts/` folder):

```powershell
<#
.SYNOPSIS
    Generates a full Microsoft Purview inventory report.
.DESCRIPTION
    Connects to Security & Compliance PowerShell and Microsoft Graph.
    Exports: Sensitivity Labels, DLP Policies, Retention Policies, eDiscovery Cases.
.PARAMETER OutputPath
    Directory to save the HTML report. Defaults to Desktop.
.EXAMPLE
    .\Get-PurviewInventory.ps1 -OutputPath "C:\Reports"
#>
param(
    [string]$OutputPath = "$env:USERPROFILE\Desktop"
)

# ── Connect ──────────────────────────────────────────────────────────────────
Write-Host "Connecting to Security & Compliance PowerShell..." -ForegroundColor Cyan
Connect-IPPSSession -UserPrincipalName (Read-Host "Enter admin UPN")

# ── Gather data ───────────────────────────────────────────────────────────────
Write-Host "Collecting Purview inventory data..." -ForegroundColor Cyan

$labels     = Get-Label | Select-Object Name, Priority, IsEnabled, ContentType
$dlpPolicies = Get-DlpCompliancePolicy | Select-Object Name, Mode, Enabled, Workload
$dlpRules   = Get-DlpComplianceRule | Select-Object Name, ParentPolicyName, BlockAccess, Disabled
$retention  = Get-RetentionCompliancePolicy | Select-Object Name, Enabled, Mode
$retLabels  = Get-ComplianceTag | Select-Object Name, RetentionAction, RetentionDuration, IsRecordLabel
$cases      = Get-ComplianceCase | Select-Object Name, Status, CaseType, CreatedDateTime

# ── Build HTML report ─────────────────────────────────────────────────────────
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm UTC"

function ConvertTo-HtmlTable($data, $title, $color = "#2E75B6") {
    $headers = ($data | Get-Member -MemberType NoteProperty).Name
    $rows = $data | ForEach-Object {
        $row = $_
        "<tr>" + ($headers | ForEach-Object { "<td>$($row.$_)</td>" } | Join-String) + "</tr>"
    }
    @"
<h2 style='color:$color;border-bottom:2px solid $color;padding-bottom:6px'>$title</h2>
<table>
<thead><tr>$($headers | ForEach-Object { "<th>$_</th>" } | Join-String)</tr></thead>
<tbody>$($rows | Join-String)</tbody>
</table>
"@
}

$html = @"
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8'>
<title>Microsoft Purview Inventory - $timestamp</title>
<style>
  body { font-family: Segoe UI, Arial, sans-serif; margin: 40px; color: #333; }
  h1   { color: #1F4E79; }
  h2   { margin-top: 40px; }
  table { border-collapse: collapse; width: 100%; margin-bottom: 30px; font-size: 13px; }
  th   { background: #2E75B6; color: white; padding: 8px 12px; text-align: left; }
  td   { padding: 7px 12px; border-bottom: 1px solid #ddd; }
  tr:nth-child(even) { background: #f2f7fb; }
  .meta { color: #888; font-size: 12px; margin-bottom: 30px; }
</style>
</head>
<body>
<h1>Microsoft Purview Inventory Report</h1>
<p class='meta'>Generated: $timestamp | Tenant: $(Get-OrganizationConfig | Select-Object -ExpandProperty Name)</p>
$(ConvertTo-HtmlTable $labels "Sensitivity Labels")
$(ConvertTo-HtmlTable $dlpPolicies "DLP Policies")
$(ConvertTo-HtmlTable $dlpRules "DLP Rules")
$(ConvertTo-HtmlTable $retention "Retention Policies")
$(ConvertTo-HtmlTable $retLabels "Retention Labels")
$(ConvertTo-HtmlTable $cases "eDiscovery Cases")
</body>
</html>
"@

$reportFile = Join-Path $OutputPath "PurviewInventory_$(Get-Date -Format 'yyyyMMdd_HHmm').html"
$html | Out-File -FilePath $reportFile -Encoding utf8
Write-Host "`nReport saved to: $reportFile" -ForegroundColor Green
Start-Process $reportFile
```

---

## PowerShell Quick Reference

```powershell
# ── Labels ────────────────────────────────────────────────
Get-Label                                    # All sensitivity labels
Get-LabelPolicy                              # All label policies
Set-Label -Identity "Confidential" -Tooltip "Updated tooltip"

# ── DLP ──────────────────────────────────────────────────
Get-DlpCompliancePolicy                      # All DLP policies
Get-DlpComplianceRule                        # All DLP rules
Get-DlpDetailReport -StartDate (Get-Date).AddDays(-7) -EndDate (Get-Date)
Set-DlpCompliancePolicy -Identity "PolicyName" -Mode Enable

# ── Retention ────────────────────────────────────────────
Get-RetentionCompliancePolicy                # All retention policies
Get-ComplianceTag                            # All retention labels

# ── eDiscovery ───────────────────────────────────────────
Get-ComplianceCase                           # All eDiscovery cases
New-ComplianceSearch -Name "MySearch" -Case "CaseName" -ExchangeLocation All
Start-ComplianceSearch -Identity "MySearch"
Get-ComplianceSearchAction                   # Status of searches

# ── Insider Risk ─────────────────────────────────────────
Get-InsiderRiskPolicy                        # All IRM policies (requires E5)

# ── Audit ────────────────────────────────────────────────
Search-UnifiedAuditLog -StartDate (Get-Date).AddDays(-1) -EndDate (Get-Date) -RecordType SharePointFileOperation
```

---

## Validation Checklist

- [ ] Connected to Security & Compliance PowerShell
- [ ] Sensitivity labels exported to CSV
- [ ] DLP policies listed successfully
- [ ] DLP report exported with event data
- [ ] New DLP policy created via PowerShell (`PS-Lab-SSN-Policy`)
- [ ] Azure app registered with API permissions
- [ ] Access token obtained via client credentials
- [ ] Labels queried via Graph API
- [ ] `Get-PurviewInventory.ps1` runs and generates HTML report

---

## Next Lab

➡ [Lab 10 — AI Governance with Microsoft Copilot](../lab-10-ai-governance/README.md)
