# Lab 06: Permissions & Role-Based Access Control (RBAC) 🔐

**Difficulty**: ⭐⭐ Intermediate
**Duration**: 60–90 mins
**MS-203 Domain**: Manage Organizational Settings (30–35%)

## 🎯 What You'll Learn
- Understand Exchange RBAC model
- Assign admin roles in Exchange and M365
- Create custom management role groups
- Configure admin audit logging
- Delegate specific admin tasks

---

## Exercise 6.1 — Explore Default Role Groups

### GUI Steps
1. EAC (on-prem or online) → **Permissions** → **Admin Roles**
2. Review built-in role groups:

| Role Group | Purpose |
|---|---|
| Organization Management | Full Exchange admin |
| Recipient Management | Manage mailboxes and groups |
| Help Desk | View-only, reset passwords |
| Records Management | Compliance and retention |
| Discovery Management | Run eDiscovery searches |
| View-Only Organization Management | Read-only admin |

3. Click each to see what roles are assigned

### PowerShell

```powershell
# View all role groups
Get-RoleGroup | Select Name, Description | Format-Table -AutoSize

# View members of a specific role group
Get-RoleGroupMember -Identity "Recipient Management" | Select Name, RecipientType

# View all roles in a role group
Get-RoleGroup -Identity "Organization Management" |
    Select -ExpandProperty Roles
```

---

## Exercise 6.2 — Add a User to a Role Group

### GUI Steps
1. EAC → **Permissions** → **Admin Roles**
2. Select **Recipient Management** → Click **Edit (pencil)**
3. Under **Members** → Click **+** → Add `jsmith`
4. Click **Save**

### PowerShell

```powershell
# Add user to Recipient Management role group
Add-RoleGroupMember -Identity "Recipient Management" -Member "jsmith"

# Add user to Help Desk role group
Add-RoleGroupMember -Identity "Help Desk" -Member "jsmith"

# Remove user from a role group
Remove-RoleGroupMember -Identity "Help Desk" -Member "jsmith" -Confirm:$false

# Check what role groups a user is in
Get-RoleGroup | Where {
    (Get-RoleGroupMember $_.Name -ErrorAction SilentlyContinue).Name -contains "jsmith"
} | Select Name
```

---

## Exercise 6.3 — Create a Custom Role Group

Scenario: Create a helpdesk role that can only reset passwords and view mailbox info, but nothing else.

### GUI Steps
1. EAC → **Permissions** → **Admin Roles** → Click **+**
2. Configure:

| Field | Value |
|---|---|
| Name | Helpdesk - Password Reset Only |
| Description | Restricted helpdesk role for password resets |
| Roles | Add: Reset Password, User Options, View-Only Recipients |
| Members | Add: jsmith |

3. Click **Save**

### PowerShell

```powershell
# Create custom role group
New-RoleGroup -Name "Helpdesk - Password Reset Only" `
    -Description "Restricted helpdesk - password resets and view-only mailbox info" `
    -Roles "Reset Password","User Options","View-Only Recipients" `
    -Members "jsmith"

# Verify the role group
Get-RoleGroup -Identity "Helpdesk - Password Reset Only" |
    Select Name, Description
Get-RoleGroupMember -Identity "Helpdesk - Password Reset Only" | Select Name

# Create a role group with write scope (limit to specific OU)
New-ManagementScope -Name "LabUsers OU Scope" `
    -RecipientRestrictionFilter {RecipientType -eq 'UserMailbox'} `
    -RecipientRoot "corp.lab/LabUsers"

New-RoleGroup -Name "LabUsers Admins" `
    -Roles "Recipient Policies","Mail Recipients" `
    -CustomRecipientWriteScope "LabUsers OU Scope" `
    -Members "jsmith"
```

---

## Exercise 6.4 — Assign M365 Admin Roles

### GUI Steps
1. Go to `https://admin.microsoft.com`
2. **Users** → **Active Users** → Select a user
3. Click **Manage roles**
4. Select:

| Role | Use Case |
|---|---|
| Exchange Administrator | Manage Exchange Online |
| Global Reader | Read-only access to everything |
| User Administrator | Manage users and groups |
| Compliance Administrator | Manage compliance features |
| Security Administrator | Manage security features |

5. Click **Save changes**

### PowerShell

```powershell
# Connect to Azure AD / M365
Connect-MgGraph -Scopes "RoleManagement.ReadWrite.Directory"

# View available roles
Get-MgDirectoryRole | Select DisplayName, Description | Sort DisplayName

# Assign Exchange Administrator role
$role = Get-MgDirectoryRole | Where {$_.DisplayName -eq "Exchange Administrator"}
$user = Get-MgUser -Filter "userPrincipalName eq 'jsmith@yourdomain.com'"

New-MgDirectoryRoleMember -DirectoryRoleId $role.Id `
    -BodyParameter @{"@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/$($user.Id)"}

# View current admin role assignments for a user
Get-MgUserMemberOf -UserId $user.Id |
    Where {$_.AdditionalProperties["@odata.type"] -eq "#microsoft.graph.directoryRole"} |
    Select @{N="Role";E={$_.AdditionalProperties["displayName"]}}
```

---

## Exercise 6.5 — Enable and Review Admin Audit Logging

### GUI Steps
1. EAC (on-prem) → **Compliance Management** → **Auditing**
2. Click **Configure admin audit logging settings**
3. Ensure **"Enable admin audit logging"** is checked ✅
4. Set log age limit: **90 days**
5. Click **Save**

**Search audit logs:**
1. EAC → **Compliance Management** → **Auditing** → **Run an administrator audit log report**
2. Set date range → Click **Search**

### PowerShell

```powershell
# Enable admin audit logging (on-prem)
Set-AdminAuditLogConfig `
    -AdminAuditLogEnabled $true `
    -AdminAuditLogAgeLimit 90 `
    -AdminAuditLogCmdlets * `
    -AdminAuditLogParameters *

# Search audit logs
Search-AdminAuditLog `
    -StartDate (Get-Date).AddDays(-7) `
    -EndDate (Get-Date) `
    -ResultSize 100 |
    Select CreationDate, Caller, CmdletName, ObjectModified |
    Format-Table -AutoSize

# Search for specific admin actions (e.g., who changed mailbox permissions)
Search-AdminAuditLog `
    -Cmdlets "Add-MailboxPermission","Remove-MailboxPermission" `
    -StartDate (Get-Date).AddDays(-30) |
    Select CreationDate, Caller, CmdletName, ObjectModified, CmdletParameters

# Search M365 unified audit log
Search-UnifiedAuditLog `
    -StartDate (Get-Date).AddDays(-7) `
    -EndDate (Get-Date) `
    -Operations "Set-Mailbox","Add-MailboxPermission" `
    -ResultSize 100 |
    Select CreationDate, UserIds, Operations, AuditData |
    Format-Table -AutoSize
```

---

## ✅ Lab 06 Checklist

- [ ] Default role groups reviewed
- [ ] User added to Recipient Management role group
- [ ] Custom Helpdesk role group created with limited permissions
- [ ] Scoped role group created for specific OU
- [ ] M365 admin roles assigned via admin center
- [ ] Admin audit logging enabled
- [ ] Audit log searched for recent admin activities
- [ ] All tasks completed via PowerShell

---

## 💡 Key Exam Tips (MS-203)
- RBAC in Exchange uses **Role Groups → Roles → Role Entries** hierarchy
- **Management Scopes** limit what objects an admin can manage (e.g., specific OU)
- Always use **least privilege** — give only the minimum roles needed
- **Admin Audit Log** records all admin cmdlets run — critical for compliance
- Know the difference between Exchange RBAC roles and **M365 admin roles** (they are separate)
- **Discovery Management** role group is needed to run eDiscovery — NOT Organization Management
