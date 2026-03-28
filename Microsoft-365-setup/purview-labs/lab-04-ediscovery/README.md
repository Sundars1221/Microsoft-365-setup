# Lab 04 — eDiscovery & Audit Investigations

**Duration:** 75 minutes | **Level:** Core Skill | **Skill Area:** eDiscovery / Audit

---

## Objectives

- Create an eDiscovery Standard case and apply a legal hold
- Run content searches across Exchange, SharePoint, and Teams
- Preview, export, and analyze search results
- Use Audit to investigate user activities
- Create alert policies for ongoing monitoring

## Learning Outcomes

| Outcome | Validated By |
|---------|-------------|
| Create a legal hold | Hold active on custodian mailboxes/sites |
| Search across M365 workloads | Search results showing items from multiple locations |
| Export evidence package | ZIP downloaded with manifest CSV |

---

## Prerequisites

- [ ] Microsoft 365 E3/E5 test tenant
- [ ] eDiscovery Manager or Compliance Admin role
- [ ] Lab 01 and Lab 02 completed (content to search)
- [ ] (Optional) IRM case from Lab 03 escalated to eDiscovery Premium

---

## Section A — eDiscovery Standard

Navigate to **https://purview.microsoft.com → Solutions → eDiscovery → Standard**

### Step 1 — Create a new case
1. Click **Create a case**
2. Name: `Lab Case - Financial Investigation 2026`
3. Description: `Test eDiscovery for lab exercise`
4. Click **Save**

### Step 2 — Create a hold
1. Open the case → click **Holds** tab → **New hold**
2. Name: `Finance Team Email Hold`
3. Select custodians: your test user accounts
4. Hold type: **All content**
5. Click **Next → Save**

> ⚠️ Items under hold are preserved even if users delete them. They appear in the **Preservation Hold Library** in SharePoint.

### Step 3 — Create a content search
1. Go to **Searches** tab → **New search**
2. Name: `Financial Data Search`
3. Keywords:
   ```
   "financial report" OR "bank account" OR "credit card"
   ```
4. Add conditions:
   - **Date:** Last 90 days
5. Click **Run query**

### Step 4 — Review search statistics
After the search completes:
1. Click **Statistics**
2. Review:
   - Total items found
   - Total size
   - Top locations (which mailboxes/sites have most hits)

### Step 5 — Preview results
1. Click **Preview**
2. Review sample email/document content matching your search
3. Verify relevance of results

### Step 6 — Export results
1. Click **Export**
2. Export settings:
   - Include: **All items including ones with unrecognized format**
   - Output format: **Loose files and PSTs**
3. Click **Export**
4. Download the export package when ready

### Step 7 — Analyze the export
1. Extract the ZIP file
2. Open the **manifest CSV** file
3. Key columns to review:
   | Column | Description |
   |--------|-------------|
   | `Subject` | Email subject or document name |
   | `Author` | Content creator |
   | `Custodian` | Which held user owns this item |
   | `Location` | Original mailbox/site URL |
   | `File Type` | Extension |
   | `Sensitivity Label` | Label applied to the item |

---

## Section B — Audit Log Investigation

Navigate to **https://purview.microsoft.com → Solutions → Audit**

### Step 1 — Verify audit logging is enabled
Go to **Settings → Audit**
- Confirm: **Audit log search is turned on**
- If not, click **Turn on audit log search** (takes up to 24 hours to activate)

### Step 2 — Run a general audit search
1. Click **New search**
2. Settings:
   - Activities: **(Select all)**
   - Date range: **Last 7 days**
   - Users: your test accounts
3. Click **Search**

### Step 3 — Filter for file operations
In the results:
1. Filter by **Record type:** `SharePointFileOperation`
2. Review events:
   - `FileAccessed` — file viewed
   - `FileDownloaded` — file downloaded
   - `FileMoved` — file relocated
   - `FileShared` — file shared externally

### Step 4 — Search for admin activities
New search with:
- Activities: **Added member to role**, **Changed admin settings**
- Review all admin operations performed in your tenant

### Step 5 — Export audit log
1. Click **Export**
2. Download the CSV
3. Open in Excel and review key columns:
   | Column | Description |
   |--------|-------------|
   | `CreationTime` | UTC timestamp |
   | `UserIds` | Who performed the action |
   | `Operation` | What action was taken |
   | `ObjectId` | The file/mailbox/site affected |
   | `ClientIP` | Source IP address |
   | `ResultStatus` | Success or failure |

### Step 6 — Create an alert policy
Navigate to **Microsoft Purview → Policies → Alert policies → New alert policy**

1. Name: `External File Sharing Alert`
2. Activity: **Files shared externally**
3. Threshold: **Any time this activity occurs**
4. Recipients: your admin email
5. Click **Finish**

---

## Section C — eDiscovery Premium (if licensed)

Navigate to **eDiscovery → Premium → Cases**

### Step 1 — Open the escalated IRM case
If you escalated from Lab 03, find the linked Premium case.  
Otherwise, create a new Premium case:
- Name: `Lab Premium Case 2026`

### Step 2 — Add custodians
1. Go to **Sources** tab → **Add custodians**
2. Add your test users
3. Associate their mailbox and OneDrive as data sources
4. Click **Add**

### Step 3 — Place custodians on hold
1. In **Sources**, select custodians → **Hold**
2. Hold type: **Preserve all content**

### Step 4 — Run a collection
1. Go to **Collections** tab → **New collection**
2. Name: `Initial Financial Collection`
3. Custodial sources: all added custodians
4. Keywords: `"financial" OR "invoice" OR "credit card"`
5. Click **Submit**

### Step 5 — Commit to review set
1. Once collection is complete, click **Commit to review set**
2. Create a new review set: `Lab Review Set 01`
3. Commit

### Step 6 — Review and tag documents
1. Open the review set
2. Review documents one by one
3. Apply tags: **Responsive**, **Non-responsive**, **Privileged**
4. Add notes to flagged items

---

## Validation Checklist

- [ ] Hold is active and shows custodians
- [ ] Content search returned results from multiple workloads
- [ ] Export ZIP downloaded with manifest CSV
- [ ] Audit log shows user activities
- [ ] Alert policy created for external sharing
- [ ] (E5) Premium review set contains collected documents

---

## Key Concepts

| Concept | Notes |
|---------|-------|
| **Legal hold** | Prevents deletion of content; held items preserved in hidden folder |
| **Custodian** | Person whose data is under legal hold |
| **PST export** | Email format for legal handoff to outside counsel |
| **Audit retention** | Standard: 90 days; E5 with 10-year add-on: up to 10 years |
| **Review set** | Isolated, tamper-proof container for Premium review |

---

## Next Lab

➡ [Lab 05 — Retention Policies & Labels](../lab-05-retention/README.md)
