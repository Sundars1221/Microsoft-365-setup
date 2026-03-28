# Lab 05 — Retention Policies & Labels

**Duration:** 60 minutes | **Level:** Core Skill | **Skill Area:** Records Management

---

## Objectives

- Create org-wide retention policies with different lifecycle rules
- Configure retention labels with disposition review
- Apply labels as regulatory records and test deletion prevention
- Understand the Preservation Hold Library behavior
- Test the disposition review workflow

## Learning Outcomes

| Outcome | Validated By |
|---------|-------------|
| Create org-wide retention | Policy active across Exchange/SharePoint |
| Configure regulatory records | Deletion blocked on labeled documents |
| Verify preservation | Preservation Hold Library contains deleted items |

---

## Prerequisites

- [ ] Microsoft 365 E3/E5 test tenant
- [ ] Compliance Admin or Records Management role
- [ ] At least one SharePoint document library with test documents

---

## Section A — Retention Policies

Navigate to **https://purview.microsoft.com → Solutions → Records Management → Retention policies**

### Step 1 — Create a 7-year financial retention policy
1. Click **New retention policy**
2. Name: `Lab - 7 Year Financial Retention`
3. Description: `Retain all financial data for 7 years`
4. Click **Next**

### Step 2 — Select policy type
- Choose: **Static** (simpler to configure; Adaptive requires scope setup)
- Click **Next**

### Step 3 — Choose locations
Enable:
| Location | Scope |
|----------|-------|
| Exchange mailboxes | All mailboxes |
| SharePoint sites | All sites |
| OneDrive accounts | All accounts |
| Microsoft 365 Groups | All groups |

Click **Next**

### Step 4 — Set retention settings
- Retain items for: **7 years**
- Based on: **When items were created**
- After retention period: **Do nothing** (keep indefinitely)
- Click **Next → Submit**

### Step 5 — Create a short-term deletion policy
Repeat the process for:
- Name: `Lab - 90 Day Temp Files`
- Retain for: **90 days**
- After retention period: **Delete items automatically**
- Locations: **SharePoint sites only** (All sites)
- Click **Submit**

---

## Section B — Retention Labels (Records Management)

Navigate to **Records Management → Labels**

### Step 1 — Create a retention label
1. Click **Create a label**
2. Name: `Financial Record - 7 Year`
3. Description for users: `Apply to official financial records. Retained 7 years.`
4. Description for admins: `Regulatory record — cannot be deleted during retention period.`
5. Click **Next**

### Step 2 — Configure label retention settings
- ☑ Retain items for: **7 years**
- Retain based on: **When items were labeled**
- After retention period: **Trigger a disposition review**
- ☑ **Mark items as a record** → choose **Regulatory record**
  > Regulatory records cannot be deleted by anyone, including admins, during the retention period.
- Click **Next → Create label**

### Step 3 — Publish the label
1. Click **Publish labels**
2. Add label: **Financial Record - 7 Year**
3. Locations: SharePoint sites and OneDrive (All)
4. Name the policy: `Finance Records Policy`
5. Click **Next → Submit**

> ⏱ Allow up to 1 day for the label to appear in SharePoint document libraries.

### Step 4 — Apply the label in SharePoint
1. Go to a SharePoint document library
2. Select a test document
3. Click **Details pane** (ⓘ icon) on the right
4. Under **Retain**, click **Apply label**
5. Choose: **Financial Record - 7 Year**
6. Click **Save**

### Step 5 — Attempt to delete the labeled document
1. Select the labeled document
2. Click **Delete**
3. ✅ You should see an error:
   ```
   This item has been declared a record and cannot be deleted.
   ```

### Step 6 — Review the Preservation Hold Library
1. Go to the SharePoint site
2. Navigate to: **Site contents → Preservation Hold Library**
3. If any items were deleted while under retention (from a non-regulatory label), they appear here
4. Preserved items cannot be permanently deleted until the retention period ends

---

## Section C — Disposition Review Workflow

Navigate to **Records Management → Disposition**

### Step 1 — Understand disposition states
| State | Description |
|-------|-------------|
| Pending review | Retention period ended; awaiting reviewer action |
| Approved for disposal | Reviewer approved deletion |
| Disposed | Item permanently deleted |
| Relabeled | Reviewer applied new label instead of deleting |

### Step 2 — Configure a disposition reviewer
1. Go to **Records Management → Settings → Disposition**
2. Add a disposition reviewer: your admin account
3. This user will receive email notifications when items are pending review

### Step 3 — Review a pending disposition (simulation)
> In a test environment, disposition reviews only appear after the retention period ends.  
> To simulate: create a label with a very short period (e.g., 1 day) on a test document.

1. When items appear in **Pending review**, click the item
2. Review the document metadata and content
3. Actions:
   - **Approve disposal** — permanently deletes
   - **Relabel** — apply a new retention label
   - **Add another stage** — send to another reviewer

---

## Validation Checklist

- [ ] Two retention policies created (7-year and 90-day)
- [ ] Retention label `Financial Record - 7 Year` published
- [ ] Label visible in SharePoint document library
- [ ] Deletion of regulatory record is blocked
- [ ] Preservation Hold Library accessible on the site
- [ ] Disposition reviewer configured

---

## Key Concepts

| Concept | Notes |
|---------|-------|
| **Retention policy** | Org-wide automatic content lifecycle management |
| **Retention label** | User-applied or auto-applied; enables records management |
| **Record vs. Regulatory record** | Record = deletion restricted; Regulatory = deletion blocked even for admins |
| **Disposition review** | Human review before permanent deletion at end of retention period |
| **Preservation Hold Library** | Hidden SharePoint library storing preserved/deleted items |
| **Retention winner** | When multiple policies apply, the longest retention period wins |

---

## Retention Priority Rules

When multiple retention settings apply to a single item, Microsoft Purview uses this priority order:

```
1. Explicit deletion (wins over retention if shorter)
   ↓
2. Explicit retention (longer period wins over shorter)
   ↓
3. Retention label (overrides retention policy)
   ↓
4. Retention policy (org-wide, broadest scope)
```

---

## Next Lab

➡ [Lab 06 — Communication Compliance](../lab-06-communication-compliance/README.md)
