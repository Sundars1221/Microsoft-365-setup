# Lab 01 — Sensitivity Labels & Information Classification

**Duration:** 75 minutes | **Level:** Foundational | **Skill Area:** MIP / Labels

---

## Objectives

- Create a full sensitivity label taxonomy with parent and child labels
- Configure protection settings (encryption, visual markings, watermarks)
- Publish labels via a label policy to users
- Apply labels manually in Word and Outlook
- Configure and test auto-labeling policies in simulation mode

## Learning Outcomes

| Outcome | Validated By |
|---------|-------------|
| Create label hierarchy | Labels visible in Purview portal |
| Configure protection | Encryption + markings appear in Office apps |
| Test auto-labeling | Simulation report shows matched items |

---

## Prerequisites

- [ ] Microsoft 365 E3/E5 test tenant (or M365 E3 + AIP P2 add-on)
- [ ] Global Admin or Compliance Admin role
- [ ] Microsoft 365 Apps installed (Word, Outlook)

---

## Section A — Create Sensitivity Labels

Navigate to **https://purview.microsoft.com → Solutions → Information Protection → Labels**

### Step 1 — Create parent label: `Confidential`
1. Click **Create a label**
2. Name: `Confidential`
3. Description: `Sensitive business data`
4. Click **Next** through all tabs → **Create label**

### Step 2 — Create child label: `Confidential - Finance`
1. Select the **Confidential** parent label → **Add sub-label**
2. Name: `Confidential - Finance`
3. Under **Protection settings** → check **Encrypt content**
4. Set permissions: Finance group = Co-Author
5. Visual markings → Header: `CONFIDENTIAL - FINANCE`
6. Save

### Step 3 — Create child label: `Confidential - HR`
1. Add sub-label under **Confidential**
2. Name: `Confidential - HR`
3. Encryption: HR group only
4. Header: `CONFIDENTIAL - HR ONLY` (color: red)
5. Watermark: `HR CONFIDENTIAL`
6. Save

### Step 4 — Create label: `Internal Only`
1. At parent level → **Create a label**
2. Name: `Internal Only`
3. No encryption
4. Watermark text: `INTERNAL - DO NOT SHARE`
5. Footer: `Internal use only`
6. Save

### Step 5 — Create label: `Public`
1. Name: `Public`
2. No encryption, no visual markings
3. Save

### Step 6 — Verify label hierarchy
Confirm the following structure appears in the Labels list:
```
Public
Internal Only
Confidential
  ├── Confidential - Finance
  └── Confidential - HR
```

---

## Section B — Publish Labels via Policy

Navigate to **Information Protection → Label policies → Publish labels**

### Step 1 — Create a new label policy
1. Name: `Purview Lab Policy`
2. Select all labels created above
3. Click **Next**

### Step 2 — Configure policy settings
- Default label: **Internal Only**
- ☑ Require users to apply a label
- ☑ Users must provide justification to remove or lower a label
- Click **Next**

### Step 3 — Assign scope
- Publish to: **All users and groups**
- Click **Next → Submit**

> ⏱ **Note:** Policies take up to 24 hours to fully propagate. Wait at least 30 minutes before testing in Office apps.

---

## Section C — Apply Labels in Office Apps

### Step 1 — Test in Microsoft Word
1. Open Word → create a new blank document
2. In the Home ribbon, locate the **Sensitivity** button
3. Click **Sensitivity → Confidential → Confidential - Finance**
4. Verify the header/watermark appears automatically

### Step 2 — Test label downgrade justification
1. With the document labeled **Confidential - Finance**, try changing to **Public**
2. You should be prompted for a **justification reason**
3. Enter a reason → confirm the downgrade

### Step 3 — Test in Outlook
1. Compose a new email
2. Click **Sensitivity** in the message toolbar → **Internal Only**
3. Send a test email to yourself
4. Verify the footer appears in the sent message

### Step 4 — Test external sharing block
1. Compose a new email → apply **Confidential - Finance**
2. Add an external Gmail address as recipient
3. Observe the **policy tip** or block behavior before sending

---

## Section D — Configure Auto-Labeling

Navigate to **Information Protection → Auto-labeling policies → Create auto-labeling policy**

### Step 1 — Choose a template
- Select: **Financial data**
- This pre-populates Credit Card, ABA Routing Number, Bank Account Number
- Click **Next**

### Step 2 — Name the policy
- Name: `Auto-label Financial Documents`
- Description: `Applies Confidential - Finance when financial content detected`

### Step 3 — Set locations
- ☑ SharePoint sites (All sites)
- ☑ Exchange email (All)

### Step 4 — Set conditions
Keep defaults and add:
- Content contains: **Financial Statement** (custom keyword)

### Step 5 — Set label to apply
- Choose: **Confidential - Finance**

### Step 6 — Run simulation
- Select: **Run policy in simulation mode**
- Click **Submit**
- Wait 15–30 minutes for results

### Step 7 — Review simulation results
1. Open the policy → click **View matched items**
2. Review documents/emails that matched
3. When satisfied → click **Turn on policy**

---

## Validation Checklist

- [ ] Labels appear in the Office apps ribbon
- [ ] Label downgrade prompts for justification
- [ ] Email footer is visible in sent messages
- [ ] Auto-labeling simulation shows expected matches
- [ ] Encryption prevents unauthorized access to Confidential files

---

## Key Concepts

| Concept | Notes |
|---------|-------|
| **Label priority** | Higher number = higher priority. Lower-priority labels cannot override higher. |
| **Mandatory labeling** | Users must pick a label before saving/sending |
| **Auto-labeling** | Server-side (Exchange/SharePoint) vs client-side (Office apps) |
| **Encryption scope** | Rights Management encryption persists even if file is downloaded |

---

## Next Lab

➡ [Lab 02 — Data Loss Prevention (DLP) Policies](../lab-02-dlp/README.md)

> DLP policies can use the sensitivity labels you created here as conditions. Complete Lab 01 first.
