# Lab 08: PowerShell Automation for Exchange 🤖

**Difficulty**: ⭐⭐⭐ Advanced
**Duration**: 120 mins
**MS-203 Domain**: All Domains — Top differentiator in job market!

## 🎯 What You'll Learn
- Connect to Exchange Online via PowerShell
- Automate bulk mailbox operations
- Generate useful admin reports
- Schedule automated tasks
- Write reusable Exchange admin scripts

---

## Exercise 8.1 — Connect to Exchange (On-Prem & Online)

```powershell
# ── On-Premises Exchange ──────────────────────────────────────────

# Method 1: Run directly on EX01 (Exchange Management Shell)
# Just open Exchange Management Shell from Start menu

# Method 2: Remote PowerShell to EX01 from another machine
$Session = New-PSSession `
    -ConfigurationName Microsoft.Exchange `
    -ConnectionUri "http://EX01.corp.lab/PowerShell/" `
    -Authentication Kerberos
Import-PSSession $Session -DisableNameChecking

# ── Exchange Online ───────────────────────────────────────────────

# Install Exchange Online PowerShell module (run once)
Install-Module -Name ExchangeOnlineManagement -Force -AllowClobber

# Connect to Exchange Online
Connect-ExchangeOnline -UserPrincipalName admin@yourdomain.com

# Connect to Security & Compliance
Connect-IPPSSession -UserPrincipalName admin@yourdomain.com

# Connect to both in one session (useful for hybrid tasks)
Connect-ExchangeOnline -UserPrincipalName admin@yourdomain.com
Connect-IPPSSession -UserPrincipalName admin@yourdomain.com

# Disconnect when done
Disconnect-ExchangeOnline -Confirm:$false
```

---

## Exercise 8.2 — Bulk Mailbox Operations

```powershell
# ── Create multiple mailboxes from CSV ───────────────────────────
# CSV format: FirstName,LastName,Username,Password
# john,smith,jsmith,P@ssw0rd123
# jane,doe,jdoe,P@ssw0rd123

$Users = Import-Csv "C:\new-users.csv"
foreach ($User in $Users) {
    New-Mailbox `
        -Name "$($User.FirstName) $($User.LastName)" `
        -Alias $User.Username `
        -UserPrincipalName "$($User.Username)@yourdomain.com" `
        -Password (ConvertTo-SecureString $User.Password -AsPlainText -Force) `
        -FirstName $User.FirstName `
        -LastName $User.LastName `
        -ResetPasswordOnNextLogon $true
    Write-Host "Created mailbox for $($User.FirstName) $($User.LastName)" -ForegroundColor Green
}

# ── Bulk enable archive mailboxes ────────────────────────────────
Get-Mailbox -ResultSize Unlimited -Filter {ArchiveStatus -eq "None"} |
    Enable-Mailbox -Archive

# ── Bulk set mailbox quotas ──────────────────────────────────────
Get-Mailbox -OrganizationalUnit "LabUsers" | Set-Mailbox `
    -IssueWarningQuota 1.9GB `
    -ProhibitSendQuota 2GB `
    -ProhibitSendReceiveQuota 2.5GB `
    -UseDatabaseQuotaDefaults $false

# ── Bulk add email aliases from CSV ─────────────────────────────
# CSV format: Username,NewAlias
$Aliases = Import-Csv "C:\aliases.csv"
foreach ($Row in $Aliases) {
    Set-Mailbox -Identity $Row.Username `
        -EmailAddresses @{Add="$($Row.NewAlias)@yourdomain.com"}
    Write-Host "Added alias $($Row.NewAlias) to $($Row.Username)" -ForegroundColor Green
}

# ── Bulk disable mailboxes for departed employees ────────────────
$Departed = Import-Csv "C:\departed-users.csv"  # CSV with Username column
foreach ($User in $Departed) {
    # 1. Disable AD account
    Disable-ADAccount -Identity $User.Username
    # 2. Set Out of Office message
    Set-MailboxAutoReplyConfiguration `
        -Identity $User.Username `
        -AutoReplyState Enabled `
        -InternalMessage "This employee has left the company. Please contact HR." `
        -ExternalMessage "This employee is no longer with the company."
    # 3. Remove from all distribution groups
    Get-DistributionGroup | ForEach-Object {
        Remove-DistributionGroupMember -Identity $_.Name -Member $User.Username -Confirm:$false -ErrorAction SilentlyContinue
    }
    Write-Host "Offboarded: $($User.Username)" -ForegroundColor Yellow
}
```

---

## Exercise 8.3 — Generate Admin Reports

```powershell
# ── Report 1: All mailboxes with size and quota ──────────────────
$Report = Get-Mailbox -ResultSize Unlimited | ForEach-Object {
    $Stats = Get-MailboxStatistics -Identity $_.Identity -ErrorAction SilentlyContinue
    [PSCustomObject]@{
        DisplayName         = $_.DisplayName
        EmailAddress        = $_.PrimarySmtpAddress
        MailboxType         = $_.RecipientTypeDetails
        TotalSizeGB         = [math]::Round($Stats.TotalItemSize.Value.ToGB(), 2)
        ItemCount           = $Stats.ItemCount
        ProhibitSendQuotaGB = $_.ProhibitSendQuota
        LastLogon           = $Stats.LastLogonTime
        ArchiveEnabled      = if ($_.ArchiveStatus -eq "Active") {"Yes"} else {"No"}
    }
}
$Report | Export-Csv "C:\MailboxReport-$(Get-Date -Format 'yyyy-MM-dd').csv" -NoTypeInformation
$Report | Format-Table -AutoSize
Write-Host "Report saved to C:\MailboxReport-$(Get-Date -Format 'yyyy-MM-dd').csv" -ForegroundColor Green

# ── Report 2: Mailboxes not logged into for 30+ days ────────────
Get-Mailbox -ResultSize Unlimited | ForEach-Object {
    $Stats = Get-MailboxStatistics -Identity $_.Identity -ErrorAction SilentlyContinue
    if ($Stats.LastLogonTime -lt (Get-Date).AddDays(-30) -or $null -eq $Stats.LastLogonTime) {
        [PSCustomObject]@{
            DisplayName  = $_.DisplayName
            EmailAddress = $_.PrimarySmtpAddress
            LastLogon    = $Stats.LastLogonTime
            DaysInactive = if ($Stats.LastLogonTime) {
                ((Get-Date) - $Stats.LastLogonTime).Days
            } else { "Never" }
        }
    }
} | Export-Csv "C:\InactiveMailboxes-$(Get-Date -Format 'yyyy-MM-dd').csv" -NoTypeInformation

# ── Report 3: All mailbox permissions ────────────────────────────
Get-Mailbox -ResultSize Unlimited | ForEach-Object {
    $MB = $_
    Get-MailboxPermission -Identity $MB.Identity |
        Where {$_.User -notlike "NT AUTHORITY*" -and $_.IsInherited -eq $false} |
        ForEach-Object {
            [PSCustomObject]@{
                Mailbox     = $MB.PrimarySmtpAddress
                User        = $_.User
                AccessRights = $_.AccessRights -join ", "
            }
        }
} | Export-Csv "C:\MailboxPermissionsReport.csv" -NoTypeInformation

# ── Report 4: Distribution group membership ──────────────────────
Get-DistributionGroup -ResultSize Unlimited | ForEach-Object {
    $Group = $_
    Get-DistributionGroupMember -Identity $Group.Name | ForEach-Object {
        [PSCustomObject]@{
            GroupName    = $Group.DisplayName
            GroupEmail   = $Group.PrimarySmtpAddress
            MemberName   = $_.DisplayName
            MemberEmail  = $_.PrimarySmtpAddress
            MemberType   = $_.RecipientType
        }
    }
} | Export-Csv "C:\DistributionGroupMembership.csv" -NoTypeInformation
Write-Host "Reports generated!" -ForegroundColor Green
```

---

## Exercise 8.4 — Automate License Assignment (Exchange Online)

```powershell
# Connect to Microsoft Graph
Connect-MgGraph -Scopes "User.ReadWrite.All","Organization.Read.All"

# Get available licenses
Get-MgSubscribedSku | Select SkuPartNumber, ConsumedUnits, @{N="Available";E={$_.PrepaidUnits.Enabled - $_.ConsumedUnits}}

# Assign E3 license to a user
$SkuId = (Get-MgSubscribedSku | Where {$_.SkuPartNumber -eq "ENTERPRISEPACK"}).SkuId
$User = Get-MgUser -Filter "userPrincipalName eq 'jsmith@yourdomain.com'"

Set-MgUserLicense -UserId $User.Id `
    -AddLicenses @{SkuId = $SkuId} `
    -RemoveLicenses @()

# Bulk assign licenses from CSV
$Users = Import-Csv "C:\license-users.csv"  # CSV with UserPrincipalName column
foreach ($User in $Users) {
    $UserId = (Get-MgUser -Filter "userPrincipalName eq '$($User.UserPrincipalName)'").Id
    Set-MgUserLicense -UserId $UserId `
        -AddLicenses @{SkuId = $SkuId} `
        -RemoveLicenses @()
    Write-Host "Licensed: $($User.UserPrincipalName)" -ForegroundColor Green
}
```

---

## Exercise 8.5 — Schedule Automated Tasks

```powershell
# ── Create a scheduled task to run daily mailbox size report ─────

# Save this script as C:\Scripts\DailyMailboxReport.ps1
$ScriptContent = @'
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -UserPrincipalName admin@yourdomain.com -ShowBanner:$false

$Report = Get-Mailbox -ResultSize Unlimited | ForEach-Object {
    $Stats = Get-MailboxStatistics -Identity $_.Identity -ErrorAction SilentlyContinue
    [PSCustomObject]@{
        DisplayName  = $_.DisplayName
        EmailAddress = $_.PrimarySmtpAddress
        SizeGB       = [math]::Round($Stats.TotalItemSize.Value.ToGB(), 2)
        ItemCount    = $Stats.ItemCount
        LastLogon    = $Stats.LastLogonTime
    }
}

$ReportPath = "C:\Reports\MailboxReport-$(Get-Date -Format 'yyyy-MM-dd').csv"
$Report | Export-Csv $ReportPath -NoTypeInformation

Disconnect-ExchangeOnline -Confirm:$false
'@

New-Item -Path "C:\Scripts" -ItemType Directory -Force
$ScriptContent | Out-File "C:\Scripts\DailyMailboxReport.ps1"

# Create Windows Scheduled Task
$Action = New-ScheduledTaskAction `
    -Execute "PowerShell.exe" `
    -Argument "-NonInteractive -File C:\Scripts\DailyMailboxReport.ps1"

$Trigger = New-ScheduledTaskTrigger -Daily -At "6:00AM"

$Settings = New-ScheduledTaskSettingsSet `
    -ExecutionTimeLimit (New-TimeSpan -Hours 1) `
    -RestartCount 3

Register-ScheduledTask `
    -TaskName "Daily Mailbox Report" `
    -Action $Action `
    -Trigger $Trigger `
    -Settings $Settings `
    -RunLevel Highest `
    -User "CORP\labadmin" `
    -Password "YourStr0ngP@ssword!"

Write-Host "Scheduled task created — runs daily at 6AM" -ForegroundColor Green
```

---

## Exercise 8.6 — Useful One-Liners (Cheat Sheet)

```powershell
# Find all mailboxes over 10GB
Get-Mailbox -ResultSize Unlimited | Get-MailboxStatistics |
    Where {$_.TotalItemSize.Value.ToGB() -gt 10} |
    Select DisplayName, TotalItemSize | Sort TotalItemSize -Descending

# Find mailboxes on Litigation Hold
Get-Mailbox -ResultSize Unlimited | Where {$_.LitigationHoldEnabled} |
    Select DisplayName, LitigationHoldEnabled, LitigationHoldDuration

# List all forwarding mailboxes (security check!)
Get-Mailbox -ResultSize Unlimited |
    Where {$_.ForwardingAddress -ne $null -or $_.ForwardingSmtpAddress -ne $null} |
    Select DisplayName, ForwardingAddress, ForwardingSmtpAddress, DeliverToMailboxAndForward

# Find users who haven't changed password in 90 days
Get-ADUser -Filter {Enabled -eq $true} -Properties PasswordLastSet |
    Where {$_.PasswordLastSet -lt (Get-Date).AddDays(-90)} |
    Select Name, PasswordLastSet | Sort PasswordLastSet

# Export all transport rules
Get-TransportRule | Select Name, Priority, State, Description |
    Export-Csv "C:\TransportRules-Backup.csv" -NoTypeInformation

# Quickly check mail flow — count messages by event type (last hour)
Get-MessageTrackingLog -Start (Get-Date).AddHours(-1) -ResultSize Unlimited |
    Group-Object EventId | Select Name, Count | Sort Count -Descending

# Check which users have Full Access to a shared mailbox
Get-MailboxPermission -Identity "itsupport" |
    Where {$_.AccessRights -contains "FullAccess" -and $_.User -notlike "NT AUTHORITY*"} |
    Select User, AccessRights

# Disable external email forwarding for ALL users (security hardening)
Get-Mailbox -ResultSize Unlimited |
    Set-Mailbox -DeliverToMailboxAndForward $false -ForwardingSmtpAddress $null
```

---

## ✅ Lab 08 Checklist

- [ ] Connected to Exchange Online via PowerShell module
- [ ] Bulk created mailboxes from CSV
- [ ] Bulk enabled archive mailboxes
- [ ] Generated mailbox size report (exported to CSV)
- [ ] Generated inactive mailbox report
- [ ] Generated mailbox permissions report
- [ ] Created scheduled task for daily reporting
- [ ] Practiced one-liner commands

---

## 💡 Key Exam Tips (MS-203)
- PowerShell is tested heavily — know `Get-Mailbox`, `Set-Mailbox`, `New-Mailbox`, `Get-MessageTrackingLog`
- Always use `-ResultSize Unlimited` when you need ALL results (default is 1000)
- `Export-Csv -NoTypeInformation` removes the noisy type header from CSV exports
- Know how to **connect to Exchange Online** via `Connect-ExchangeOnline`
- **Scheduled tasks** and automation show up in senior admin job descriptions constantly
- Interviewers often ask: *"How would you find all mailboxes forwarding to external addresses?"* — know this!
