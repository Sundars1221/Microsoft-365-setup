# Lab 03: Email Security — EOP & Microsoft Defender 🛡️

**Difficulty**: ⭐⭐⭐ Advanced
**Duration**: 120 mins
**MS-203 Domain**: Secure the Messaging Environment (20–25%)

## 🎯 What You'll Learn
- Configure Exchange Online Protection (EOP) policies
- Set up anti-spam and anti-malware policies
- Configure Safe Attachments and Safe Links (Defender for Office 365)
- Set up DKIM, DMARC, and SPF records
- Configure connection filtering

> ⚠️ Most exercises in this lab are done in **Exchange Online** (M365 tenant), not on-prem Exchange

---

## Exercise 3.1 — Configure Anti-Spam Policies

### GUI Steps
1. Go to `https://security.microsoft.com`
2. Left menu → **Email & Collaboration** → **Policies & Rules** → **Threat Policies**
3. Click **Anti-spam**
4. Click **Anti-spam inbound policy (Default)** → **Edit**
5. Configure:

| Setting | Recommended Value |
|---|---|
| Bulk email threshold | 6 |
| Spam action | Move to Junk Email folder |
| High confidence spam | Quarantine message |
| Phishing | Quarantine message |
| High confidence phishing | Quarantine message |

6. Click **Save**

**Create a custom anti-spam policy:**
1. Click **+ Create** → Name: `Strict Anti-Spam Policy`
2. Apply to: your domain `yourdomain.com`
3. Set stricter thresholds → **Save**

### PowerShell

```powershell
# Connect to Exchange Online
Connect-ExchangeOnline -UserPrincipalName admin@yourdomain.com

# View current spam filter policies
Get-HostedContentFilterPolicy | Select Name, SpamAction, HighConfidenceSpamAction, PhishSpamAction

# Update default anti-spam policy
Set-HostedContentFilterPolicy -Identity Default `
    -SpamAction MoveToJmf `
    -HighConfidenceSpamAction Quarantine `
    -PhishSpamAction Quarantine `
    -HighConfidencePhishAction Quarantine `
    -BulkThreshold 6 `
    -MarkAsSpamBulkMail On

# Create a custom strict anti-spam policy
New-HostedContentFilterPolicy -Name "Strict Anti-Spam" `
    -SpamAction Quarantine `
    -HighConfidenceSpamAction Quarantine `
    -PhishSpamAction Quarantine `
    -HighConfidencePhishAction Quarantine `
    -BulkThreshold 4

# Apply policy to domain via filter rule
New-HostedContentFilterRule -Name "Strict Anti-Spam Rule" `
    -HostedContentFilterPolicy "Strict Anti-Spam" `
    -RecipientDomainIs "yourdomain.com" `
    -Priority 0
```

---

## Exercise 3.2 — Configure Anti-Malware Policy

### GUI Steps
1. `https://security.microsoft.com` → **Threat Policies** → **Anti-malware**
2. Click **Anti-malware policy (Default)** → **Edit**
3. Configure:

| Setting | Value |
|---|---|
| Enable zero-hour auto purge | ✅ On |
| Quarantine policy | AdminOnlyAccessPolicy |
| Admin notifications | Enable, set admin email |
| Common attachment filter | ✅ Enable |

4. Add blocked file types: `.exe`, `.ps1`, `.bat`, `.vbs`, `.js`
5. Click **Save**

### PowerShell

```powershell
# View current malware filter policies
Get-MalwareFilterPolicy | Select Name, Action, EnableFileFilter

# Update default malware policy
Set-MalwareFilterPolicy -Identity Default `
    -EnableFileFilter $true `
    -FileTypes @("ace","ani","app","cab","docm","exe","iso","jar","ps1","bat","vbs","js") `
    -ZapEnabled $true `
    -EnableInternalSenderAdminNotifications $true `
    -InternalSenderAdminAddress "admin@yourdomain.com"

# Verify policy
Get-MalwareFilterPolicy -Identity Default |
    Select Name, EnableFileFilter, FileTypes, ZapEnabled
```

---

## Exercise 3.3 — Configure Safe Attachments (Defender for Office 365)

> 💡 Requires Microsoft Defender for Office 365 Plan 1 (included in E5 or as add-on)

### GUI Steps
1. `https://security.microsoft.com` → **Threat Policies** → **Safe Attachments**
2. Click **+ Create**
3. Configure:

| Setting | Value |
|---|---|
| Name | Safe Attachments Policy |
| Safe Attachments response | Block |
| Enable redirect | ✅ On |
| Redirect address | admin@yourdomain.com |
| Apply to domain | yourdomain.com |

4. Click **Create**

### PowerShell

```powershell
# Create Safe Attachments policy
New-SafeAttachmentPolicy -Name "Safe Attachments Policy" `
    -Action Block `
    -Redirect $true `
    -RedirectAddress "admin@yourdomain.com" `
    -ActionOnError $true

# Apply to domain via rule
New-SafeAttachmentRule -Name "Safe Attachments Rule" `
    -SafeAttachmentPolicy "Safe Attachments Policy" `
    -RecipientDomainIs "yourdomain.com" `
    -Priority 0

# Verify
Get-SafeAttachmentPolicy | Select Name, Action, Redirect, RedirectAddress
```

---

## Exercise 3.4 — Configure Safe Links (Defender for Office 365)

### GUI Steps
1. `https://security.microsoft.com` → **Threat Policies** → **Safe Links**
2. Click **+ Create**
3. Configure:

| Setting | Value |
|---|---|
| Name | Safe Links Policy |
| Track user clicks | ✅ On |
| Let users click through | ❌ Off |
| Display branding | ✅ On |
| Apply real-time URL scanning | ✅ On |
| Apply to email messages | ✅ On |
| Apply to Teams | ✅ On |

4. Apply to: `yourdomain.com` → **Create**

### PowerShell

```powershell
# Create Safe Links policy
New-SafeLinksPolicy -Name "Safe Links Policy" `
    -EnableSafeLinksForEmail $true `
    -EnableSafeLinksForTeams $true `
    -TrackClicks $true `
    -AllowClickThrough $false `
    -EnableOrganizationBranding $true `
    -ScanUrls $true `
    -DeliverMessageAfterScan $true

# Apply to domain via rule
New-SafeLinksRule -Name "Safe Links Rule" `
    -SafeLinksPolicy "Safe Links Policy" `
    -RecipientDomainIs "yourdomain.com" `
    -Priority 0

# Verify
Get-SafeLinksPolicy | Select Name, EnableSafeLinksForEmail, TrackClicks, AllowClickThrough
```

---

## Exercise 3.5 — Configure SPF, DKIM, and DMARC

### SPF Record (at your DNS registrar)
Add a TXT record to your domain DNS:

| Field | Value |
|---|---|
| Type | TXT |
| Host | @ |
| Value | `v=spf1 include:spf.protection.outlook.com -all` |
| TTL | 3600 |

### DKIM Setup

**GUI Steps:**
1. `https://security.microsoft.com` → **Email & Collaboration** → **Policies & Rules** → **Threat Policies** → **DKIM**
2. Select your domain → Click **Enable**
3. Copy the two CNAME records shown → Add them to your DNS registrar

### PowerShell

```powershell
# Enable DKIM signing for your domain
Set-DkimSigningConfig -Identity "yourdomain.com" -Enabled $true

# Check DKIM status
Get-DkimSigningConfig | Select Domain, Enabled, Status, Selector1CNAME, Selector2CNAME

# Rotate DKIM keys (do periodically)
Rotate-DkimSigningConfig -Identity "yourdomain.com" -KeySize 2048
```

### DMARC Record (at your DNS registrar)
Add a TXT record:

| Field | Value |
|---|---|
| Type | TXT |
| Host | `_dmarc` |
| Value | `v=DMARC1; p=quarantine; rua=mailto:dmarc@yourdomain.com; pct=100` |
| TTL | 3600 |

> 💡 Start with `p=none` for monitoring, then move to `p=quarantine`, then `p=reject`

### Verify Email Authentication

```powershell
# Check SPF, DKIM, DMARC via PowerShell
# Send a test email and check headers, or use:
# https://www.mail-tester.com
# https://mxtoolbox.com/emailhealth

# Check inbound email authentication results
# Look for these headers in received emails:
# Authentication-Results: spf=pass, dkim=pass, dmarc=pass
```

---

## ✅ Lab 03 Checklist

- [ ] Anti-spam default policy updated
- [ ] Custom strict anti-spam policy created
- [ ] Anti-malware policy with file type filtering configured
- [ ] Safe Attachments policy created and applied
- [ ] Safe Links policy created and applied
- [ ] SPF record added to DNS
- [ ] DKIM enabled and CNAME records added to DNS
- [ ] DMARC record added to DNS
- [ ] All tasks completed via PowerShell

---

## 💡 Key Exam Tips (MS-203)
- **SPF** — validates sending server IP, set at DNS level
- **DKIM** — cryptographic signature, configured in M365 security portal
- **DMARC** — policy enforcement based on SPF + DKIM results
- Know the order: `p=none → p=quarantine → p=reject` for DMARC rollout
- **ZAP (Zero-Hour Auto Purge)** — retroactively removes malicious emails already delivered
- Safe Attachments scans **before delivery**; ZAP acts **after delivery**
