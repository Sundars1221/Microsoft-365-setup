# Microsoft 365 Hybrid Lab Setup 🏗️

A step-by-step documentation of setting up a full Microsoft 365 hybrid environment using Azure VMs, on-premises Active Directory, Exchange Server 2019, and Azure AD Connect.

---

## 📋 Lab Overview

| Component | Details |
|---|---|
| Cloud Platform | Microsoft Azure (Trial) |
| M365 Plan | Microsoft 365 E3/E5 |
| On-Prem OS | Windows Server 2022 Datacenter |
| Exchange Version | Exchange Server 2019 |
| Sync Tool | Azure AD Connect |
| Hybrid Type | Classic Hybrid |

---

## 🗺️ Architecture

```
┌─────────────────────────────────┐         ┌──────────────────────────────┐
│        Azure VMs (VNet)         │         │     Microsoft 365 Tenant     │
│                                 │         │                              │
│  ┌──────────┐  ┌─────────────┐  │◄───────►│  ┌─────────┐  ┌──────────┐  │
│  │ Lab-DC01 │  │  Lab-EX01   │  │  AAD    │  │ Azure   │  │ Exchange │  │
│  │  AD DS   │  │  Exchange   │  │ Connect │  │   AD    │  │  Online  │  │
│  │  DNS     │  │   2019      │  │  Sync   │  │         │  │          │  │
│  └──────────┘  └─────────────┘  │         │  └─────────┘  └──────────┘  │
│   10.0.1.4       10.0.1.5       │         │                              │
└─────────────────────────────────┘         └──────────────────────────────┘
```

---

## 📁 Repository Structure

```
Microsoft-365-setup/
│
├── README.md                          # This file — full lab overview & progress
│
├── Phase-1-OnPrem-AD-Exchange/
│   ├── README.md                      # Phase 1 detailed steps
│   ├── scripts/
│   │   ├── 01-install-adds.ps1        # Install AD DS role
│   │   ├── 02-promote-dc.ps1          # Promote to Domain Controller
│   │   ├── 03-create-ou-users.ps1     # Create OUs and test users
│   │   ├── 04-exchange-prereqs.ps1    # Install Exchange prerequisites
│   │   └── 05-exchange-ad-prep.ps1    # Prepare AD for Exchange
│   └── screenshots/                   # Add your screenshots here
│
├── Phase-2-Azure-AD-Connect/
│   ├── README.md                      # Phase 2 detailed steps
│   ├── scripts/
│   │   ├── 01-add-upn-suffix.ps1      # Add routable UPN suffix
│   │   ├── 02-update-user-upns.ps1    # Update user UPNs
│   │   └── 03-verify-sync.ps1         # Verify AAD Connect sync
│   └── screenshots/                   # Add your screenshots here
│
└── Phase-3-Hybrid-Exchange/
    ├── README.md                      # Phase 3 detailed steps (coming soon)
    ├── scripts/                       # Scripts coming soon
    └── screenshots/                   # Add your screenshots here
```

---

## ✅ Progress Tracker

| Phase | Task | Status |
|---|---|---|
| **Phase 0** | Azure VM Setup | ✅ Complete |
| **Phase 0** | VNet + NSG Configuration | ✅ Complete |
| **Phase 0** | Static IPs Assigned | ✅ Complete |
| **Phase 1** | AD DS Role Installed | ✅ Complete |
| **Phase 1** | DC01 Promoted to Domain Controller | ✅ Complete |
| **Phase 1** | Exchange 2019 Installed | ✅ Complete |
| **Phase 1** | Test Mailbox Created | ✅ Complete |
| **Phase 2** | Custom Domain Verified in M365 | ✅ Complete |
| **Phase 2** | UPN Suffix Added & Users Updated | ✅ Complete |
| **Phase 2** | Azure AD Connect Installed & Syncing | ✅ Complete |
| **Phase 3** | Hybrid Configuration Wizard | 🔄 In Progress |
| **Phase 3** | Mail Flow Configured | ⬜ Pending |
| **Phase 3** | Test Mailbox Migration | ⬜ Pending |

---

## 🖥️ VM Configuration

| VM Name | Role | Size | Private IP | OS |
|---|---|---|---|---|
| Lab-DC01 | Domain Controller + DNS | Standard_B2ms | 10.0.1.4 | Windows Server 2022 |
| Lab-EX01 | Exchange Server 2019 | Standard_D4s_v3 | 10.0.1.5 | Windows Server 2022 |

---

## 🔗 Useful Links

- [Exchange Server 2019 Trial Download](https://www.microsoft.com/en-us/download/details.aspx?id=105253)
- [Azure AD Connect Download](https://www.microsoft.com/en-us/download/details.aspx?id=47594)
- [Hybrid Configuration Wizard](https://aka.ms/hybridwizard)
- [Microsoft 365 Admin Center](https://admin.microsoft.com)
- [Azure Portal](https://portal.azure.com)

---

## 📝 Notes

- Auto-shutdown enabled on both VMs at 8PM to save Azure trial credits
- Always start **Lab-DC01 first** before starting Lab-EX01
- Snapshots taken after each phase for rollback capability
- Using Password Hash Sync for Azure AD Connect (recommended for lab)
