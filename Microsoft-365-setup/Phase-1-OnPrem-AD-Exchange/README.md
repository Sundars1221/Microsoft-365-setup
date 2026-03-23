# Phase 1: On-Premises AD & Exchange Server Setup ✅

## Overview
This phase covers setting up the on-premises infrastructure including:
- Promoting Lab-DC01 as a Domain Controller
- Installing and configuring Exchange Server 2019 on Lab-EX01

**Status: ✅ Complete**

---

## Prerequisites
- Lab-DC01 and Lab-EX01 VMs running in Azure
- Both VMs on the same VNet (Lab-VNet)
- Static private IPs assigned (DC: 10.0.1.4, Exchange: 10.0.1.5)

---

## Part A: Domain Controller Setup (Lab-DC01)

### Step 1: Install AD DS Role
1. Open **Server Manager** → **Manage** → **Add Roles and Features**
2. Select **Role-based or feature-based installation**
3. Check **Active Directory Domain Services**
4. Click **Add Features** → **Install**

### Step 2: Promote to Domain Controller
1. Click the **⚠️ yellow flag** in Server Manager
2. Click **"Promote this server to a domain controller"**
3. Select **"Add a new forest"**
4. Configure settings:

| Setting | Value |
|---|---|
| Root domain name | corp.lab |
| Forest functional level | Windows Server 2016 |
| Domain functional level | Windows Server 2016 |
| DNS Server | ✅ Enabled |
| DSRM Password | (save securely) |

5. Click through wizard → **Install** → Server reboots automatically

### Step 3: Raise Forest & Domain Functional Level
1. Open **Active Directory Domains and Trusts**
2. Right-click root node → **Raise Forest Functional Level** → Windows Server 2016
3. Right-click domain → **Raise Domain Functional Level** → Windows Server 2016

### Step 4: Create OU & Test Users
1. Open **Active Directory Users and Computers**
2. Right-click domain → **New** → **Organizational Unit** → Name: `LabUsers`
3. Right-click LabUsers → **New** → **User** → Fill in details

---

## Part B: Exchange Server Setup (Lab-EX01)

### Step 5: Set DNS & Join Domain
1. Set preferred DNS to `10.0.1.4` (DC private IP) in network adapter settings
2. Right-click **Start** → **System** → **Rename this PC (advanced)**
3. Join domain `corp.lab` with `CORP\labadmin` credentials → Reboot

### Step 6: Install Prerequisites
1. Open **Server Manager** → **Add Roles and Features**
2. Install **Web Server (IIS)** with all default sub-features
3. Download and install **.NET Framework 4.8**
4. Reboot if prompted

### Step 7: Download & Mount Exchange ISO
1. Download Exchange Server 2019 Trial from Microsoft
2. Right-click ISO → **Mount** (mounts as D:\ drive)

### Step 8: Prepare Active Directory
Run in **PowerShell as Administrator** logged in as `CORP\labadmin`:

```powershell
# Prepare Schema
D:\Setup.exe /PrepareSchema /IAcceptExchangeServerLicenseTerms_DiagnosticDataOFF

# Prepare AD
D:\Setup.exe /PrepareAD /OrganizationName:"LabOrg" /IAcceptExchangeServerLicenseTerms_DiagnosticDataOFF

# Prepare All Domains
D:\Setup.exe /PrepareAllDomains /IAcceptExchangeServerLicenseTerms_DiagnosticDataOFF
```

### Step 9: Install Exchange Server 2019
1. Run **Setup.exe** from mounted ISO
2. Wizard settings:

| Setting | Value |
|---|---|
| Check for updates | Skip (lab) |
| Server role | Mailbox Role ✅ |
| Install path | C:\Program Files\Microsoft\Exchange Server\V15 |
| Malware scanning | Disabled (lab) |

3. Click **Install** — takes 45–90 minutes

### Step 10: Verify Exchange
1. Open browser → Go to `https://localhost/ecp`
2. Login with `CORP\labadmin`
3. Exchange Admin Center should load ✅
4. Create test mailbox: **Recipients** → **Mailboxes** → **+**

---

## 🐛 Errors Encountered & Fixes

| Error | Cause | Fix |
|---|---|---|
| Invalid credential EX-01\EX-01 | Logged in with local account | Re-login as `CORP\labadmin` |
| Not in Schema/Enterprise Admins | Missing AD group membership | Added labadmin to Schema Admins, Enterprise Admins, Domain Admins on DC01 |
| AD can't be contacted | DNS not pointing to DC | Set DNS to 10.0.1.4 on EX01 NIC |
| Forest functional level too low | Set wrong level during promo | Raised to Windows Server 2016 in AD Domains & Trusts |

---

## ✅ Phase 1 Checklist

- [x] AD DS role installed on DC01
- [x] DC01 promoted to Domain Controller
- [x] Forest & Domain functional level set to 2016
- [x] LabUsers OU created
- [x] Test user created
- [x] EX01 joined to domain
- [x] Exchange prerequisites installed
- [x] AD schema prepared for Exchange
- [x] Exchange 2019 installed
- [x] Exchange Admin Center accessible
- [x] Test mailbox created
