# Lab 06 — Communication Compliance

**Duration:** 60 minutes | **Level:** Advanced | **Skill Area:** Communication Compliance

---

## Objectives

- Create policies to detect offensive language and regulatory violations in Teams and Exchange
- Generate test messages to trigger policy matches
- Review flagged communications and apply disposition tags
- Escalate violations to eDiscovery for legal preservation
- Analyze compliance reports

## Learning Outcomes

| Outcome | Validated By |
|---------|-------------|
| Create compliance policies | Policy active with supervised users |
| Review flagged messages | Messages tagged as compliant/non-compliant |
| Escalate to eDiscovery | Linked eDiscovery case created |

---

## Prerequisites

- [ ] Microsoft 365 **E5** or **Communication Compliance** add-on license
- [ ] Communication Compliance Admin role
- [ ] At least 2 test user accounts (supervised user + reviewer)

> ⚠️ The policy creator cannot be a supervised user. Use separate accounts for supervision and review.

---

## Section A — Create a Communication Compliance Policy

Navigate to **https://purview.microsoft.com → Solutions → Communication Compliance → Policies → Create policy**

### Step 1 — Choose a template
- Template: **Offensive and harassment language**
- Click **Next**

### Step 2 — Name the policy
- Name: `Lab - Offensive Language Detection`
- Click **Next**

### Step 3 — Choose supervised users
- **Supervised users:** Select your non-admin test user accounts
- **Reviewers:** Select your admin account
- Click **Next**

### Step 4 — Choose locations
Enable:
- ☑ Exchange (email)
- ☑ Teams (chat and channel messages)
- ☑ Viva Engage (if available)
- Click **Next**

### Step 5 — Review conditions
The template uses Microsoft's **Offensive language** trainable classifier by default.

Add a **custom keyword condition**:
- Condition: Content contains any of these words
- Keywords: `leak`, `insider trading`, `hide the loss`, `off the books`, `cook the books`
- Click **Next**

### Step 6 — Set capture percentage
- Capture: **100%** (default — appropriate for test)
- In production: lower % for high-volume users to reduce reviewer workload
- Click **Submit**

---

## Section B — Create a Second Policy: Financial Regulatory

### Step 1 — Create a new policy
- Template: **Financial regulatory compliance** (if available) or **Custom policy**
- Name: `Lab - Financial Regulatory Compliance`

### Step 2 — Configure conditions
- Classifier: **Regulatory collusion** and/or **Stock manipulation**
- Keywords: `short the stock`, `non-public information`, `MNPI`, `front running`
- Supervised: all test users
- Locations: Exchange and Teams

### Step 3 — Submit
- Capture: 100%
- Click **Submit**

---

## Section C — Generate Test Messages

Using a **supervised test user** account, send the following:

### Test message set 1 — Keyword triggers
Send via **Teams chat** to another test user:
```
We need to hide the loss this quarter before the earnings report.
```
```
I heard some insider trading is happening in the finance team.
```

### Test message set 2 — Classifier triggers
Send via **Outlook email** to another test user:
```
Subject: Confidential - Stock Strategy

We should short the stock before the announcement. 
This is non-public information, keep it between us.
```

> ⏱ Communication Compliance captures messages within **a few hours**. Check the policy for pending review items.

---

## Section D — Review Flagged Communications

Navigate to **Communication Compliance → Policies → Lab - Offensive Language Detection**

### Step 1 — Open pending review items
1. Click on the policy
2. Note the **Pending review** count
3. Click **Pending** tab

### Step 2 — Review a flagged message
For each flagged message, you can see:
- **Full message context** (thread view)
- **Why it was flagged** (classifier match or keyword hit)
- **User** who sent it
- **Timestamp** and platform

### Step 3 — Tag the message
After reviewing, apply a disposition tag:

| Tag | When to Use |
|-----|------------|
| **Compliant** | False positive — message is acceptable |
| **Non-compliant** | Genuine violation |
| **Questionable** | Unclear — needs secondary review |
| **Resolved** | Issue addressed with the employee |

1. Select a tag
2. Add a review note: `Test message — keyword triggered. Reviewed and resolved.`
3. Click **Resolve**

### Step 4 — Escalate a serious violation
For the "insider trading" message:
1. Click **Escalate**
2. Select: **Create eDiscovery case** to preserve as legal evidence
3. Name the case: `Lab - Regulatory Escalation 2026`
4. Click **Escalate**

### Step 5 — Send a notification to the user
For a non-compliant message:
1. Click **Notify user**
2. Choose a notification template (or create one)
3. The supervised user receives an email informing them of the policy violation

---

## Section E — Review Reports

Navigate to **Communication Compliance → Reports**

### Key reports to review:

| Report | What it Shows |
|--------|--------------|
| **Policy matches** | Count of matches per policy over time |
| **Matches by user** | Which supervised users triggered most matches |
| **Pending items** | Unreviewed matches by reviewer |
| **Resolved items** | Items tagged and closed |
| **Escalated items** | Items escalated to eDiscovery |

1. Set date range to **Last 30 days**
2. Export the **Policy matches** report to CSV for audit records

---

## Validation Checklist

- [ ] Two compliance policies active
- [ ] Test messages sent from supervised user accounts
- [ ] Flagged messages visible in the review queue
- [ ] At least one message tagged as Non-compliant
- [ ] At least one message escalated to eDiscovery
- [ ] Reports dashboard shows match counts

---

## Key Concepts

| Concept | Notes |
|---------|-------|
| **Trainable classifier** | ML model trained to detect policy, language, or regulatory content |
| **Capture percentage** | % of communications scanned; 100% = all messages reviewed |
| **Supervised user** | Whose communications are monitored |
| **Reviewer** | Who reviews flagged communications (cannot be the same as supervised) |
| **Privacy** | Flagged content visible only to designated reviewers — not all admins |
| **Retention** | Flagged messages preserved automatically during review |

---

## Trainable Classifiers Available

| Classifier | Use Case |
|-----------|----------|
| Offensive language | Harassment, discriminatory language |
| Threat | Threatening statements |
| Profanity | Inappropriate language |
| Regulatory collusion | Anti-competitive discussions |
| Stock manipulation | Financial market manipulation |
| Targeted harassment | Targeted personal attacks |

---

## Next Lab

➡ [Lab 07 — Data Map, Catalog & Lineage](../lab-07-data-map-catalog/README.md)
