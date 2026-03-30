# Lab 07: Troubleshooting Exchange & Mail Flow 🔧

**Difficulty**: ⭐⭐⭐ Advanced
**Duration**: 90–120 mins
**MS-203 Domain**: All Domains — Highly valued in interviews!

## 🎯 What You'll Learn
- Troubleshoot mail flow and delivery failures
- Diagnose and fix NDR (Non-Delivery Report) errors
- Use Remote Connectivity Analyzer
- Troubleshoot hybrid connectivity issues
- Monitor Exchange server health
- Use Queue Viewer to diagnose stuck emails

---

## Exercise 7.1 — Interpret NDR Error Codes

Common NDR codes you must know:

| NDR Code | Meaning | Common Fix |
|---|---|---|
| 5.1.1 | Recipient not found | Check email address, verify mailbox exists |
| 5.1.8 | Sender blocked | Remove sender from block list |
| 5.2.2 | Mailbox full | Increase quota or archive old emails |
| 5.3.4 | Message too large | Reduce attachment size, increase size limit |
| 5.4.1 | Recipient rejected | Check recipient restrictions |
| 5.7.1 | Unauthorized to send | Check permissions, transport rules |
| 5.7.23 | SPF failure | Fix SPF record in DNS |
| 5.7.64 | TenantAttribution error | Hybrid connector misconfiguration |

### PowerShell — Simulate and Investigate NDRs

```powershell
# Find failed messages in message tracking log
Get-MessageTrackingLog `
    -EventId FAIL `
    -Start (Get-Date).AddDays(-1) `
    -ResultSize Unlimited |
    Select Timestamp, Sender, Recipients, MessageSubject, Source, EventId |
    Format-Table -AutoSize

# Search for specific NDR reasons
Get-MessageTrackingLog `
    -EventId SEND `
    -Start (Get-Date).AddDays(-1) |
    Where {$_.Recipients -like "*external*"} |
    Select Timestamp, Sender, Recipients, MessageSubject
```

---

## Exercise 7.2 — Use Queue Viewer (On-Prem)

### GUI Steps
1. On **Lab-EX01** → Open **Exchange Toolbox**
   (Start menu → Microsoft Exchange Server 2019 → Exchange Toolbox)
2. Click **Queue Viewer**
3. Review:
   - **Submission Queue** — messages waiting to be processed
   - **Poison Message Queue** — messages causing system errors
   - **Unreachable Queue** — can't determine routing
   - **Shadow Queues** — redundancy copies

4. Right-click a queue → **Retry** to force delivery
5. Right-click a message → **Properties** to view details

### PowerShell

```powershell
# View all queues
Get-Queue | Select Identity, Status, MessageCount, NextHopDomain | Format-Table -AutoSize

# View messages in a specific queue
Get-Message -Queue "EX01\Submission" | Select FromAddress, Recipients, Subject, Status

# Retry a stuck queue
Retry-Queue -Identity "EX01\Unreachable" -Resubmit $true

# Suspend a queue (stop processing)
Suspend-Queue -Identity "EX01\Submission"

# Resume a suspended queue
Resume-Queue -Identity "EX01\Submission"

# Remove a poison message
Remove-Message -Identity "EX01\Submission\12345" -WithNDR $false -Confirm:$false
```

---

## Exercise 7.3 — Use Remote Connectivity Analyzer

### GUI Steps
1. Go to `https://testconnectivity.microsoft.com`
2. Test these scenarios:

**Test 1 — Inbound SMTP:**
- Select **Inbound SMTP Email**
- Enter your domain → Run test
- Should show ✅ MX records, ✅ SMTP connectivity

**Test 2 — Outlook Connectivity (Autodiscover):**
- Select **Outlook Connectivity**
- Enter a test mailbox email and password
- Verifies Autodiscover, EWS, and MAPI connectivity

**Test 3 — Exchange ActiveSync:**
- Select **Exchange ActiveSync**
- Tests mobile device connectivity

### PowerShell (Test SMTP manually)

```powershell
# Test SMTP connectivity via Telnet (run on EX01 PowerShell)
# First enable Telnet client on Windows
Install-WindowsFeature Telnet-Client

# Test outbound SMTP manually (type these commands after connecting)
# telnet mail.recipient.com 25
# EHLO yourdomain.com
# MAIL FROM: testuser@yourdomain.com
# RCPT TO: recipient@external.com
# DATA
# Subject: Test
# This is a test.
# .
# QUIT

# Test Autodiscover
Test-OutlookWebServices -Identity "testuser@yourdomain.com" -MailboxCredential (Get-Credential)

# Test EWS (Exchange Web Services)
Test-WebServicesConnectivity -Identity "testuser@yourdomain.com" -MailboxCredential (Get-Credential)

# Test ActiveSync
Test-ActiveSyncConnectivity -Mailbox "testuser@yourdomain.com"

# Test MAPI connectivity
Test-MapiConnectivity -Server "EX01" -Identity "testuser@yourdomain.com"
```

---

## Exercise 7.4 — Monitor Exchange Server Health

### GUI Steps
1. Open **Exchange Management Shell** on EX01
2. Run health checks

### PowerShell

```powershell
# Check overall Exchange server health
Get-ServerHealth -Identity "EX01" | Where {$_.AlertValue -ne "Healthy"} |
    Select Name, AlertValue, HealthSetName, LastTransitionTime |
    Format-Table -AutoSize

# Check all services are running
Test-ServiceHealth | Where {$_.RequiredServicesRunning -eq $false}

# Check database health
Get-MailboxDatabase -Status | Select Name, Mounted, Server, DatabaseSize | Format-Table -AutoSize

# Check database copy status (if DAG)
Get-MailboxDatabaseCopyStatus | Select Name, Status, CopyQueueLength, ReplayQueueLength

# Check disk space on Exchange server
Get-ExchangeDiagnosticInfo -Server EX01 -Process EdgeTransport -Component ResourceThrottling

# Check transport service health
Test-SmtpConnectivity -Identity "EX01"

# View event logs for Exchange errors
Get-EventLog -LogName Application -Source *MSExchange* -EntryType Error -Newest 20 |
    Select TimeGenerated, Source, EventID, Message |
    Format-Table -AutoSize -Wrap
```

---

## Exercise 7.5 — Troubleshoot Hybrid Mail Flow Issues

### PowerShell

```powershell
# Test OAuth between on-prem and Exchange Online
Test-OAuthConnectivity `
    -Service EWS `
    -TargetUri "https://outlook.office365.com/ews/exchange.asmx" `
    -Mailbox "testuser@yourdomain.com" `
    -Verbose

# Check hybrid connectors are working
Get-SendConnector "Outbound to Office 365" | Select Enabled, TlsAuthLevel, SmartHosts

# Test connection to Exchange Online Protection
Test-SmtpConnectivity -Identity "EX01"

# Check if free/busy is working
Get-IntraOrganizationConnector | Select Name, Enabled, TargetAddressDomains, DiscoveryEndpoint

# Verify organization relationship
Get-OrganizationRelationship | Select Name, Enabled, FreeBusyAccessEnabled, MailTipsAccessEnabled

# Check hybrid agent status (if using modern hybrid)
# (Run on the server where Hybrid Agent is installed)
Get-HybridConfiguration | Select Features, ClientAccessServers, SendingTransportServers
```

---

## Exercise 7.6 — Troubleshoot Exchange Online Mail Flow

```powershell
# Connect to Exchange Online
Connect-ExchangeOnline -UserPrincipalName admin@yourdomain.com

# Run message trace (last 24 hours)
Get-MessageTrace `
    -StartDate (Get-Date).AddDays(-1) `
    -EndDate (Get-Date) `
    -RecipientAddress "testuser@yourdomain.com" |
    Select Received, SenderAddress, RecipientAddress, Subject, Status, ToIP, FromIP

# Get detailed trace for a specific message
$trace = Get-MessageTrace -MessageId "<messageid@yourdomain.com>"
Get-MessageTraceDetail -MessageTraceId $trace.MessageTraceId -RecipientAddress $trace.RecipientAddress |
    Select Date, Event, Action, Detail

# Check spam filter decisions for a specific message
# Look for X-Forefront-Antispam-Report header in received emails

# Test mail flow with Send-MailMessage (requires SMTP relay setup)
Send-MailMessage `
    -From "testuser@yourdomain.com" `
    -To "admin@yourdomain.com" `
    -Subject "Mail Flow Test" `
    -Body "Testing mail flow - $(Get-Date)" `
    -SmtpServer "smtp.office365.com" `
    -Port 587 `
    -UseSsl `
    -Credential (Get-Credential)
```

---

## ✅ Lab 07 Checklist

- [ ] NDR error codes studied and understood
- [ ] Queue Viewer opened and queues reviewed
- [ ] Remote Connectivity Analyzer tests run (SMTP, Autodiscover, ActiveSync)
- [ ] Exchange server health checked via PowerShell
- [ ] Database health and disk space checked
- [ ] OAuth connectivity test run for hybrid
- [ ] Message trace performed in Exchange Online
- [ ] Event logs checked for Exchange errors

---

## 💡 Key Exam Tips (MS-203)
- **Message Trace** is the #1 tool for mail flow troubleshooting — know it well
- NDR `5.7.64` almost always means a **hybrid connector misconfiguration**
- **Queue Viewer** shows mail stuck on-prem; **Message Trace** shows cloud mail flow
- `Test-OAuthConnectivity` failure = free/busy and hybrid features will break
- Remote Connectivity Analyzer at `testconnectivity.microsoft.com` is the go-to external test tool
- Always check **both ends** when troubleshooting hybrid mail flow — on-prem AND cloud
