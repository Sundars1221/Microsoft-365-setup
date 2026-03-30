# Lab 02: Mail Flow & Transport Rules 📨

**Difficulty**: ⭐⭐ Intermediate
**Duration**: 90–120 mins
**MS-203 Domain**: Plan and Manage Mail Architecture (20–25%)

## 🎯 What You'll Learn
- Configure Send and Receive connectors
- Create transport rules (mail flow rules)
- Configure message size limits
- Trace and troubleshoot mail flow
- Configure email disclaimers

---

## Exercise 2.1 — Inspect Default Connectors

### GUI Steps
1. EAC (on-prem) → **Mail Flow** → **Send Connectors**
2. Review the default Internet send connector
3. Click **Receive Connectors** → Review default connectors:
   - **Default Frontend** (port 25 — inbound from internet)
   - **Client Frontend** (port 587 — authenticated client submission)
   - **Default** (port 2525 — internal)

### PowerShell

```powershell
# View all Send Connectors
Get-SendConnector | Select Name, AddressSpaces, SourceTransportServers, Enabled

# View all Receive Connectors
Get-ReceiveConnector | Select Name, Bindings, RemoteIPRanges, AuthMechanism

# Check mail flow settings
Get-TransportConfig | Select MaxSendSize, MaxReceiveSize, MaxRecipientEnvelopeLimit
```

---

## Exercise 2.2 — Create a Custom Send Connector

### GUI Steps
1. EAC → **Mail Flow** → **Send Connectors** → **+**
2. Wizard settings:

| Field | Value |
|---|---|
| Name | Internet Send Connector |
| Type | Internet |
| Route mail through smart host | Leave unchecked (use MX) |
| Address space | * (all domains) |
| Source server | EX01 |

3. Click **Finish**

### PowerShell

```powershell
# Create Internet Send Connector
New-SendConnector -Name "Internet Send Connector" `
    -Usage Internet `
    -AddressSpaces "SMTP:*;1" `
    -IsScopedConnector $false `
    -DNSRoutingEnabled $true `
    -UseExternalDNSServersEnabled $false `
    -SourceTransportServers "EX01"

# Verify
Get-SendConnector "Internet Send Connector" | Select Name, AddressSpaces, Enabled
```

---

## Exercise 2.3 — Configure Message Size Limits

### GUI Steps
1. EAC → **Mail Flow** → **Receive Connectors** → Select **Default Frontend EX01** → **Edit**
2. Click **General** → Set **Maximum receive message size**: `25 MB`
3. Click **Save**

Also set org-level limits:
1. EAC → **Mail Flow** → **Message Size Restrictions**
2. Set max send/receive sizes

### PowerShell

```powershell
# Set organization-wide message size limits
Set-TransportConfig `
    -MaxSendSize 25MB `
    -MaxReceiveSize 25MB `
    -MaxRecipientEnvelopeLimit 500

# Set per-mailbox send/receive limits
Set-Mailbox -Identity "jsmith" `
    -MaxSendSize 20MB `
    -MaxReceiveSize 20MB

# Set limits on Receive Connector
Set-ReceiveConnector -Identity "EX01\Default Frontend EX01" `
    -MaxMessageSize 25MB

# Set limits on Send Connector
Set-SendConnector -Identity "Internet Send Connector" `
    -MaxMessageSize 25MB

# Verify all size settings
Get-TransportConfig | Select MaxSendSize, MaxReceiveSize
Get-ReceiveConnector | Select Name, MaxMessageSize
Get-SendConnector | Select Name, MaxMessageSize
```

---

## Exercise 2.4 — Create Transport Rules (Mail Flow Rules)

### GUI Steps

**Rule 1 — Add Email Disclaimer:**
1. EAC → **Mail Flow** → **Rules** → **+** → **Apply disclaimers**
2. Configure:

| Field | Value |
|---|---|
| Name | Company Email Disclaimer |
| Apply rule if | Sender is located: Inside the organization |
| Do the following | Append disclaimer |
| Disclaimer text | `<p>This email is confidential. If received in error, please delete immediately.</p>` |
| Fallback action | Wrap |

3. Click **Save**

**Rule 2 — Block External Forwarding:**
1. EAC → **Mail Flow** → **Rules** → **+** → **Create new rule**
2. Configure:

| Field | Value |
|---|---|
| Name | Block External Email Forwarding |
| Apply if | Message type is Auto-forward |
| AND recipient is located | Outside the organization |
| Do the following | Block the message → Reject with explanation |
| Rejection reason | External email forwarding is not permitted |

### PowerShell

```powershell
# Rule 1: Add email disclaimer
New-TransportRule -Name "Company Email Disclaimer" `
    -FromScope InOrganization `
    -ApplyHtmlDisclaimerLocation Append `
    -ApplyHtmlDisclaimerText "<p style='color:gray;font-size:11px;'>This email is confidential. If received in error, please delete immediately.</p>" `
    -ApplyHtmlDisclaimerFallbackAction Wrap

# Rule 2: Block external auto-forwarding
New-TransportRule -Name "Block External Email Forwarding" `
    -MessageTypeMatches AutoForward `
    -SentToScope NotInOrganization `
    -RejectMessageReasonText "External email forwarding is not permitted by company policy" `
    -RejectMessageEnhancedStatusCode "5.7.1"

# Rule 3: Add confidential label to emails with "confidential" in subject
New-TransportRule -Name "Confidential Email Header" `
    -SubjectContainsWords "confidential","secret","private" `
    -ApplyHtmlDisclaimerLocation Prepend `
    -ApplyHtmlDisclaimerText "<p style='color:red;font-weight:bold;'>⚠️ CONFIDENTIAL — Handle with care</p>" `
    -ApplyHtmlDisclaimerFallbackAction Ignore

# Rule 4: Route emails from specific domain through compliance team
New-TransportRule -Name "Legal Domain CC Compliance" `
    -RecipientDomainIs "legalfirm.com" `
    -CopyTo "compliance@yourdomain.com" `
    -SetHeaderName "X-Compliance-Copy" `
    -SetHeaderValue "True"

# View all transport rules
Get-TransportRule | Select Name, Priority, State | Format-Table -AutoSize

# Enable/Disable a rule
Disable-TransportRule -Identity "Company Email Disclaimer"
Enable-TransportRule -Identity "Company Email Disclaimer"
```

---

## Exercise 2.5 — Trace Mail Flow (Message Tracking)

### GUI Steps (On-Prem)
1. EAC → **Mail Flow** → **Delivery Reports**
2. Search for messages by sender, recipient, or subject
3. View delivery status and mail flow path

### GUI Steps (Exchange Online)
1. Go to `https://admin.exchange.microsoft.com`
2. **Mail Flow** → **Message Trace**
3. Set date range → Enter sender/recipient → Click **Search**
4. Click on a result to see full delivery details

### PowerShell

```powershell
# Search message tracking logs (on-prem)
Get-MessageTrackingLog `
    -Start (Get-Date).AddDays(-1) `
    -End (Get-Date) `
    -EventId DELIVER `
    -ResultSize Unlimited |
    Select Timestamp, Sender, Recipients, MessageSubject, EventId |
    Format-Table -AutoSize

# Track a specific sender's messages
Get-MessageTrackingLog `
    -Sender "jsmith@yourdomain.com" `
    -Start (Get-Date).AddHours(-4) |
    Select Timestamp, EventId, Recipients, MessageSubject

# Track failed deliveries
Get-MessageTrackingLog `
    -EventId FAIL `
    -Start (Get-Date).AddDays(-1) |
    Select Timestamp, Sender, Recipients, MessageSubject, Source
```

---

## ✅ Lab 02 Checklist

- [ ] Default connectors reviewed
- [ ] Custom Send Connector created
- [ ] Message size limits configured at org and connector level
- [ ] Email disclaimer transport rule created
- [ ] External forwarding block rule created
- [ ] Message trace performed
- [ ] All tasks completed via PowerShell

---

## 💡 Key Exam Tips (MS-203)
- Transport rules are processed in **priority order** (lower number = higher priority)
- **Auto-forward block** is a common real-world security control — know how to implement it
- Message size limits must be configured at **multiple levels**: org, connector, and mailbox
- Message trace is the first tool to use for any mail flow issue
- Know the difference between **SMTP, SMTP AUTH, and submission** ports (25, 587, 465)
