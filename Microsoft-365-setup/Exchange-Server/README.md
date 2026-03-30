# 🏆 Exchange Server & Exchange Online — Lab Exercises

> **Built around real job market demands for 2026**
> Covers skills tested in **Microsoft MS-203 Messaging Administrator** certification

---

## 📊 Why These Labs? — Job Market Analysis

Based on current job postings and the MS-203 exam syllabus, these are the **top in-demand skills** employers are hiring for:

| Skill Area | Job Market Demand | Salary Impact |
|---|---|---|
| Hybrid Exchange & Migration | 🔥🔥🔥 Very High | +$15–25k |
| PowerShell Automation | 🔥🔥🔥 Very High | +$10–20k |
| Email Security (EOP/Defender) | 🔥🔥🔥 Very High | +$10–15k |
| Compliance & Retention | 🔥🔥 High | +$8–12k |
| Mail Flow & Transport Rules | 🔥🔥 High | +$5–10k |
| RBAC & Permissions | 🔥🔥 High | Standard |
| Mailbox Management | 🔥 Core | Standard |
| Troubleshooting | 🔥🔥🔥 Always | Differentiator |

**Salary Range**: $82k – $155k (US market, 2026)

---

## 🗺️ Lab Overview

| Lab | Topic | Difficulty | MS-203 Domain |
|---|---|---|---|
| Lab 01 | Mailbox Management | ⭐ Beginner | Organizational Settings |
| Lab 02 | Mail Flow & Transport Rules | ⭐⭐ Intermediate | Mail Architecture |
| Lab 03 | Email Security (EOP & Defender) | ⭐⭐⭐ Advanced | Secure Messaging |
| Lab 04 | Compliance & Retention | ⭐⭐ Intermediate | Organizational Settings |
| Lab 05 | Hybrid Migration | ⭐⭐⭐ Advanced | Hybrid & Migration |
| Lab 06 | Permissions & RBAC | ⭐⭐ Intermediate | Organizational Settings |
| Lab 07 | Troubleshooting | ⭐⭐⭐ Advanced | All Domains |
| Lab 08 | PowerShell Automation | ⭐⭐⭐ Advanced | All Domains |

---

## 🖥️ Lab Environment Requirements

| Component | Requirement |
|---|---|
| Lab-DC01 | Windows Server 2022, AD DS, DNS |
| Lab-EX01 | Windows Server 2022, Exchange Server 2019 |
| M365 Tenant | Microsoft 365 E3/E5 trial |
| Azure AD Connect | Installed and syncing on DC01 |
| Domain | Verified routable domain in M365 |

> ✅ Complete the [Microsoft-365-setup](../Microsoft-365-setup) labs first before starting these exercises.

---

## 📁 Folder Structure

```
Exchange-Lab-Exercises/
├── README.md                    ← This file
├── Lab-01-Mailbox-Management/
│   ├── README.md                ← Lab guide (GUI + PowerShell)
│   └── scripts/                 ← PowerShell scripts
├── Lab-02-Mail-Flow-Transport/
├── Lab-03-Email-Security-EOP/
├── Lab-04-Compliance-Retention/
├── Lab-05-Hybrid-Migration/
├── Lab-06-Permissions-RBAC/
├── Lab-07-Troubleshooting/
└── Lab-08-PowerShell-Automation/
```

---

## 🎯 Recommended Learning Path

```
Lab 01 (Mailbox) → Lab 06 (RBAC) → Lab 02 (Mail Flow)
       ↓
Lab 04 (Compliance) → Lab 03 (Security)
       ↓
Lab 05 (Hybrid Migration) → Lab 07 (Troubleshooting)
       ↓
Lab 08 (PowerShell Automation) ← Do this throughout all labs
```

---

## 📜 Certifications These Labs Prepare You For

- **MS-203**: Microsoft 365 Certified: Messaging Administrator Associate
- **MS-102**: Microsoft 365 Administrator
- **MCSE**: Messaging (legacy but still valued)

---

## 🔗 Useful Links

- [Exchange Admin Center (On-Prem)](https://localhost/ecp)
- [Exchange Admin Center (Online)](https://admin.exchange.microsoft.com)
- [Microsoft 365 Admin Center](https://admin.microsoft.com)
- [Azure Portal](https://portal.azure.com)
- [Microsoft Message Analyzer](https://learn.microsoft.com/en-us/exchange/mail-flow/test-smtp-with-telnet)
- [Remote Connectivity Analyzer](https://testconnectivity.microsoft.com)
