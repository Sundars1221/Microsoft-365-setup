# Lab 11 — Adaptive Scopes in Microsoft Purview

**Duration:** 75 minutes | **Level:** Advanced | **Skill Area:** Records Management / Retention / DLP

---

## Overview

Adaptive scopes let you target retention policies, DLP policies, and sensitivity label policies to **dynamically-updated groups of users, sites, or mailboxes** — without manually maintaining static lists.

When a user changes department, or a SharePoint site's metadata changes, the scope updates automatically. This is the modern alternative to static scopes and is essential for large, dynamic organizations.

---

## Objectives

- Understand the difference between static and adaptive scopes
- Create adaptive scopes targeting users, SharePoint sites, and Microsoft 365 groups
- Apply adaptive scopes to retention policies and DLP policies
- Validate that scope membership updates dynamically
- Audit scope membership via PowerShell

## Learning Outcomes

| Outcome | Validated By |
|---------|-------------|
| Create user-based adaptive scope | Scope matches users by department attribute |
| Create site-based adaptive scope | Scope matches SharePoint sites by sensitivity label |
| Apply scope to retention policy | Policy applies only to scoped users/sites |
| Verify dynamic update | Adding a user to a department auto-adds them to the policy |

---

## Prerequisites

- [ ] Microsoft 365 **E5** or **M365 E5 Compliance** add-on
- [ ] Global Admin or Compliance Admin role
- [ ] Lab 01 (Sensitivity Labels) and Lab 05 (Retention) completed
- [ ] At least 2–3 test users with **Department** attribute set in Entra ID
- [ ] At least 2 SharePoint sites with different sensitivity labels applied

> **Why E5?** Adaptive scopes require the Microsoft Purview compliance portal features that ship with E5 or the Compliance add-on. Static scopes work on E3.

---

## Background — Static vs. Adaptive Scopes

| Feature | Static Scope | Adaptive Scope |
|---------|-------------|----------------|
| Membership update | Manual | Automatic (query-driven) |
| Targets | Fixed list of users/sites | Dynamic query (department, label, etc.) |
| Supported policies | All | Retention, DLP, Label policies |
| Setup complexity | Low | Medium |
| Best for | Small, stable groups | Large orgs, frequent org changes |

### How adaptive scopes work

```
Entra ID / SharePoint attributes
         │
         ▼
   Adaptive Scope Query
   (e.g., Department = "Finance")
         │
         ▼
   Dynamically-resolved members
   (auto-updates when attributes change)
         │
         ▼
   Retention / DLP / Label Policy
   (applied only to matching members)
```

---

## Section A — Prepare Test Data

Before creating scopes, set up attributes on your test users and sites.

### Step 1 — Set Department attributes on test users

1. Go to **https://entra.microsoft.com → Users → All users**
2. Open **Test User 1** → **Edit properties** → **Job info**
3. Set **Department:** `Finance`
4. Click **Save**

5. Open **Test User 2** → **Edit properties** → **Job info**
6. Set **Department:** `HR`
7. Click **Save**

8. Open **Test User 3** → set **Department:** `Finance`

> You now have 2 Finance users and 1 HR user — your adaptive scopes will target each department separately.

### Step 2 — Set attributes on SharePoint sites

Adaptive scopes for SharePoint sites can query on:
- Site name / URL pattern
- Sensitivity label applied to the site
- Site template type

1. Go to a SharePoint site used for Finance content
2. **Settings (gear icon) → Site information → Sensitivity**
3. Apply label: **Confidential - Finance** (from Lab 01)
4. Save

5. Repeat for your HR SharePoint site → apply **Confidential - HR**

---

## Section B — Create Adaptive Scopes

Navigate to **https://purview.microsoft.com → Solutions → Records Management → Adaptive scopes**

> Alternatively: **Data lifecycle management → Adaptive scopes**

### Step 1 — Create a user-based scope: Finance Department

1. Click **+ Create scope**
2. **Name:** `Finance Department Users`
3. **Description:** `All users with Department = Finance in Entra ID`
4. **Scope type:** `Users`
5. Click **Next**

6. **Query builder:**
   - Attribute: `Department`
   - Operator: `equals`
   - Value: `Finance`
7. Click **+ Add attribute** if you want to add more conditions (e.g., AND `Country = India`)
8. Click **Next → Submit**

9. After creation, click the scope → **Members** tab
10. Verify: your 2 Finance test users appear

### Step 2 — Create a user-based scope: HR Department

Repeat Step 1 for:
- **Name:** `HR Department Users`
- **Description:** `All users with Department = HR`
- Query: `Department` **equals** `HR`

### Step 3 — Create a site-based scope: Finance SharePoint Sites

1. Click **+ Create scope**
2. **Name:** `Finance SharePoint Sites`
3. **Description:** `SharePoint sites labeled Confidential - Finance`
4. **Scope type:** `SharePoint sites`
5. Click **Next**

6. **Query builder:**
   - Attribute: `Sensitivity label`
   - Operator: `equals`
   - Value: **Confidential - Finance** (select from dropdown)
7. Click **Next → Submit**

### Step 4 — Create a mailbox-based scope: Finance Mailboxes

1. Click **+ Create scope**
2. **Name:** `Finance Mailboxes`
3. **Scope type:** `Mailboxes` (Exchange)
4. **Query:**
   - Attribute: `Department`
   - Operator: `equals`
   - Value: `Finance`
5. Click **Next → Submit**

### Step 5 — Create a Microsoft 365 Groups scope

1. Click **+ Create scope**
2. **Name:** `Finance M365 Groups`
3. **Scope type:** `Microsoft 365 Groups`
4. **Query:**
   - Attribute: `Display name`
   - Operator: `starts with`
   - Value: `Finance`
5. Click **Next → Submit**

> After creation, all scopes show a **provisioning status**. Allow up to **7 days** for full membership resolution on a new tenant. In practice, most scopes resolve within a few hours.

---

## Section C — Apply Adaptive Scopes to Retention Policies

Navigate to **Records Management → Retention policies → New retention policy**

### Step 1 — Create a Finance-specific retention policy

1. **Name:** `Lab - Finance 7-Year Retention (Adaptive)`
2. **Description:** `Retains Finance department content for 7 years using adaptive scope`
3. Click **Next**

### Step 2 — Select policy type: Adaptive

> ⚠️ This is the key step. Choose **Adaptive** here — you cannot switch between static and adaptive after creation.

- Select: **Adaptive**
- Click **Next**

### Step 3 — Add adaptive scopes

1. Click **+ Add scopes**
2. Select:
   - ☑ `Finance Department Users`
   - ☑ `Finance Mailboxes`
   - ☑ `Finance SharePoint Sites`
3. Click **Add**
4. Click **Next**

### Step 4 — Configure retention settings

- Retain items for: **7 years**
- Based on: **When items were created**
- After retention period: **Do nothing**
- Click **Next → Submit**

### Step 5 — Create an HR retention policy

Repeat for:
- **Name:** `Lab - HR 5-Year Retention (Adaptive)`
- Adaptive scopes: `HR Department Users`
- Retain for: **5 years**
- After period: **Do nothing**

---

## Section D — Apply Adaptive Scopes to DLP Policies

Navigate to **Data Loss Prevention → Policies → Create policy**

### Step 1 — Create an adaptive DLP policy for Finance

1. Template: **Financial → U.S. Financial Data**
2. **Name:** `Lab - Finance DLP (Adaptive Scope)`
3. Click **Next**

### Step 2 — Select policy type: Adaptive

- Select: **Adaptive**
- Click **Next**

### Step 3 — Add the Finance scope

1. **+ Add scopes**
2. Select: `Finance Department Users` and `Finance SharePoint Sites`
3. Click **Add → Next**

### Step 4 — Configure DLP rules

- Condition: **Credit Card Number** — High confidence — 1+ instances
- Action: **Block external sharing** + show policy tip
- Policy tip: `Finance content containing card data cannot be shared externally.`
- Click **Next → Submit**

---

## Section E — Apply Adaptive Scopes to Label Policies

Navigate to **Information Protection → Label policies → Publish labels**

### Step 1 — Create an adaptive label policy for Finance

1. **Name:** `Finance Label Policy (Adaptive)`
2. Labels to publish: **Confidential - Finance**, **Internal Only**, **Public**
3. Click **Next**

### Step 2 — Select policy type: Adaptive

- Select: **Adaptive**
- Scopes: `Finance Department Users`
- Click **Next**

### Step 3 — Configure policy settings

- Default label: **Internal Only**
- ☑ Require users to apply a label
- ☑ Require justification to lower classification
- Click **Next → Submit**

> Finance users now see the `Confidential - Finance` label; HR users see `Confidential - HR` via their own label policy. Each group only sees labels relevant to them.

---

## Section F — Validate Dynamic Membership

This section proves that adaptive scopes update automatically when user attributes change.

### Step 1 — Check current Finance scope members

```powershell
Connect-IPPSSession -UserPrincipalName admin@yourtenant.onmicrosoft.com

# List all adaptive scopes
Get-AdaptiveScope | Select-Object Name, LocationType, Status | Format-Table

# Check members of a specific scope
Get-AdaptiveScope -Identity "Finance Department Users" |
    Select-Object -ExpandProperty LocationQuery
```

### Step 2 — Add a new user to the Finance department

1. Go to **Entra ID → Users → New user** (or use an existing test user)
2. Set **Department:** `Finance`
3. Save

### Step 3 — Wait for scope to update

Adaptive scopes re-evaluate periodically. To check progress:

```powershell
# Re-check scope — the new Finance user should appear within a few hours
Get-AdaptiveScope -Identity "Finance Department Users" |
    Select-Object Name, LastModifiedTime, Status
```

### Step 4 — Verify policy applies to the new user

1. Log in as the newly-added Finance user
2. Open a Word document → check the **Sensitivity** label options
3. Confirm they see **Confidential - Finance** from the Finance label policy

### Step 5 — Remove the user from Finance (test removal)

1. In Entra ID, change the test user's **Department** to `Operations`
2. After the next scope evaluation cycle, the user will be automatically removed from the Finance scope
3. Their Confidential - Finance label option will disappear on next Office app refresh

---

## Section G — Audit & Report via PowerShell

```powershell
Connect-IPPSSession -UserPrincipalName admin@yourtenant.onmicrosoft.com

# ── List all adaptive scopes ──────────────────────────────────────────────────
Get-AdaptiveScope |
    Select-Object Name, LocationType, Status, LastModifiedTime |
    Format-Table -AutoSize

# ── View the query for each scope ─────────────────────────────────────────────
Get-AdaptiveScope | ForEach-Object {
    Write-Host "`n=== $($_.Name) ===" -ForegroundColor Cyan
    Write-Host "Type  : $($_.LocationType)"
    Write-Host "Status: $($_.Status)"
    Write-Host "Query : $($_.LocationQuery)"
}

# ── List retention policies using adaptive scopes ─────────────────────────────
Get-RetentionCompliancePolicy |
    Where-Object { $_.PolicyType -eq "Adaptive" } |
    Select-Object Name, Mode, Enabled, PolicyType |
    Format-Table -AutoSize

# ── List DLP policies using adaptive scopes ───────────────────────────────────
Get-DlpCompliancePolicy |
    Where-Object { $_.IsAdaptivePolicy -eq $true } |
    Select-Object Name, Mode, Enabled |
    Format-Table -AutoSize

# ── Export adaptive scope report ──────────────────────────────────────────────
$report = Get-AdaptiveScope |
    Select-Object Name, LocationType, Status, LocationQuery, LastModifiedTime

$report | Export-Csv `
    -Path "$env:USERPROFILE\Desktop\AdaptiveScopes_$(Get-Date -Format 'yyyyMMdd').csv" `
    -NoTypeInformation

Write-Host "Exported $($report.Count) adaptive scopes to Desktop."
```

---

## Validation Checklist

- [ ] Department attribute set on 3+ test users in Entra ID
- [ ] Sensitivity labels applied to SharePoint sites
- [ ] 4 adaptive scopes created (Finance Users, HR Users, Finance Sites, Finance Mailboxes)
- [ ] Adaptive retention policy applied to Finance scopes
- [ ] Adaptive DLP policy applied to Finance scopes
- [ ] Adaptive label policy publishes correct labels to Finance users only
- [ ] New user added to Finance department → automatically added to scope
- [ ] PowerShell report exported with scope details

---

## Common Issues & Fixes

| Issue | Cause | Fix |
|-------|-------|-----|
| Scope shows 0 members | Attribute not set in Entra ID | Set `Department` on users in Entra ID → wait 1–2 hours |
| Cannot select Adaptive during policy creation | E3 license | Requires E5 or Compliance add-on |
| Scope provisioning status stuck on "Pending" | New tenant, first-run delay | Wait up to 7 days; normal for new tenants |
| New user not appearing in scope | Scope evaluation not triggered yet | Evaluation runs every few hours; trigger manually via PowerShell |
| Label policy not updating for user | Office app cache | Close and reopen Office apps; or wait for next policy sync |
| Site not appearing in site scope | Label not applied at site level | Apply label via Site settings → Site information → Sensitivity |

---

## Key Concepts

| Concept | Notes |
|---------|-------|
| **Scope type** | Users, SharePoint sites, Mailboxes, or M365 Groups |
| **Query attribute** | Any synced Entra ID attribute (Department, Country, Title, etc.) |
| **Evaluation cycle** | Scopes re-evaluate every few hours; not real-time |
| **Policy type lock** | Cannot switch between Adaptive and Static after policy creation |
| **Nested conditions** | Combine attributes with AND/OR for complex targeting |
| **Scope + static** | One policy cannot mix adaptive and static scopes |

---

## Adaptive Scope Query Examples

```
# All Finance users in India
Department = "Finance" AND Country = "India"

# All senior staff (by title prefix)
Job title starts with "Senior" OR Job title starts with "Director"

# SharePoint sites with any Confidential label
Sensitivity label = "Confidential - Finance" OR Sensitivity label = "Confidential - HR"

# All sites whose URL contains a keyword
Site URL contains "finance"

# All groups starting with a prefix
Display name starts with "FIN-"
```

---

## Comparison: When to Use Adaptive vs. Static

| Scenario | Recommended Scope |
|----------|------------------|
| Pilot rollout to a fixed 10-user group | Static |
| All Finance department users (org changes frequently) | **Adaptive** |
| All SharePoint sites labeled Confidential | **Adaptive** |
| Specific named sites you control manually | Static |
| Large enterprise with multiple regions/departments | **Adaptive** |
| Simple test tenant lab with few users | Static |

---

## Next Steps

- ➡ Combine adaptive scopes with **auto-labeling policies** (Lab 01) so that when a user joins Finance, their content is automatically labeled and retained
- ➡ Use adaptive scopes in **Communication Compliance** policies to monitor only regulated departments
- ➡ Explore **PowerShell scripting** (Lab 09) to report on scope membership and audit changes over time

---

*Part of the [Microsoft Purview Hands-On Lab Series](../README.md)*
