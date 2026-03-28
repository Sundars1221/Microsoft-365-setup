# Lab 08 — Compliance Manager & Score Improvement

**Duration:** 60 minutes | **Level:** Foundational | **Skill Area:** Compliance Manager

---

## Objectives

- Navigate the Compliance Manager dashboard and understand score components
- Review Microsoft-managed vs. customer-managed controls in GDPR and NIST assessments
- Implement improvement actions and upload evidence
- Create a custom assessment template
- Generate an assessment report for auditor use

## Learning Outcomes

| Outcome | Validated By |
|---------|-------------|
| Read compliance score | Baseline score documented |
| Complete improvement actions | Score increases after marking actions |
| Create custom assessment | NIST or custom template assessment created |

---

## Prerequisites

- [ ] Microsoft 365 E3/E5 test tenant
- [ ] Compliance Admin or Global Admin role
- [ ] Labs 01 and 02 completed (DLP and labeling actions can be marked as evidence)

---

## Section A — Explore Compliance Manager

Navigate to **https://purview.microsoft.com → Solutions → Compliance Manager**

### Step 1 — Review the overview dashboard
Note and document your current score:
- **Overall compliance score:** _____ / 100
- **Score by category** (Information Protection, Access Control, etc.)
- **Score by solution** (Microsoft 365, Intune, Defender, etc.)

> Your score is auto-calculated based on your Microsoft 365 configuration. A new test tenant typically starts at 30–50%.

### Step 2 — Explore score components
The compliance score is based on:

| Component | Description |
|-----------|-------------|
| **Microsoft-managed controls** | Controls handled by Microsoft's infrastructure; auto-tested |
| **Your organization's controls** | Controls you need to implement and attest |
| **Shared responsibility** | Controls requiring action from both sides |

### Step 3 — Open the GDPR assessment
1. Go to **Assessments**
2. Open **Data Protection Baseline** or **GDPR** (auto-created for M365)
3. Click **Controls** tab

### Step 4 — Review control status

| Status | Meaning |
|--------|---------|
| **Passed** | Control is configured correctly |
| **Failed** | Control is not in place |
| **Not tested** | Awaiting customer action/attestation |
| **Not in scope** | Not applicable to your environment |

### Step 5 — Filter to your actions only
- Filter: **Test status = Not tested**
- Filter: **Action type = Customer-managed**
- These are the controls you need to implement

### Step 6 — Read a control in detail
Click on any control to see:
- Full control description
- Microsoft implementation details
- **Your implementation guidance** (step-by-step what to configure)
- Evidence required
- Related improvement actions

---

## Section B — Implement Improvement Actions

Navigate to **Compliance Manager → Improvement actions**

### Step 1 — Sort by points impact
- Sort by: **Points impact (descending)**
- Focus on the highest-value quick wins

### Step 2 — Filter to actionable items
- Filter: **Implementation status = Not implemented**
- Filter: **Solution = Microsoft 365**

### Step 3 — Complete: Enable MFA for all users

> This is typically the highest-value action (40–50 points)

1. Click the **Enable MFA for all users** action
2. Read the implementation steps
3. Go to **Entra ID → Security → MFA** and verify MFA is enforced
4. Return to Compliance Manager → mark as: **Implemented**
5. Upload evidence:
   - Take a screenshot of the MFA policy in Entra ID
   - Upload the screenshot as evidence
6. Test status: **Passed** (or **Manually tested**)
7. Click **Save**

### Step 4 — Link Lab 02 DLP policy as evidence

1. Find action: **Create a DLP policy to protect financial information**
2. Mark as: **Implemented**
3. Add implementation notes: `DLP policy 'Lab - US Financial Data Protection' created on [date]. Covers Exchange, SharePoint, OneDrive, Teams.`
4. Upload evidence: screenshot of your Lab 02 DLP policy
5. Click **Save**

### Step 5 — Link Lab 01 sensitivity labels as evidence

1. Find: **Apply sensitivity labels to protect sensitive documents**
2. Mark as: **Implemented**
3. Add notes: `Sensitivity label taxonomy created with 5 labels. Published to all users via Purview Lab Policy.`
4. Click **Save**

### Step 6 — Set one action as In Progress
1. Find a complex action (e.g., **Configure Advanced Threat Protection**)
2. Mark as: **In progress**
3. Assign to: your account
4. Set due date: 30 days from today
5. Add note explaining what's pending

### Step 7 — Observe score change
- Return to the **Overview** dashboard
- Compare new score to your baseline from Step 1
- Note: some changes reflect immediately; others take up to 72 hours

---

## Section C — Create a Custom Assessment

### Step 1 — Create a NIST 800-53 assessment
1. Go to **Assessments → Add assessment**
2. Browse templates: search for **NIST SP 800-53 Rev 5**
3. Click **Use template**
4. Settings:
   - Name: `Lab - NIST 800-53 Assessment`
   - Product: `Microsoft 365`
   - Industry: `Government`
   - Region: `United States`
5. Click **Next → Create assessment**

### Step 2 — Explore the NIST assessment
Purview automatically maps M365 controls to NIST control families:

| NIST Family | Examples |
|-------------|----------|
| AC — Access Control | MFA, RBAC, conditional access |
| AU — Audit and Accountability | Audit logging, log retention |
| SC — System & Communications | Data encryption, DLP |
| SI — System & Information Integrity | Malware protection, patching |

### Step 3 — Create a custom assessment template

1. Go to **Assessment templates → + Add template**
2. Click **Download template** (Excel)
3. Open the Excel file — review the structure:
   - Sheet 1: `ControlFamily`, `ControlID`, `Title`, `Description`
4. Fill in 5 custom controls relevant to your organization, for example:

| ControlFamily | ControlID | Title | Description |
|--------------|-----------|-------|-------------|
| Access Control | AC-01 | MFA Enforcement | All users must use MFA |
| Data Protection | DP-01 | Sensitivity Labeling | All documents must be labeled |
| Data Protection | DP-02 | DLP Policy | DLP must cover financial data |
| Incident Response | IR-01 | IRM Policy | Insider risk policy must be active |
| Audit | AU-01 | Audit Logging | Audit logging must be enabled |

5. Save the Excel file
6. Upload it to Purview → click **Upload**
7. Review the imported controls → **Create template**
8. Use the template to create a new assessment

---

## Section D — Generate Assessment Reports

### Step 1 — Generate a report from GDPR assessment
1. Open the GDPR assessment
2. Click **Generate report**
3. Format: **PDF** and/or **Excel**
4. Download the report

### Step 2 — Review the report sections
The exported report includes:
- Assessment summary and overall score
- List of all controls with status (Passed/Failed/Not tested)
- Customer action items with due dates
- Evidence and implementation notes
- Microsoft attestation details

> This report format is accepted by auditors for GDPR, NIST, ISO 27001, and similar compliance reviews.

### Step 3 — Schedule regular score reviews
1. In Compliance Manager → **Settings → Score history**
2. Review your score trend over time
3. Set a calendar reminder to review and update improvement actions monthly

---

## Validation Checklist

- [ ] Baseline compliance score documented
- [ ] GDPR assessment controls reviewed
- [ ] MFA improvement action marked as implemented with evidence
- [ ] DLP policy linked as evidence for data protection action
- [ ] Score increased after marking actions
- [ ] NIST 800-53 assessment created
- [ ] Custom template created with 5+ controls
- [ ] Assessment report downloaded

---

## Key Concepts

| Concept | Notes |
|---------|-------|
| **Compliance score** | Points-based score; higher = better posture. Not a compliance guarantee. |
| **Improvement action** | Specific configuration task that increases score when completed |
| **Evidence** | Screenshots, exports, or attestations proving a control is in place |
| **Assessment** | Evaluation against a specific regulation (GDPR, NIST, ISO 27001, etc.) |
| **Template** | Regulation/framework mapped to M365 controls |
| **Shared responsibility** | Some controls require action from both Microsoft and the customer |

---

## Available Regulation Templates

| Template | Use Case |
|----------|----------|
| Data Protection Baseline | Default; applies to all M365 tenants |
| GDPR | EU General Data Protection Regulation |
| NIST SP 800-53 | US Government security framework |
| ISO 27001 | International information security standard |
| HIPAA | US Healthcare data protection |
| CCPA | California Consumer Privacy Act |
| FedRAMP | US Federal cloud authorization |

---

## Next Lab

➡ [Lab 09 — PowerShell & Graph API Automation](../lab-09-powershell-automation/README.md)
