# Microsoft Purview — Hands-On Lab Guide

> **10 practical labs** covering Data Governance, Compliance & Information Protection.  
> Designed for use with your own **Microsoft 365 test tenant**. No production risk.

---

## Overview

| Metric | Value |
|--------|-------|
| Total labs | 10 |
| Total lab time | ~14 hours |
| Skill levels | Foundational → Expert |
| Environment | M365 test tenant |

---

## Lab Index

| # | Lab | Skill Area | Duration | Level |
|---|-----|-----------|----------|-------|
| 01 | [Sensitivity Labels & Information Classification](./lab-01-sensitivity-labels/README.md) | MIP / Labels | 75 min | Foundational |
| 02 | [Data Loss Prevention (DLP) Policies](./lab-02-dlp/README.md) | DLP | 90 min | Core |
| 03 | [Insider Risk Management](./lab-03-insider-risk/README.md) | Insider Risk | 90 min | Advanced |
| 04 | [eDiscovery & Audit Investigations](./lab-04-ediscovery/README.md) | eDiscovery | 75 min | Core |
| 05 | [Retention Policies & Labels](./lab-05-retention/README.md) | Records Mgmt | 60 min | Core |
| 06 | [Communication Compliance](./lab-06-communication-compliance/README.md) | Comm. Compliance | 60 min | Advanced |
| 07 | [Data Map, Catalog & Lineage](./lab-07-data-map-catalog/README.md) | Data Governance | 90 min | Advanced |
| 08 | [Compliance Manager & Score Improvement](./lab-08-compliance-manager/README.md) | Compliance Mgr | 60 min | Foundational |
| 09 | [PowerShell & Graph API Automation](./lab-09-powershell-automation/README.md) | Automation | 90 min | Expert |
| 10 | [AI Governance with Microsoft Copilot](./lab-10-ai-governance/README.md) | AI Governance | 75 min | Expert |

---

## Recommended Learning Path

```
Start here
    │
    ▼
[Lab 01] Sensitivity Labels        ← Build the label taxonomy everything else depends on
    │
    ▼
[Lab 02] DLP Policies              ← Use labels to power DLP rules
    │
    ▼
[Lab 05] Retention                 ← Content lifecycle management
    │
    ├──▶ [Lab 03] Insider Risk     ← Advanced threat detection
    │         │
    │         ▼
    │    [Lab 04] eDiscovery       ← Investigate and hold content
    │
    ├──▶ [Lab 06] Comm. Compliance ← Regulatory communication monitoring
    │
    ├──▶ [Lab 08] Compliance Mgr   ← Measure and improve your posture
    │         │
    │         ▼
    │    [Lab 09] PowerShell       ← Automate governance at scale
    │
    └──▶ [Lab 07] Data Map         ← Multi-cloud data governance
              │
              ▼
         [Lab 10] AI Governance    ← Govern Microsoft Copilot
```

---

## Prerequisites

- Microsoft 365 **E3 or E5** test tenant (or Developer tenant from [M365 Dev Program](https://developer.microsoft.com/en-us/microsoft-365/dev-program))
- **Global Admin** or **Compliance Admin** role assigned
- Microsoft 365 Apps installed locally (Word, Outlook) for Office app labs
- For Labs 3, 6, 10: **M365 E5** or add-on licenses required
- For Lab 7: An **Azure subscription** to create a Microsoft Purview account
- For Lab 9: **PowerShell 7+** and `ExchangeOnlineManagement` module

---

## Key Portal URLs

| Portal | URL |
|--------|-----|
| Microsoft Purview (unified) | https://purview.microsoft.com |
| Microsoft 365 Admin Center | https://admin.microsoft.com |
| Azure Portal | https://portal.azure.com |
| Entra ID | https://entra.microsoft.com |
| Microsoft Defender | https://security.microsoft.com |
| Purview Demo Environment | https://aka.ms/PurviewDemo |
| Graph Explorer | https://developer.microsoft.com/en-us/graph/graph-explorer |

---

## Certification Mapping

| Certification | Relevant Labs |
|--------------|--------------|
| SC-900 — Security, Compliance & Identity Fundamentals | 01, 02, 05, 08 |
| **SC-400 — Information Protection & Compliance Admin ⭐** | 01, 02, 03, 04, 05, 06, 09 |
| MS-102 — Microsoft 365 Administrator Expert | 01, 02, 05, 08 |
| SC-200 — Security Operations Analyst Associate | 02, 03, 04 |
| SC-100 — Cybersecurity Architect Expert | 03, 04, 07, 08, 10 |

> **SC-400** is the primary Purview certification. Start here for maximum career ROI.

---

## Repository Structure

```
purview-labs/
├── README.md                          ← This file
├── assets/
│   └── completion-tracker.md          ← Track your lab progress
├── lab-01-sensitivity-labels/
│   ├── README.md                      ← Full lab instructions
│   └── scripts/                       ← Helper scripts (where applicable)
├── lab-02-dlp/
│   ├── README.md
│   └── scripts/
... (same pattern for all labs)
└── lab-09-powershell-automation/
    ├── README.md
    └── scripts/
        ├── Get-PurviewInventory.ps1
        ├── New-DLPPolicyFromTemplate.ps1
        └── Export-DLPReport.ps1
```

---

## Contributing

Found a step that's changed or out of date? PRs welcome. Please test steps in a live tenant before submitting.

---

*Last updated: March 2026 | Microsoft Purview unified portal*
