<#
.SYNOPSIS
    Creates a new DLP policy from a pre-defined template configuration.

.DESCRIPTION
    Provides reusable DLP policy templates for common scenarios.
    Modify the $templates hashtable to add your own templates.

.PARAMETER AdminUPN
    Admin user principal name.

.PARAMETER Template
    Which template to deploy. Options: Financial, PII, HealthData, Custom.

.PARAMETER Mode
    Policy mode: TestWithNotifications, TestWithoutNotifications, Enable.
    Default: TestWithNotifications (safe for initial testing).

.EXAMPLE
    .\New-DLPPolicyFromTemplate.ps1 -AdminUPN admin@contoso.onmicrosoft.com -Template Financial

.EXAMPLE
    .\New-DLPPolicyFromTemplate.ps1 -AdminUPN admin@contoso.onmicrosoft.com -Template PII -Mode Enable
#>

[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory = $true)]
    [string]$AdminUPN,

    [Parameter(Mandatory = $true)]
    [ValidateSet("Financial", "PII", "HealthData", "Custom")]
    [string]$Template,

    [Parameter(Mandatory = $false)]
    [ValidateSet("TestWithNotifications", "TestWithoutNotifications", "Enable")]
    [string]$Mode = "TestWithNotifications"
)

$ErrorActionPreference = "Stop"

# ── Policy templates ──────────────────────────────────────────────────────────

$templates = @{
    Financial = @{
        PolicyName  = "Org - US Financial Data Protection"
        PolicyDesc  = "Protects US financial data: credit cards, bank accounts, routing numbers."
        RuleName    = "Block external financial data sharing"
        SITs        = @(
            @{ Name = "Credit Card Number"; minCount = "1"; minConfidence = "85" },
            @{ Name = "U.S. Bank Account Number"; minCount = "1"; minConfidence = "75" },
            @{ Name = "ABA Routing Number"; minCount = "1"; minConfidence = "75" }
        )
        Locations   = @{
            Exchange   = "All"
            SharePoint = "All"
            OneDrive   = "All"
            Teams      = "All"
        }
        BlockAccess       = $true
        NotifyUser        = @("Owner", "LastModifier")
        PolicyTipText     = "This content contains US financial data and cannot be shared externally."
        GenerateAlert     = $true
        AlertSeverity     = "High"
    }
    PII = @{
        PolicyName  = "Org - PII Protection"
        PolicyDesc  = "Protects personally identifiable information: SSN, passport, driver license."
        RuleName    = "Block external PII sharing"
        SITs        = @(
            @{ Name = "U.S. Social Security Number (SSN)"; minCount = "1"; minConfidence = "85" },
            @{ Name = "U.S. Individual Taxpayer Identification Number (ITIN)"; minCount = "1"; minConfidence = "75" },
            @{ Name = "U.S. Driver's License Number"; minCount = "1"; minConfidence = "75" }
        )
        Locations   = @{
            Exchange   = "All"
            SharePoint = "All"
            OneDrive   = "All"
            Teams      = "All"
        }
        BlockAccess       = $true
        NotifyUser        = @("Owner")
        PolicyTipText     = "This content contains personal information (PII) and cannot be shared externally."
        GenerateAlert     = $true
        AlertSeverity     = "High"
    }
    HealthData = @{
        PolicyName  = "Org - Health Data Protection"
        PolicyDesc  = "Protects health and medical information under HIPAA."
        RuleName    = "Block external health data sharing"
        SITs        = @(
            @{ Name = "U.S. Health Insurance Act (HIPAA)"; minCount = "1"; minConfidence = "75" },
            @{ Name = "International Classification of Diseases (ICD-10-CM)"; minCount = "1"; minConfidence = "75" }
        )
        Locations   = @{
            Exchange   = "All"
            SharePoint = "All"
            OneDrive   = "All"
            Teams      = "All"
        }
        BlockAccess       = $true
        NotifyUser        = @("Owner")
        PolicyTipText     = "This content may contain protected health information (PHI) and cannot be shared externally."
        GenerateAlert     = $true
        AlertSeverity     = "High"
    }
    Custom = @{
        PolicyName  = "Org - Custom DLP Policy"
        PolicyDesc  = "Customizable template. Edit this script to set your own SITs."
        RuleName    = "Custom rule"
        SITs        = @(
            # Add your SITs here:
            # @{ Name = "SIT Name"; minCount = "1"; minConfidence = "75" }
        )
        Locations   = @{
            Exchange   = "All"
            SharePoint = "All"
            OneDrive   = "All"
            Teams      = "All"
        }
        BlockAccess       = $false
        NotifyUser        = @("Owner")
        PolicyTipText     = "This content may violate company policy."
        GenerateAlert     = $true
        AlertSeverity     = "Medium"
    }
}

# ── Connect ───────────────────────────────────────────────────────────────────

Write-Host "Connecting to Security & Compliance PowerShell..." -ForegroundColor Cyan
Connect-IPPSSession -UserPrincipalName $AdminUPN | Out-Null

# ── Deploy policy ─────────────────────────────────────────────────────────────

$config = $templates[$Template]

Write-Host "`nDeploying template: $Template" -ForegroundColor Yellow
Write-Host "Policy name : $($config.PolicyName)"
Write-Host "Mode        : $Mode"
Write-Host "Block access: $($config.BlockAccess)"

if ($PSCmdlet.ShouldProcess($config.PolicyName, "Create DLP Policy")) {

    # Create the policy shell
    $policyParams = @{
        Name         = $config.PolicyName
        Comment      = $config.PolicyDesc
        Mode         = $Mode
    }
    if ($config.Locations.Exchange   -eq "All") { $policyParams.ExchangeLocation    = "All" }
    if ($config.Locations.SharePoint -eq "All") { $policyParams.SharePointLocation  = "All" }
    if ($config.Locations.OneDrive   -eq "All") { $policyParams.OneDriveLocation    = "All" }
    if ($config.Locations.Teams      -eq "All") { $policyParams.TeamsLocation       = "All" }

    Write-Host "Creating policy..." -ForegroundColor Cyan
    New-DlpCompliancePolicy @policyParams | Out-Null

    # Add the rule
    $ruleParams = @{
        Name                               = $config.RuleName
        Policy                             = $config.PolicyName
        ContentContainsSensitiveInformation = $config.SITs
        BlockAccess                        = $config.BlockAccess
        NotifyUser                         = $config.NotifyUser
        NotifyPolicyTipCustomText          = $config.PolicyTipText
        GenerateAlert                      = $config.GenerateAlert
        GenerateIncidentReport             = @("SiteAdmin")
        ReportSeverityLevel                = $config.AlertSeverity
    }

    Write-Host "Adding rule..." -ForegroundColor Cyan
    New-DlpComplianceRule @ruleParams | Out-Null

    Write-Host "`n✔ Policy created successfully!" -ForegroundColor Green
    Write-Host "  Name  : $($config.PolicyName)"
    Write-Host "  Mode  : $Mode (change to 'Enable' when ready to enforce)"
    Write-Host ""
    Write-Host "To enable enforcement, run:"
    Write-Host "  Set-DlpCompliancePolicy -Identity '$($config.PolicyName)' -Mode Enable" -ForegroundColor Yellow
}
