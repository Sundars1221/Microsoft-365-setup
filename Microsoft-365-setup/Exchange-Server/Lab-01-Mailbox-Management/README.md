# Mailbox Management 📬

##  Overview
- Create and manage user, shared, room, and equipment mailboxes
- Configure mailbox permissions and delegation
- Set mailbox quotas and limits
- Manage distribution groups and M365 groups
- Configure email aliases

---

## Exercise 1.1 — Create Different Mailbox Types

### GUI Steps (Exchange Admin Center)

**User Mailbox:**
1. Go to `https://localhost/ecp` (on-prem)

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/9c830c8b-fc0b-4cef-827d-47b0f9b0d2d8" />

2. **Recipients** → **Mailboxes** → Click **+** → **User Mailbox**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/71dd3344-2d6e-451a-b32c-b8f52773389b" />

4. Fill in:

| Field | Value |
|---|---|
| First name | John |
| Last name | Smith |
| User logon name | jsmith@yourdomain.com |
| Password | YourStr0ngP@ssword! |
| Mailbox database | (leave default) |

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/7c6579dd-256e-469d-ac42-7b8d4e99f55c" />

4. Click **Save**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/59804cbb-d30b-43ff-8cf1-8baaa7c8acd7" />

**Shared Mailbox:**
1. **Recipients** → **Shared** → **+** → 

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/8781a50e-fcdb-4f2b-bc67-7e7907d8915b" />

2. Fill in:

| Field | Value |
|---|---|
| Display name | IT Support |
| Email address | itsupport@yourdomain.com |

3. Click **Save** → Add members who need access

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/6fc85508-2db2-4567-883d-bb18872be479" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/7fe2ba24-f87e-4a43-a861-a12d6349b7d4" />

**Room Mailbox:**
1. **Recipients** → **Resources** → **+** → **Room Mailbox**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/37b71faf-4b5c-49df-8141-e73afa07faf4" />

2. Fill in:

| Field | Value |
|---|---|
| Room name | Conference Room A |
| Email address | confrooma@yourdomain.com |
| Capacity | 20 |

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/58ed9938-701b-4e29-bf53-1853eabe98a1" />

3. Click **Save**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/83141832-18fc-4a4a-95fa-92029a97dd3d" />

### PowerShell (Exhange Management Shell)

```powershell
# Connect to Exchange On-Prem (run on EX01)
Add-PSSnapin Microsoft.Exchange.Management.PowerShell.SnapIn

# Create User Mailbox
New-Mailbox -Name "John Smith" `
    -Alias "jsmith" `
    -UserPrincipalName "jsmith@yourdomain.com" `
    -Password (ConvertTo-SecureString "YourStr0ngP@ssword!" -AsPlainText -Force) `
    -FirstName "John" `
    -LastName "Smith" `
    -DisplayName "John Smith"

# Create Shared Mailbox
New-Mailbox -Shared `
    -Name "IT Support" `
    -Alias "itsupport" `
    -UserPrincipalName "itsupport@yourdomain.com"

# Create Room Mailbox
New-Mailbox -Room `
    -Name "Conference Room A" `
    -Alias "confrooma" `
    -UserPrincipalName "confrooma@yourdomain.com" `
    -ResourceCapacity 20

# Create Equipment Mailbox
New-Mailbox -Equipment `
    -Name "Projector 01" `
    -Alias "projector01" `
    -UserPrincipalName "projector01@yourdomain.com"

# Verify all mailboxes
Get-Mailbox | Select Name, RecipientTypeDetails, PrimarySmtpAddress | Format-Table -AutoSize
```
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/8af0fd85-ae62-4c76-bfdf-c1d298c14993" />

---

## Exercise 1.2 — Configure Mailbox Permissions & Delegation

### GUI Steps
1. Open EAC → **Recipients** → **Mailboxes**
2. Select **IT Support** shared mailbox → Click **Edit (pencil icon)**
3. Click **Mailbox Delegation**
4. Under **Full Access** → Click **+** → Add `jsmith`
5. Under **Send As** → Click **+** → Add `jsmith`
6. Click **Save**

### PowerShell (Exhange Management Shell)

```powershell
# Grant Full Access to shared mailbox
Add-MailboxPermission -Identity "itsupport" `
    -User "jsmith" `
    -AccessRights FullAccess `
    -InheritanceType All `
    -AutoMapping $true

# Grant Send on Behalf
Set-Mailbox -Identity "itsupport" `
    -GrantSendOnBehalfTo "jsmith"

# Verify permissions
Get-MailboxPermission -Identity "itsupport" | Where {$_.User -notlike "NT AUTHORITY*"}
Get-RecipientPermission -Identity "itsupport" | Where {$_.Trustee -notlike "NT AUTHORITY*"}
```

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/45f5092b-5015-41cd-bdc4-82f423848950" />

---

## Exercise 1.3 — Set Mailbox Quotas

### GUI Steps
1. EAC → **Recipients** → **Mailboxes** → Select a mailbox → **Edit**
2. Click **Mailbox Usage**
3. Uncheck **"Use mailbox database defaults"**
4. Set:

| Quota | Value |
|---|---|
| Issue warning at | 1.9 GB |
| Prohibit send at | 2 GB |
| Prohibit send and receive at | 2.5 GB |

5. Click **Save**

### PowerShell (Exhange Management Shell)

```powershell
# Set mailbox quota for a single user
Set-Mailbox -Identity "jsmith" `
    -IssueWarningQuota 1.9GB `
    -ProhibitSendQuota 2GB `
    -ProhibitSendReceiveQuota 2.5GB `
    -UseDatabaseQuotaDefaults $false

# Set quota for ALL mailboxes in bulk
Get-Mailbox -ResultSize Unlimited | Set-Mailbox `
    -IssueWarningQuota 1.9GB `
    -ProhibitSendQuota 2GB `
    -ProhibitSendReceiveQuota 2.5GB `
    -UseDatabaseQuotaDefaults $false

# Check mailbox sizes and quota status
Get-MailboxStatistics -Identity "jsmith" |
    Select DisplayName, TotalItemSize, ItemCount, StorageLimitStatus
```

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/80db3df9-4ec4-4180-a861-82e584de664c" />

---

## Exercise 1.4 — Add Email Aliases

### GUI Steps
1. EAC → **Recipients** → **Mailboxes** → Select user → **Edit**
2. Click **Email Address**
3. Click **+** → Enter alias: `john.smith@yourdomain.com`
4. Click **OK** → **Save**

### PowerShell (Exhange Management Shell)

```powershell
# Add email alias
Set-Mailbox -Identity "jsmith" `
    -EmailAddresses @{Add="john.smith@yourdomain.com"}

# View all email addresses
Get-Mailbox -Identity "jsmith" | Select -ExpandProperty EmailAddresses

# Set a new primary SMTP address
Set-Mailbox -Identity "jsmith" `
    -PrimarySmtpAddress "john.smith@yourdomain.com"
```
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/a2ec26e1-5e95-4139-aa65-bc6a803b16b6" />

---

## Exercise 1.5 — Create Distribution Groups

### GUI Steps
1. EAC → **Recipients** → **Groups** → **+** → **Distribution Group**
2. Fill in:

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/5c458fd2-be36-4293-a8b8-c2ef80b047e4" />

| Field | Value |
|---|---|
| Display name | IT Team |
| Alias | itteam |
| Email | itteam@yourdomain.com |
| Members | Add jsmith and other users |
| Owner | labadmin |

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/25ec2445-b6ac-4db2-b535-72d3de5491ff" />

3. Restrict members joining and leaving

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/fa73507e-d1f9-4ebe-bbf0-0b64b99ea716" />

4.  Click **Save**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/7b6b4a3e-1252-42ce-8968-9c03bb2d93f1" />

### PowerShell (Exhange Management Shell)

```powershell
# Create Distribution Group
New-DistributionGroup -Name "IT Team" `
    -Alias "itteam" `
    -PrimarySmtpAddress "itteam@yourdomain.com" `
    -MemberJoinRestriction Closed

# Add members
Add-DistributionGroupMember -Identity "itteam" -Member "jsmith"

# Create Dynamic Distribution Group (auto-membership based on filter)
New-DynamicDistributionGroup -Name "All Mailboxes" `
    -Alias "allmailboxes" `
    -PrimarySmtpAddress "all@yourdomain.com" `
    -RecipientFilter {RecipientType -eq 'UserMailbox'}

# Verify group members
Get-DistributionGroupMember -Identity "itteam" | Select Name, PrimarySmtpAddress
```

---
