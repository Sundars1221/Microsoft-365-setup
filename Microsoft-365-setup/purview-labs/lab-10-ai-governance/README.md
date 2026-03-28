# Lab 10 — AI Governance with Microsoft Copilot & Purview

**Duration:** 75 minutes | **Level:** Expert / Emerging | **Skill Area:** AI Governance

---

## Objectives

- Configure Microsoft Purview controls specifically for Microsoft 365 Copilot
- Enable and search Copilot interaction audit logs
- Create DLP policies targeting Copilot prompts and responses
- Review data oversharing risks using Purview AI Hub
- Understand sensitivity label enforcement in Copilot responses

## Learning Outcomes

| Outcome | Validated By |
|---------|-------------|
| Audit Copilot interactions | Audit log shows CopilotInteraction records |
| Apply DLP to Copilot | Blocked prompt triggers user notification |
| Review AI activity reports | AI Hub shows sensitive data access summary |

---

## Prerequisites

- [ ] Microsoft 365 Copilot license (M365 E3/E5 + Copilot add-on) — *or see note below*
- [ ] Audit logging enabled (from Lab 04)
- [ ] Sensitivity labels created (from Lab 01)
- [ ] DLP experience (from Lab 02)

> **No Copilot license?** You can still configure all policies in this lab. They will be ready to enforce when Copilot is enabled. For AI Hub, use the Purview Demo Environment at **https://aka.ms/PurviewDemo**.

---

## Section A — Pre-Copilot Governance Checklist

Before enabling Copilot in any tenant, complete these Purview controls:

| Control | Action | Lab Reference |
|---------|--------|---------------|
| Sensitivity labels | Label all sensitive documents | Lab 01 |
| Audit logging | Turn on audit log search | Lab 04 |
| DLP policies | Extend DLP to Copilot location | This lab |
| Oversharing review | Identify broadly-shared unlabeled content | This lab |
| Retention | Ensure Copilot interactions are retained | Lab 05 |

---

## Section B — Audit Copilot Interactions

Navigate to **https://purview.microsoft.com → Solutions → Audit**

### Step 1 — Verify audit logging is active
- **Settings → Audit** → confirm: **Audit log search is turned on**
- Copilot interactions are automatically captured when audit is enabled

### Step 2 — Search for Copilot audit records
1. Click **New search**
2. Settings:
   - **Activities:** In the filter, type `Copilot` → select **CopilotInteraction**
   - **Date range:** Last 7 days
   - **Users:** All (or specific test users)
3. Click **Search**

### Step 3 — Review a Copilot audit record
Click on any result and review:

| Field | What to Look For |
|-------|-----------------|
| `UserId` | Which user sent the prompt |
| `CreationTime` | UTC timestamp |
| `AiApplicationName` | e.g., Microsoft Copilot for M365 |
| `PromptText` | The exact prompt the user submitted |
| `AccessedResources` | Files/emails Copilot accessed to generate the response |
| `SensitivityLabelIds` | Labels on accessed content |

> ⚠️ The **accessed resources** field reveals which documents Copilot referenced. If `Confidential - Finance` documents appear in responses to users without finance access, that is an oversharing risk.

### Step 4 — Note sensitivity labels in audit records
Observe that audit records include the sensitivity labels of documents Copilot accessed. This is critical for governance — you can identify if Copilot surfaced confidential content to unauthorized users.

### Step 5 — Export Copilot audit log
1. Click **Export**
2. Download the CSV
3. Filter to `CopilotInteraction` rows only
4. Review: which users are using Copilot most, and which sensitive documents are being accessed

---

## Section C — DLP for Microsoft Copilot

Navigate to **Data Loss Prevention → Policies → Create policy**

### Step 1 — Create a Copilot-specific DLP policy
- Name: `Lab - Copilot Data Protection`
- Description: `Prevents sensitive data from entering Copilot prompts or appearing in responses`

### Step 2 — Select Copilot as the location
1. In the location selector, scroll to find:
   - ☑ **Microsoft 365 Copilot (preview)**
2. Deselect all other locations (for a focused test)
3. Click **Next**

### Step 3 — Configure conditions
- Condition: Content contains any of:
  - **US Social Security Number (SSN)** — High confidence
  - **Credit Card Number** — High confidence
- Instance count: **1 or more**

### Step 4 — Configure the action
- Action: **Block the interaction**
- User notification: `Your Copilot prompt or response contains sensitive data and has been blocked per your organization's data protection policy.`
- ☑ Allow override with justification: **No** (strict block for lab)

### Step 5 — Enable the policy
- Select: **Turn it on right away**
- Click **Submit**

### Step 6 — Test the policy
In **Microsoft Teams or Copilot chat**, send a test prompt containing sensitive data:
```
What should I do with this customer SSN: 123-45-6789?
```

**Expected result:** The prompt is blocked and the user sees the notification message.

### Step 7 — Review Copilot DLP alerts
Navigate to **DLP → Alerts**
- Filter by: `Lab - Copilot Data Protection`
- Review the blocked interaction record showing: user, timestamp, blocked content type

---

## Section D — Data Oversharing Risk Review

### Step 1 — Open Purview AI Hub (if available)
Navigate to **https://purview.microsoft.com → Solutions → AI Hub**

The AI Hub dashboard shows:

| Metric | What It Means |
|--------|--------------|
| **Total Copilot interactions** | Volume of AI usage in your tenant |
| **Sensitive data accessed** | Documents with sensitive labels accessed by Copilot |
| **Unlabeled files accessed** | Files with no sensitivity label that Copilot referenced |
| **Top users** | Who is using Copilot most frequently |
| **Oversharing risks** | Broadly-accessible sensitive files Copilot may surface |

### Step 2 — Identify oversharing risks
AI Hub highlights files that are:
- **Broadly accessible** (shared with "everyone" or "all users")
- **Sensitive in content** (detected PII, financial data)
- **Unlabeled** (no sensitivity label applied)

These are high-risk files because Copilot can surface their content to any user who asks.

### Step 3 — Remediate oversharing
For files identified as oversharing risks:
1. Open the file in SharePoint
2. Review and restrict sharing permissions
3. Apply an appropriate sensitivity label
4. For financial files: apply **Confidential - Finance** (encryption limits who Copilot can surface this to)

### Step 4 — Sensitivity label enforcement in Copilot
Test how Copilot respects sensitivity labels:

1. Upload a document labeled **Confidential - Finance** with Finance-group-only encryption
2. Log in as a **non-Finance test user**
3. In Copilot, prompt: `Summarize the quarterly financial report`
4. Copilot should **not** be able to access the encrypted document for this user
5. Log in as a **Finance user** → repeat the prompt
6. Copilot should now be able to include the document in the response

---

## Section E — Copilot Interaction Retention

### Configure retention for Copilot interactions
Copilot prompts and responses are stored in Exchange Online mailboxes (hidden folder).

To retain them:
1. Go to **Records Management → Retention policies**
2. Open your existing retention policy (or create: `Lab - Copilot Interaction Retention`)
3. Add location: **Exchange mailboxes** (All)
4. Retain for: **1 year**
5. Click **Save**

> Copilot interactions are captured in the user's mailbox as hidden items. Your Exchange retention policy automatically covers them.

---

## Section F — Review Copilot Data Residency (Optional)

1. Go to **Microsoft 365 Admin Center → Settings → Org settings → Copilot**
2. Review:
   - **Data processing region** — where Copilot processes your data
   - **Optional connected experiences** — additional data flows to review
3. For EU tenants: verify **EU Data Boundary** is configured

---

## Validation Checklist

- [ ] Audit log shows CopilotInteraction records
- [ ] Audit records include sensitivity label IDs of accessed content
- [ ] Copilot DLP policy active (Copilot location enabled)
- [ ] Test prompt with SSN was blocked
- [ ] DLP alert visible for blocked Copilot interaction
- [ ] AI Hub oversharing risks reviewed
- [ ] At least 3 oversharing-risk files labeled and permissions restricted
- [ ] Sensitivity label encryption tested (Confidential - Finance not surfaced to non-Finance user)

---

## Key Concepts

| Concept | Notes |
|---------|-------|
| **Copilot grounding** | Copilot uses Microsoft Graph to retrieve context from M365 content |
| **Oversharing risk** | Broadly-accessible sensitive files that Copilot can surface to any user |
| **Sensitivity label enforcement** | Encrypted labels prevent Copilot accessing content for unauthorized users |
| **Audit trail** | Full Copilot interaction log available for compliance and legal review |
| **DLP for Copilot** | Prevents sensitive data in prompts from being processed or stored |
| **AI Hub** | Centralized dashboard for AI usage governance and risk review |

---

## AI Governance Best Practices

```
Before enabling Copilot
─────────────────────────────────────────────────────────
☑ Label all sensitive documents (Lab 01)
☑ Turn on audit logging (Lab 04)
☑ Review and restrict oversharing permissions
☑ Create Copilot DLP policies (this lab)

After enabling Copilot
─────────────────────────────────────────────────────────
☑ Review AI Hub weekly for new oversharing risks
☑ Monitor Copilot audit logs for sensitive data access
☑ Review DLP alerts for blocked interactions
☑ Update sensitivity label policies as new content types emerge
☑ Train users on responsible Copilot prompting
```

---

## 🎉 Congratulations!

You have completed all 10 Microsoft Purview hands-on labs. Your skills now cover:

| Lab | Skill |
|-----|-------|
| 01 | Sensitivity Labels & Auto-labeling |
| 02 | DLP — Multi-location & Endpoint |
| 03 | Insider Risk Management |
| 04 | eDiscovery Standard & Premium |
| 05 | Retention & Records Management |
| 06 | Communication Compliance |
| 07 | Data Map, Catalog & Lineage |
| 08 | Compliance Manager |
| 09 | PowerShell & Graph API |
| 10 | AI Governance with Copilot |

### Recommended next steps
- Take the **SC-400** exam — these labs directly map to the exam objectives
- Review the [Microsoft Purview documentation](https://learn.microsoft.com/en-us/purview/)
- Join the [Microsoft Tech Community — Security, Compliance & Identity](https://techcommunity.microsoft.com/t5/security-compliance-identity/ct-p/MicrosoftSecurityandCompliance)
