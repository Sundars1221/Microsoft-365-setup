# Lab 04: Compliance & Retention 📋

**Difficulty**: ⭐⭐ Intermediate
**Duration**: 90 mins
**MS-203 Domain**: Manage Organizational Settings (30–35%)

## 🎯 What You'll Learn
- Configure retention policies and tags
- Set up Litigation Hold and In-Place Hold
- Enable archive mailboxes
- Configure Data Loss Prevention (DLP) policies
- Use eDiscovery for content search

---

## Exercise 4.1 — Enable Archive Mailboxes

### GUI Steps
1. Go to `https://admin.exchange.microsoft.com`
2. **Recipients** → **Mailboxes** → Select a user → Click **Others** tab
3. Under **Mailbox archive** → Click **Manage mailbox archive**
4. Toggle **Archive mailbox** → **On** → **Save**

### PowerShell

```powershell
# Connect to Exchange Online
Connect-ExchangeOnline -UserPrincipalName admin@yourdomain.com

# Enable archive for a single mailbox
Enable-Mailbox -Identity "jsmith@yourdomain.com" -Archive

# Enable archive for ALL mailboxes
Get-Mailbox -ResultSize Unlimited -Filter {ArchiveStatus -eq "None"} |
    Enable-Mailbox -Archive

# Check archive status
Get-Mailbox -Identity "jsmith@yourdomain.com" |
    Select DisplayName, ArchiveStatus, ArchiveDatabase, ArchiveQuota

# Check archive mailbox size
Get-MailboxStatistics -Identity "jsmith@yourdomain.com" -Archive |
    Select DisplayName, TotalItemSize, ItemCount
```

---

## Exercise 4.2 — Configure Retention Policies

### GUI Steps (Microsoft Purview)
1. Go to `https://compliance.microsoft.com`
2. Left menu → **Data lifecycle management** → **Retention policies**
3. Click **+ New retention policy**
4. Configure:

| Setting | Value |
|---|---|
| Name | General Email Retention |
| Retain items for | 7 years |
| At end of retention period | Delete items automatically |
| Apply to | Exchange email |

5. Choose specific users or all users → **Create**

### PowerShell

```powershell
# Connect to Security & Compliance Center
Connect-IPPSSession -UserPrincipalName admin@yourdomain.com

# Create a retention policy
New-RetentionCompliancePolicy -Name "General Email Retention" `
    -ExchangeLocation All `
    -Enabled $true

# Create the retention rule (7 years, then delete)
New-RetentionComplianceRule -Name "General Email Retention Rule" `
    -Policy "General Email Retention" `
    -RetentionDuration 2555 `
    -RetentionComplianceAction KeepAndDelete `
    -ExpirationDateOption CreationAgeInDays

# Create a shorter retention for specific mailboxes
New-RetentionCompliancePolicy -Name "Finance Email - 10 Year Retention" `
    -ExchangeLocation "finance@yourdomain.com" `
    -Enabled $true

New-RetentionComplianceRule -Name "Finance Retention Rule" `
    -Policy "Finance Email - 10 Year Retention" `
    -RetentionDuration 3650 `
    -RetentionComplianceAction KeepAndDelete

# View all retention policies
Get-RetentionCompliancePolicy | Select Name, Enabled, ExchangeLocation
```

---

## Exercise 4.3 — Configure Litigation Hold

Litigation Hold preserves all mailbox content indefinitely for legal purposes.

### GUI Steps
1. `https://admin.exchange.microsoft.com` → **Recipients** → **Mailboxes**
2. Select a mailbox → Click **Others** tab
3. Under **Litigation hold** → Click **Manage litigation hold**
4. Toggle → **On**
5. Set hold duration (leave blank for indefinite)
6. Add a note: `Legal hold — pending investigation`
7. Click **Save**

### PowerShell

```powershell
# Enable Litigation Hold for a single user (indefinite)
Set-Mailbox -Identity "jsmith@yourdomain.com" `
    -LitigationHoldEnabled $true `
    -LitigationHoldDuration Unlimited `
    -LitigationHoldOwner "Legal Department" `
    -RetainDeletedItemsFor 30

# Enable with a duration (e.g., 365 days)
Set-Mailbox -Identity "jsmith@yourdomain.com" `
    -LitigationHoldEnabled $true `
    -LitigationHoldDuration 365

# Check Litigation Hold status
Get-Mailbox -Identity "jsmith@yourdomain.com" |
    Select DisplayName, LitigationHoldEnabled, LitigationHoldDuration, LitigationHoldOwner

# Find all mailboxes currently on hold
Get-Mailbox -ResultSize Unlimited |
    Where {$_.LitigationHoldEnabled -eq $true} |
    Select DisplayName, LitigationHoldEnabled, LitigationHoldDuration

# Disable Litigation Hold
Set-Mailbox -Identity "jsmith@yourdomain.com" -LitigationHoldEnabled $false
```

---

## Exercise 4.4 — Configure DLP Policy

Data Loss Prevention prevents sensitive data from leaving the organization.

### GUI Steps
1. `https://compliance.microsoft.com` → **Data loss prevention** → **Policies**
2. Click **+ Create policy**
3. Select template: **Financial** → **U.S. Financial Data**
4. Configure:

| Setting | Value |
|---|---|
| Name | Block Credit Card Numbers |
| Locations | Exchange email |
| Policy mode | Test mode first, then Enforce |
| Action | Restrict access / Notify user |

5. Click **Create**

### PowerShell

```powershell
# View existing DLP policies
Get-DlpCompliancePolicy | Select Name, Mode, Workload

# Create a simple DLP policy (via PowerShell — basic example)
New-DlpCompliancePolicy -Name "Block Credit Card Numbers" `
    -ExchangeLocation All `
    -Mode TestWithNotifications

# Create DLP rule within the policy
New-DlpComplianceRule -Name "Block CC Numbers Rule" `
    -Policy "Block Credit Card Numbers" `
    -ContentContainsSensitiveInformation @{Name="Credit Card Number"; minCount=1} `
    -BlockAccess $true `
    -NotifyUser Owner `
    -GenerateIncidentReport SiteAdmin

# Switch from test to enforce mode
Set-DlpCompliancePolicy -Identity "Block Credit Card Numbers" -Mode Enable
```

---

## Exercise 4.5 — Run eDiscovery / Content Search

### GUI Steps
1. `https://compliance.microsoft.com` → **Content search**
2. Click **+ New search**
3. Configure:

| Setting | Value |
|---|---|
| Name | Test eDiscovery Search |
| Locations | Exchange mailboxes |
| Keywords | `confidential OR invoice OR contract` |
| Date range | Last 30 days |

4. Click **Run query**
5. View results → Click **Export** to download results

### PowerShell

```powershell
# Create and run a Content Search
New-ComplianceSearch -Name "Test eDiscovery Search" `
    -ExchangeLocation All `
    -ContentMatchQuery "confidential OR invoice OR contract" `
    -StartInactiveMailboxOnly $false

# Start the search
Start-ComplianceSearch -Identity "Test eDiscovery Search"

# Check search status
Get-ComplianceSearch -Identity "Test eDiscovery Search" |
    Select Name, Status, Items, Size

# View search results (after completion)
Get-ComplianceSearchAction | Select Name, Status, Results
```

---

## ✅ Lab 04 Checklist

- [ ] Archive mailbox enabled for test users
- [ ] General retention policy created (7 years)
- [ ] Finance-specific retention policy created (10 years)
- [ ] Litigation Hold enabled on a test mailbox
- [ ] DLP policy created in test mode
- [ ] DLP policy switched to enforce mode
- [ ] eDiscovery content search created and run
- [ ] All tasks completed via PowerShell

---

## 💡 Key Exam Tips (MS-203)
- **Litigation Hold vs Retention Policy** — Litigation Hold is mailbox-level; Retention Policies are org-level
- Archive mailboxes require **Exchange Online Plan 2** or E3/E5 for auto-expanding archives
- DLP policies should always be tested with **TestWithNotifications** mode before enforcing
- **eDiscovery** requires the **eDiscovery Manager** or **eDiscovery Administrator** role
- Retained items are stored in the **Recoverable Items** folder, invisible to end users
