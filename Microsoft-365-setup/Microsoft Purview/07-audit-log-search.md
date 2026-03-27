# Lab 6 — Audit Log Search

## Objective
Search, filter, and export audit records in Microsoft Purview Audit. Microsoft states that **Audit (Standard)** and **Audit (Premium)** give organizations access to critical audit log event data to investigate user activities and monitor security and compliance. citeturn2search145turn2search146

## Why this lab matters
Audit is essential for forensic investigation, operational validation, and compliance reporting. Microsoft also documents a dedicated learning path, **Audit and search activity in Microsoft Purview**, that combines audit logging with content search and investigation scenarios. citeturn2search149turn2search94

## Recommended learning assets
- **Audit and search activity in Microsoft Purview** learning path. citeturn2search149turn2search94
- **Microsoft Purview: Audit Log Monitoring in Microsoft 365** — course covering audit search, audit policies, mailbox auditing, and Microsoft Graph / API integrations. citeturn2search86

## Prerequisites
- Assignment to the **Audit Logs** or **View-Only Audit Logs** role. Microsoft states these roles are required to search the audit log. citeturn2search145turn2search146
- Access to the Microsoft Purview portal and audit search UI. citeturn2search145
- Exchange Online PowerShell access if you want to verify audit logging with the documented command. citeturn2search145

## Steps
1. Confirm you have the correct audit roles. Microsoft says admins and investigators must be assigned **View-Only Audit Logs** or **Audit Logs** to search or export the audit log. citeturn2search145turn2search146
2. Verify that audit log search is enabled. Microsoft documents the command **Get-AdminAuditLogConfig | Format-List UnifiedAuditLogIngestionEnabled** in **Exchange Online PowerShell** as the verification method. citeturn2search145
3. Open **Microsoft Purview Audit** and start a search job. Microsoft states that search jobs started through the Purview portal continue running even if the browser window is closed, and completed search jobs are retained for 30 days. citeturn2search145
4. Apply filters such as date range, user, or operation to scope the search. Microsoft recommends narrowing scope when necessary and notes that wide searches can produce incomplete exports if limits are exceeded. citeturn2search147
5. Export results to CSV if required. Microsoft documents export limits of up to **50,000** results for Audit (Standard) and **100,000** for Audit (Premium), with guidance to segment searches if needed. citeturn2search147
6. If you need a list of auditable activities, review **Audit log activities**, where Microsoft lists operation names and friendly names searchable in the audit log. citeturn2search150

## Validation
- Confirm that an audit search job runs successfully from the Purview portal. citeturn2search145
- Confirm that you can export the results to CSV if your test scenario requires it. citeturn2search147
- Document which filters and operations you used so that the lab is repeatable. Microsoft explicitly supports filtering and operation-based searches. citeturn2search145turn2search150

## Expected result
At the end of this lab, you can run a repeatable audit search, understand the role requirements, verify audit logging, and export results when needed. citeturn2search145turn2search146turn2search147

## Lessons learned
Audit is strongest when the search scope is intentional. Microsoft’s export guidance shows that broad searches can be harder to manage, which reinforces the value of using targeted filters and well-defined search questions. citeturn2search147
