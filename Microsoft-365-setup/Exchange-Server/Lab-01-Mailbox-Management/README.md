# Lab 01: Mailbox Management 📬

**Difficulty**: ⭐ Beginner
**Duration**: 60–90 mins
**MS-203 Domain**: Manage Organizational Settings and Resources (30–35%)

## 🎯 What You'll Learn
- Create and manage user, shared, room, and equipment mailboxes
- Configure mailbox permissions and delegation
- Set mailbox quotas and limits
- Manage distribution groups and M365 groups
- Configure email aliases

---

## Exercise 1.1 — Create Different Mailbox Types

### GUI Steps (Exchange Admin Center)

**User Mailbox:**
1. Go to `https://localhost/ecp` (on-prem) or `https://admin.exchange.microsoft.com` (online)
2. **Recipients** → **Mailboxes** → Click **+** → **User Mailbox**
3. Fill in:

| Field | Value |
|---|---|
| First name | John |
| Last name | Smith |
| User logon name | jsmith@yourdomain.com |
| Password | YourStr0ngP@ssword! |
| Mailbox database | (leave default) |

4. Click **Save**

**Shared Mailbox:**
1. **Recipients** → **Mailboxes** → **+** → **Shared Mailbox**
2. Fill in:

| Field | Value |
|---|---|
| Display name | IT Support |
| Email address | itsupport@yourdomain.com |

3. Click **Save** → Add members who need access

**Room Mailbox:**
1. **Recipients** → **Resources** → **+** → **Room Mailbox**
2. Fill in:

| Field | Value |
|---|---|
| Room name | Conference Room A |
| Email address | confrooma@yourdomain.com |
| Capacity | 20 |

3. Click **Save**

### PowerShell

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

---

## Exercise 1.2 — Configure Mailbox Permissions & Delegation

### GUI Steps
1. Open EAC → **Recipients** → **Mailboxes**
2. Select **IT Support** shared mailbox → Click **Edit (pencil icon)**
3. Click **Mailbox Delegation**
4. Under **Full Access** → Click **+** → Add `jsmith`
5. Under **Send As** → Click **+** → Add `jsmith`
6. Click **Save**

### PowerShell

```powershell
# Grant Full Access to shared mailbox
Add-MailboxPermission -Identity "itsupport" `
    -User "jsmith" `
    -AccessRights FullAccess `
    -InheritanceType All `
    -AutoMapping $true

# Grant Send As permission
Add-RecipientPermission -Identity "itsupport" `
    -Trustee "jsmith" `
    -AccessRights SendAs `
    -Confirm:$false

# Grant Send on Behalf
Set-Mailbox -Identity "itsupport" `
    -GrantSendOnBehalfTo "jsmith"

# Verify permissions
Get-MailboxPermission -Identity "itsupport" | Where {$_.User -notlike "NT AUTHORITY*"}
Get-RecipientPermission -Identity "itsupport" | Where {$_.Trustee -notlike "NT AUTHORITY*"}
```

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

### PowerShell

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

---

## Exercise 1.4 — Add Email Aliases

### GUI Steps
1. EAC → **Recipients** → **Mailboxes** → Select user → **Edit**
2. Click **Email Address**
3. Click **+** → Enter alias: `john.smith@yourdomain.com`
4. Click **OK** → **Save**

### PowerShell

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

---

## Exercise 1.5 — Create Distribution Groups

### GUI Steps
1. EAC → **Recipients** → **Groups** → **+** → **Distribution Group**
2. Fill in:

| Field | Value |
|---|---|
| Display name | IT Team |
| Alias | itteam |
| Email | itteam@yourdomain.com |
| Members | Add jsmith and other users |
| Owner | labadmin |

3. Click **Save**

### PowerShell

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

## ✅ Lab 01 Checklist

- [ ] User mailbox created
- [ ] Shared mailbox created with Full Access and Send As permissions
- [ ] Room and Equipment mailboxes created
- [ ] Mailbox quotas configured
- [ ] Email alias added
- [ ] Distribution group created
- [ ] Dynamic distribution group created
- [ ] All tasks completed via PowerShell

---

## 💡 Key Exam Tips (MS-203)
- Know the difference between **Send As**, **Send on Behalf**, and **Full Access**
- **Dynamic Distribution Groups** use recipient filters — members are resolved at send time
- Shared mailboxes don't need a license unless mailbox exceeds 50GB
- Room mailboxes can be configured for **auto-accept** of meeting requests
