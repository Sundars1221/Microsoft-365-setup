# Mail Flow & Transport Rules 📨

## Overview
- Configure Send and Receive connectors
- Create transport rules (mail flow rules)
- Configure message size limits
- Trace and troubleshoot mail flow
- Configure email disclaimers

---

## Pre-requisites

Install Certficates in Exchange Server for TLS encryption

```https://certifytheweb.com```

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/f6ba314b-c935-485d-894c-41136255ac36" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/db22ed08-b3ec-46af-af93-fbb28744d7a9" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/71e749d1-a4d7-42a7-9069-40b389d6bb87" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/73e8118d-e181-4877-8ff6-28dbdbce0be3" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/e2d8149b-bf88-410c-af63-d9936902e666" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/d905e5b4-c9d1-4351-aa92-7aa8e2021318" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/90880edb-1f6e-413a-be21-a52f618aea99" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/4cd92aea-d0ef-428a-90fc-091710e5bc99" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/094b5811-8c45-4889-a6c3-e870fc02ed67" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/62ebef6b-ddac-4841-b24e-37e9976de22a" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/28d81841-7fbc-4dce-a69f-f95ef8d89979" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/fae7e463-bb96-48a8-aefc-612371400ba2" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/83d5766d-d3a1-438b-b952-4ae9fc08fbb9" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/16960f5d-097e-44f3-9133-1cc4132718fe" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/6dc7938a-7ee1-41ef-a4cf-0d70baa7cb04" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/7234727e-4867-4705-8abd-1b405cef9faf" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/8d9d9f94-f04e-4d34-a9b5-ae3c117b3b6d" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/6f24cf81-2197-4590-9380-e4c450411a2f" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/683c184d-6012-48fc-8e42-56c4b7d93ac4" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/856ce174-a6fa-4507-b968-b4c1d318ee5d" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/18c7199f-4816-432d-a418-3f604a84ec18" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/6a2187fc-802e-42ef-a8b4-ed164b13edbf" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/5bec4e42-9d92-49e4-8439-7d130870b7b7" />


Allow Port 25

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/03396330-ca0e-4c02-9f28-a3c2f17e01cc" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/4186965b-0ce7-45db-8cc8-e7f30d72c8f8" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/37a0f928-7d8f-41ba-87ce-07d3bb7253aa" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/75033e18-214b-4113-8084-4e042b390ff3" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/d51f267f-0f9d-4353-9987-599312dd03b2" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/ca957a13-65e6-437b-9009-2f52e537177d" />

Configure Internal and External URLs for Exchange Virtual Directories

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/76a0594f-d905-4c83-9e76-018866958f1f" />

```
https://github.com/cunninghamp/ConfigureExchangeURLs.ps1
```

Create DNS record

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/9aa7fce8-e8b6-4e47-ab8f-e595e4bda188" />

Create A record within your domain under Forward Lookup Zones

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/b761dd34-6bd4-44d3-a97b-cf409569f0cd" />

Under IP address mention Exchange Server IP

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/27c85622-87e8-436b-b36f-d77902f391b6" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/0a639ae1-6a91-4215-82c8-452f50c9fad0" />

Verify through nslookup in DC

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/35d66308-b32e-452b-829c-45fdd21e7498" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/2b3a1677-a19a-4173-8ffc-30af30cd3790" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/2779aad1-2d04-4654-b5d8-c4a58c40604f" />

Add DNS 'A' record in your domain registrar

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/d620ee40-f51b-4cb9-a0d5-e5d1aba0c8a2" />

Add Exchange Server public IP in value 

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/72bdf56e-9681-49d0-a3a8-ef3d74f245e5" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/02f8a4b5-4e4c-450d-9297-bed88591dd49" />

Add 'MX' record in your domain registrar

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/e836fa73-85a5-457a-ab10-3c536568c3e6" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/ec56d30d-4c63-4073-967f-678e47251763" />

Prepare SPF record

```
v=spf1 ip4:<your public IP> -all
```

Verify SPF record syntax

```
https://www.kitterman.com/spf/validate.html
```

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/18d74c2e-cd8b-4c1f-a704-530e6dfe8001" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/277f25bb-c89c-4d6d-9546-e5c46760ae8f" />

Add 'SPF' TXT record in your domain registrar

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/b1efd3d3-8438-4b96-92bd-828809c593c4" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/8e1d311b-6943-4281-80a3-5e1bb81b3d0c" />

Verify published DNS records

```
https://mxtoolbox.com/
```

Verify A record

```
a:torvexis.xyz
```

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/bc9ddb06-6b44-4765-8cb1-516066959b80" />

Verify MX record

```
mx:torvexis.xyz
```

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/ad3ff3af-10a7-44a7-8ddd-4435dd4cf6c5" />

Verify SPF record

```
txt:torvexis.xyz
```

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/6f5252c2-f4e1-4f6e-b0c3-1e974978c62e" />

Test Inbound SMTP Email

```
[https://testconnectivity.microsoft.com/tests/exchange](https://testconnectivity.microsoft.com/tests/InboundSMTP/input)
```

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/b9aec744-8c3a-4478-b993-5ad479150de2" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/1fbe3422-2562-4904-9155-8cb23fce574f" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/2cafaec9-931e-43a7-8e93-04a10d62760f" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/fd9adf8f-cfce-45de-a929-9d269a3235d1" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/3e5e5298-0bda-4735-943e-bbae03dba798" />

## Configure Exchange server for outbound email

## Option 1: MX record associated with recipient domain
1. EAC (on-prem) → **Mail Flow** → **Send Connectors**
2. Create the default Internet send connector

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/87f1aec9-824c-4b27-98de-38eddc0ddc2c" />

Internet Send Connector

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/959f1f33-c043-49b3-901b-a85f4368cb9f" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/b0a43882-d201-4ac5-aa08-f886628942dc" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/e78106f4-f178-436c-8027-fd4845a21e3f" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/d5bdac97-e4bc-4622-87a0-4e3ce6ae7d6d" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/008f383e-b7b8-4419-9ff5-613cfe6a28a1" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/23982ede-7fd4-49a1-92d2-3ad889a2e519" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/1f3bb844-73dc-4f80-96c1-5d929db8d283" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/e6ec539b-6cc1-4fd7-ab5d-453ca76b789f" />

Test Inbound SMTP Email

```
https://testconnectivity.microsoft.com/tests/OutboundSMTP/input
```

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/1a2d053d-3741-4d72-a27f-a0eaad7e32f6" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/561ecb58-0555-4736-a820-0954547930a7" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/342fa347-adaa-4708-a0cb-b9dc8a67790d" />

## Option 1: MX record associated with recipient domain


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
