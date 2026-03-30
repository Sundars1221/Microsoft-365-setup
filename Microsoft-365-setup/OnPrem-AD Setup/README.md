# Phase 1: On-Premises AD Setup

## Overview
This phase covers setting up the on-premises infrastructure including:
- Installing Active Directory Domain Services
- Promoting Lab-DC01 as a Domain Controller
- Creating OUs/Users/Groups
---

## Domain Controller Setup

### Step 1: Install AD DS Role
1. Open **Server Manager** → **Manage** → **Add Roles and Features**

    <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/e577cda1-eabe-43c3-99f3-4c8317de44cb" />
   
2. Select **Role-based or feature-based installation**
   
   <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/a9c1e942-9190-48ec-9847-f6b2f10958af" />
   
   <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/20405dc9-cd53-4cd7-bc07-2522aa86b3c2" />
   
   <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/3a5888c6-2c90-4a31-b79b-59266df385f3" />
   
3. Check **Active Directory Domain Services**

   <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/43dab105-e3b2-414f-adb6-a949f50d458a" />
   
4. Click **Add Features** → **Install**
   
   <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/23e51178-07e6-4976-89d6-6d4a6adf6090" />
   
   <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/28e2eebc-954d-4b0f-8a4d-32945387148e" />
   
   <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/e1ceb185-bb3c-4cac-9b14-499f5f6c3753" />

### Step 2: Promote to Domain Controller
1. Click the **⚠️ yellow flag** in Server Manager
2. Click **"Promote this server to a domain controller"**

   <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/b7990653-f370-4e67-96ca-e3b80905a78d" />
   
3. Select **"Add a new forest"**

   <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/a8d7e43f-4f36-4cae-943c-33db502d7e42" />

4. Configure settings:
   - set password
   - skip DNS delegation
   - specify default paths
   - review options and pre-requisite checks

| Setting | Value |
|---|---|
| Root domain name | torvexis.xyz |
| Forest functional level | Windows Server 2016 |
| Domain functional level | Windows Server 2016 |
| DNS Server | ✅ Enabled |
| DSRM Password | (save securely) |

   <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/e14ee494-a72f-4ea2-9914-ca50bf0023cf" />
   
   <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/b4122875-3fef-436c-998e-5dbbd2c974df" />
   
   <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/42b63623-22ce-468f-afe1-1231bcb2d30c" />

5. Click through wizard → **Install** → Server reboots automatically

## Step 3: Create OU, Users, and Groups 
1. Open **Active Directory Users and Computers**

   <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/4ff1e7b4-c69f-48bb-9a20-efe1ed16f161" />
  
2. Right-click domain → **New** → **Organizational Unit** → Name: `LabUsers`
   
   <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/522b1587-e27f-4224-932c-074f181834b2" />

   <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/1f6e1e8f-de42-407c-a072-95e5e03e4a46" />
   
3. Right-click LabUsers → **New** → **User** → Fill in details
   
   <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/e0a47354-45a7-425f-89d3-5c4bf010615f" />
   
   <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/e7e99cad-fd6b-4a41-8c59-74c8a2eeb7f3" />
   
   <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/2d82d2c0-28af-4525-940d-3fbd21a61dd4" />
   
   <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/07b1aabd-5529-4a54-abb7-123f05795a90" />
   
   <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/c2e94f07-7eec-40ee-8e44-83a57a3a6341" />

4. For bulk addition of user's refer PowerShell Script section
   
   <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/d386a893-0c80-4c38-b855-54fc05642b8b" />

5. Right-click LabUsers → **New** → **Group** → Choose either Security/Distribution
   
   <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/e3f8fc3e-7b21-413c-8155-10875abed8fd" />
   
   <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/2e75427f-bb2e-4197-a521-d363d83e69e6" />
  
6. Right-click Group1Security → **Propreties** → **Members** -> **Add** -> to add new members to the group/modify object types/create dynamic membership etc
   
   <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/54f9816d-f3a6-4a97-ac0f-aa9167e3ee4e" />
   
   <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/53c36a11-785f-4567-80a7-652a6db6a70d" />
   
   <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/48e89698-d883-42cf-847b-989b8c25e04a" />
   
---

## Phase 2: Exchange Server Setup

## Overview
This phase covers setting up the on-premises infrastructure including:
- Installing pre-requsites for Exchange Server 2019
- Preparing Active Directory service for Exchange Sever 2019 Installation
- Installing and configuring Exchange Server 2019
- Creating test mailbox

### Step 1: Set DNS & Join Domain
1. Set preferred DNS to `10.0.1.4` (DC private IP) in network adapter settings

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/3f9f8f72-2754-41c8-9502-9d3bda9b8ac6" />

2. Right-click **Start** → **System** → **Rename this PC (advanced)**
3. Join domain `torvexis.xyz` with `Torvexis_Admin` credentials → Reboot

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/b55c4ca0-70ba-4e64-86fe-a84f6cf71d22" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/b25f384e-6fdd-4f45-9acc-a5567a8181ce" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/72ff59ec-3840-4e38-aa7b-012c3bbb8b3c" />

### Step 2: Install Prerequisites

```https://learn.microsoft.com/en-us/exchange/plan-and-deploy/prerequisites```

1. Open **Server Manager** in Exchange server → **Add Roles and Features**
2. Install **Web Server (IIS)** with all default sub-features

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/a726e42e-5d31-4cca-b579-8d8b4585560d" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/bcbd7b08-2425-4bd0-96e7-8e906b3a253c" />

3. Download and install **.NET Framework 4.8** (optional, installs along with IIS role & feautures)
4. Download and install **Visual C++ Redistributable Package for Visual Studio 2012/2013**
5. Download and install **Unified Communications Managed API 4.0.**
6. Download and install **IIS URL Rewrite Module**
7. Reboot the machine

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/76a2bad2-760c-429a-a349-53dd750f67de" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/1f65ab1e-a858-42c2-9c03-2b32eba87ca4" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/f9742fb9-7146-4819-8610-b4b455a73c8d" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/c17844ce-23ab-4551-9eeb-11b880e820d7" />

7. Install the Remote Server Administration Tools (RSAT) for Active Directory Domain Services (ADDS) on DC
   
```PowerShell
Install-WindowsFeature RSAT-ADDS
```

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/001311d5-59b5-44e5-9abd-ba5845648045" />

8. Prepare server for installation

```PowerShell
Install-WindowsFeature Server-Media-Foundation, NET-Framework-45-Core, NET-Framework-45-ASPNET, NET-WCF-HTTP-Activation45, NET-WCF-Pipe-Activation45, NET-WCF-TCP-Activation45, NET-WCF-TCP-PortSharing45, RPC-over-HTTP-proxy, RSAT-Clustering, RSAT-Clustering-CmdInterface, RSAT-Clustering-Mgmt, RSAT-Clustering-PowerShell, WAS-Process-Model, Web-Asp-Net45, Web-Basic-Auth, Web-Client-Auth, Web-Digest-Auth, Web-Dir-Browsing, Web-Dyn-Compression, Web-Http-Errors, Web-Http-Logging, Web-Http-Redirect, Web-Http-Tracing, Web-ISAPI-Ext, Web-ISAPI-Filter, Web-Metabase, Web-Mgmt-Console, Web-Mgmt-Service, Web-Net-Ext45, Web-Request-Monitor, Web-Server, Web-Stat-Compression, Web-Static-Content, Web-Windows-Auth, Web-WMI, Windows-Identity-Foundation, RSAT-ADDS
```

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/62b4c971-77e2-497c-8137-30c2cde2f0ed" />

### Step 3: Download & Mount Exchange ISO

```
https://learn.microsoft.com/en-us/exchange/new-features/build-numbers-and-release-dates
```
1. Download Exchange Server 2019 CU 11 from Microsoft Download center

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/72631411-b969-47d4-aba1-3e1a0c43c314" />

2. Right-click ISO → **Mount**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/9b8d2ec0-e404-4888-a355-b409bddcf412" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/056ee000-175d-4f42-bd19-e1098c05d5ee" />

### Step 4: Prepare Active Directory
Run in **PowerShell as Administrator** logged in as `Torvexis\Torvexis_Admin`:

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/10cf9410-7528-4770-b7e5-73bf848def9d" />

```powershell
# Prepare Schema
E:\Setup.exe /IAcceptExchangeServerLicenseTerms_DiagnosticDataOFF /PrepareSchema

# Prepare AD
D:\Setup.exe /PrepareAD /OrganizationName:"LabOrg" /IAcceptExchangeServerLicenseTerms_DiagnosticDataOFF

# Prepare All Domains
D:\Setup.exe /PrepareAllDomains /IAcceptExchangeServerLicenseTerms_DiagnosticDataOFF
```
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/770e77d3-7dda-428f-9570-c40c31384ecb" />

### Step 9: Install Exchange Server 2019
1. Run **Setup.exe** from mounted ISO

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/6643a998-32cc-4b67-8575-2ebe5ad4be89" />

2. Wizard settings:

| Setting | Value |
|---|---|
| Check for updates | Skip |
| Server role | Mailbox Role ✅ |
| Install path | C:\Program Files\Microsoft\Exchange Server\V15 |
| Malware scanning | Disabled |

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/4fba00b5-1161-411c-93a1-79b3455c783f" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/d4974982-204c-4782-9506-03e9ab2daa25" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/6e20a19a-1356-45e6-9bcb-8b6cafd44697" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/b143d220-27e8-47c6-b4ad-9f2d9c4f901b" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/f97314e2-52af-46fd-813f-e31d9b1fb808" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/df06ec32-c843-4435-8757-7e3508bfdcde" />

3. Click **Install** — takes 45–90 minutes

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/0c00b35e-a6b0-4863-ab12-e10a92e2359f" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/16ff4f82-b027-473c-a1d3-d646b58d4a57" />

### Step 10: Verify Exchange
1. Open browser → Go to `https://localhost/ecp`
2. Login with `Torvexis\Torvexis_Admin`
3. Exchange Admin Center should load ✅
4. Create test mailbox: **Recipients** → **Mailboxes** → **+**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/bc9cdf38-7f19-43a8-a991-74ed2b550ff7" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/26fa0e7d-b39c-45d3-a868-2ec43e7a0a54" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/88af23bd-ba25-41f6-82c8-b1ec3b38777f" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/75be06a0-9450-496e-863b-11930a6d0a01" />

---
