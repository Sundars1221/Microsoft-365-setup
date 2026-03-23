# Phase 2: Azure AD Connect Setup ✅

## Overview
This phase covers syncing on-premises Active Directory with Azure AD / Microsoft 365 using Azure AD Connect.

**Status: ✅ Complete**

---

## Prerequisites
- Phase 1 complete (AD + Exchange running)
- Microsoft 365 E3/E5 tenant ready
- Real/routable domain name owned and accessible
- labadmin is Domain Admin on corp.lab

---

## Part A: Prepare M365 Tenant

### Step 1: Add & Verify Custom Domain
1. Go to **https://admin.microsoft.com** → **Settings** → **Domains**
2. Click **+ Add domain** → Enter your domain name
3. Add the provided TXT record to your domain registrar's DNS:

| Field | Value |
|---|---|
| Type | TXT |
| Host | @ |
| Value | MS=msXXXXXXXX (provided by Microsoft) |
| TTL | 3600 |

4. Wait for DNS propagation → Click **Verify** in M365 admin

> 💡 Use https://dnschecker.org to verify TXT record is live before clicking Verify

### Step 2: Set Domain Purpose
- Enable **Exchange Online email** for the domain
- Skip DNS record setup (handled during Phase 3 hybrid config)

---

## Part B: Prepare On-Premises AD

### Step 3: Add Routable UPN Suffix
1. On **Lab-DC01** → Open **Active Directory Domains and Trusts**
2. Right-click root node → **Properties**
3. Under **Alternative UPN suffixes** → Add `yourdomain.com`
4. Click **Add** → **Apply** → **OK**

### Step 4: Update User UPNs
1. Open **Active Directory Users and Computers**
2. For each user → **Properties** → **Account** tab
3. Change UPN suffix from `@corp.lab` → `@yourdomain.com`

---

## Part C: Install Azure AD Connect

### Step 5: Download Azure AD Connect
- Download from: https://www.microsoft.com/en-us/download/details.aspx?id=47594
- Install on **Lab-DC01**

### Step 6: Configure Azure AD Connect Wizard

#### Sign-in Method
| Setting | Value |
|---|---|
| Method | Password Hash Sync ✅ |
| Single Sign-On | Enabled ✅ |

#### Connect to Azure AD
- Sign in with M365 Global Admin credentials

#### Connect Directories
- Forest: `corp.lab`
- Create new AD account using `CORP\labadmin`

#### Azure AD Sign-in Configuration
| Setting | Value |
|---|---|
| UPN Attribute | userPrincipalName |
| Verified domain | yourdomain.com ✅ |

#### OU Filtering
- Sync selected OUs only
- Check **LabUsers** OU only

#### Optional Features Enabled
| Feature | Enabled |
|---|---|
| Exchange hybrid deployment | ✅ |
| Password hash synchronization | ✅ |
| Password writeback | ✅ |

#### Final Settings
- Start sync when configuration completes: ✅
- Staging mode: Disabled

---

## Part D: Verify Sync

### Step 7: Verify in M365 Admin Center
1. Go to **https://admin.microsoft.com** → **Users** → **Active Users**
2. On-prem users should appear with source **"Synced from on-premises"** ✅

### Step 8: Verify in Azure Portal
1. Go to **https://portal.azure.com** → **Azure Active Directory** → **Users**
2. Users should show source as **"Windows Server AD"** ✅

### Step 9: Force Manual Sync (if needed)
```powershell
# Delta sync
Start-ADSyncSyncCycle -PolicyType Delta

# Full sync (first time)
Start-ADSyncSyncCycle -PolicyType Initial
```

### Step 10: Check Sync Health
Go to **Azure Portal** → **Azure Active Directory** → **Azure AD Connect**

| Item | Expected |
|---|---|
| Sync status | Enabled ✅ |
| Last sync | < 30 mins ago ✅ |
| Password Hash Sync | Enabled ✅ |
| Seamless SSO | Enabled ✅ |

---

## 🐛 Common Issues & Fixes

| Issue | Fix |
|---|---|
| Users not syncing | Ensure UPN suffix is @yourdomain.com not @corp.lab |
| Domain not verifying | Wait for DNS propagation, check with dnschecker.org |
| Sync errors | Open Synchronization Service Manager on DC01 |
| Password writeback failing | Ensure labadmin has Password Reset Administrator role in M365 |

---

## ✅ Phase 2 Checklist

- [x] Custom domain added & verified in M365
- [x] Routable UPN suffix added in AD
- [x] User UPNs updated to yourdomain.com
- [x] Azure AD Connect downloaded & installed on DC01
- [x] Password Hash Sync configured
- [x] Exchange Hybrid option enabled in AAD Connect
- [x] Single Sign-On enabled
- [x] Users visible in M365 Admin Center
- [x] Sync status healthy in Azure Portal
