# Lab 05: Hybrid Exchange & Mailbox Migration 🔀

**Difficulty**: ⭐⭐⭐ Advanced
**Duration**: 120–180 mins
**MS-203 Domain**: Manage Hybrid Deployment Lifecycle (20–25%)

## 🎯 What You'll Learn
- Run the Hybrid Configuration Wizard (HCW)
- Configure hybrid mail flow and free/busy
- Test OAuth connectivity
- Migrate mailboxes from on-prem to Exchange Online
- Perform offboarding (cloud to on-prem)

---

## Exercise 5.1 — Run the Hybrid Configuration Wizard

### GUI Steps
1. RDP into **Lab-EX01** as `CORP\labadmin`
2. Open browser → Go to EAC: `https://localhost/ecp`
3. Left menu → **Hybrid** → Click **Configure**
4. Click **"click here"** to download the Hybrid Configuration Wizard

OR go directly to: `https://aka.ms/hybridwizard`

5. Run the downloaded `HybridConfigWizard.exe`

#### Wizard Steps:

**Step 1 — Sign In:**
- Sign in with your **M365 Global Admin** account
- Sign in with your **on-prem Exchange Admin** account (`CORP\labadmin`)

**Step 2 — Detecting Configuration:**
- Wizard auto-detects your on-prem Exchange server
- Verify EX01 is listed → Click **Next**

**Step 3 — Hybrid Features:**
| Option | Selection |
|---|---|
| Hybrid type | Full Hybrid (Classic) |
| Click **Next** | |

**Step 4 — Credentials:**
- Enter M365 global admin credentials again
- Enter on-prem admin credentials

**Step 5 — Hybrid Domain:**
- Select your verified domain: `yourdomain.com`

**Step 6 — Exchange Server:**
- Select **Lab-EX01** as the hybrid server
- Select **Lab-EX01** as the Edge/Client Access server

**Step 7 — Transport Certificate:**
- Select existing certificate or create self-signed (lab only)

**Step 8 — Mail Flow Settings:**
| Setting | Value |
|---|---|
| Mail flow direction | Exchange Online routes through on-prem (centralized) |
| OR | Direct from Exchange Online (decentralized) |

> 💡 Use **decentralized** for a lab — simpler to test

**Step 9 — Update:**
- Click **Update** → Wizard configures connectors and OAuth
- ⏱️ Takes 5–15 minutes

---

## Exercise 5.2 — Verify Hybrid Configuration

### GUI Steps
1. EAC (on-prem) → **Mail Flow** → **Send Connectors**
2. You should see: **Outbound to Office 365** connector ✅
3. Go to `https://admin.exchange.microsoft.com` → **Mail Flow** → **Connectors**
4. You should see: **Inbound from [your org]** and **Outbound to [your org]** ✅

### PowerShell

```powershell
# On EX01 — verify hybrid connectors
Get-SendConnector | Where {$_.Name -like "*365*" -or $_.Name -like "*hybrid*"} |
    Select Name, AddressSpaces, TlsAuthLevel

Get-ReceiveConnector | Where {$_.Name -like "*365*" -or $_.Name -like "*hybrid*"} |
    Select Name, AuthMechanism, PermissionGroups

# Test OAuth connectivity (critical for hybrid features)
Test-OAuthConnectivity `
    -Service EWS `
    -TargetUri "https://outlook.office365.com/ews/exchange.asmx" `
    -Mailbox "testuser@yourdomain.com" `
    -Verbose |
    Select ResultType, Detail

# Verify free/busy sharing works
Get-FederationInformation -DomainName "yourdomain.mail.onmicrosoft.com"

# Check Organization Relationship (hybrid trust)
Get-OrganizationRelationship | Select Name, Enabled, FreeBusyAccessEnabled, TargetApplicationUri
```

---

## Exercise 5.3 — Enable MRS Proxy (Required for Mailbox Migration)

MRS Proxy allows mailboxes to be moved between on-prem and Exchange Online.

### GUI Steps
1. EAC (on-prem) → **Servers** → **Virtual Directories**
2. Select **EWS (Default Web Site)** on EX01 → **Edit**
3. Check **"MRS Proxy endpoint enabled"** → **Save**

### PowerShell

```powershell
# Enable MRS Proxy on EX01
Set-WebServicesVirtualDirectory -Identity "EX01\EWS (Default Web Site)" `
    -MRSProxyEnabled $true

# Verify MRS Proxy is enabled
Get-WebServicesVirtualDirectory -Server EX01 |
    Select Server, MRSProxyEnabled, InternalUrl, ExternalUrl

# Test MRS Proxy connectivity from Exchange Online
# Run this in Exchange Online PowerShell:
Test-MigrationServerAvailability `
    -ExchangeRemoteMove `
    -RemoteServer "mail.yourdomain.com" `
    -Credentials (Get-Credential)
```

---

## Exercise 5.4 — Migrate Mailbox from On-Prem to Exchange Online

### GUI Steps (Exchange Online Admin Center)
1. Go to `https://admin.exchange.microsoft.com`
2. Left menu → **Migration** → **+ Add migration batch**
3. Configure:

| Setting | Value |
|---|---|
| Migration batch name | OnPrem-to-Cloud-Batch1 |
| Migration type | Remote move migration (Exchange) |
| Migration endpoint | Create new → Enter on-prem EWS URL |

4. **Create migration endpoint:**

| Field | Value |
|---|---|
| FQDN | mail.yourdomain.com |
| Username | CORP\labadmin |
| Password | YourStr0ngP@ssword! |

5. Add users: upload CSV or select from directory
6. Set target delivery domain: `yourdomain.mail.onmicrosoft.com`
7. Click **Next** → Configure completion settings → **Create**
8. Click **Start** to begin migration

### CSV Format for bulk migration:
```csv
EmailAddress
testuser@yourdomain.com
jsmith@yourdomain.com
```

### PowerShell

```powershell
# Connect to Exchange Online
Connect-ExchangeOnline -UserPrincipalName admin@yourdomain.com

# Create migration endpoint (if not already created via GUI)
$Credentials = Get-Credential  # Enter CORP\labadmin
New-MigrationEndpoint -ExchangeRemoteMove `
    -Name "OnPrem-Endpoint" `
    -RemoteServer "mail.yourdomain.com" `
    -Credentials $Credentials

# Create migration batch from CSV
New-MigrationBatch -Name "OnPrem-to-Cloud-Batch1" `
    -SourceEndpoint "OnPrem-Endpoint" `
    -CSVData ([System.IO.File]::ReadAllBytes("C:\migration.csv")) `
    -TargetDeliveryDomain "yourdomain.mail.onmicrosoft.com" `
    -AutoStart

# Check migration status
Get-MigrationBatch "OnPrem-to-Cloud-Batch1" |
    Select Status, TotalCount, SyncedCount, FinalizedCount, FailedCount

# Check individual mailbox migration status
Get-MigrationUser -BatchId "OnPrem-to-Cloud-Batch1" |
    Select EmailAddress, Status, PercentComplete, BytesTransferred

# Complete the migration batch (triggers final sync)
Complete-MigrationBatch -Identity "OnPrem-to-Cloud-Batch1"

# Remove completed batch
Remove-MigrationBatch -Identity "OnPrem-to-Cloud-Batch1" -Confirm:$false
```

---

## Exercise 5.5 — Test Hybrid Free/Busy

After HCW completes, users in Exchange Online and on-prem should be able to see each other's calendar availability.

### Test via PowerShell

```powershell
# Test free/busy from on-prem to cloud
# Run on EX01:
Get-FreeBusyInformation `
    -TargetSmtpAddress "clouduser@yourdomain.com" `
    -StartTime (Get-Date) `
    -EndTime (Get-Date).AddDays(7)

# Test OAuth connectivity
Test-OAuthConnectivity `
    -Service AutoDiscover `
    -TargetUri "https://autodiscover.yourdomain.com/autodiscover/metadata/json/1" `
    -Mailbox "testuser@yourdomain.com"
```

---

## ✅ Lab 05 Checklist

- [ ] Hybrid Configuration Wizard completed successfully
- [ ] Outbound to Office 365 send connector verified
- [ ] Inbound connector in Exchange Online verified
- [ ] OAuth connectivity test passed
- [ ] MRS Proxy enabled on EX01
- [ ] Migration endpoint created
- [ ] Test mailbox migrated to Exchange Online
- [ ] Free/busy working between on-prem and cloud users

---

## 💡 Key Exam Tips (MS-203)
- **Classic Hybrid** = full features, requires inbound network connectivity
- **Modern Hybrid (Agent)** = no inbound firewall rules needed, uses outbound agent
- MRS Proxy must be enabled for **remote move migrations**
- Free/busy requires **OAuth** to be configured correctly
- Know the different migration types: **Cutover, Staged, Minimal Hybrid, Remote Move**
- Target delivery domain for migrations is always `tenant.mail.onmicrosoft.com`
