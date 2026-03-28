# Lab 02 — Data Loss Prevention (DLP) Policies

**Duration:** 90 minutes | **Level:** Core Skill | **Skill Area:** DLP

---

## Objectives

- Build multi-location DLP policies across Exchange, SharePoint, Teams, and Endpoint
- Configure policy tips, override justification, and blocking rules
- Set up incident reporting and alerts
- Test DLP with real Sensitive Information Types (SITs)
- Review events in Activity Explorer

## Learning Outcomes

| Outcome | Validated By |
|---------|-------------|
| Create multi-location DLP policy | Policy visible, Mode = TestWithNotifications |
| Configure block vs. notify | Policy tip appears; external send blocked |
| Test with realistic data | Alerts appear in DLP Alerts dashboard |

---

## Prerequisites

- [ ] Lab 01 completed (sensitivity labels created)
- [ ] Microsoft 365 E3/E5 test tenant
- [ ] A personal external email address (Gmail) for testing
- [ ] A test Windows device (for Endpoint DLP section)

---

## Section A — Create a DLP Policy for Financial Data

Navigate to **https://purview.microsoft.com → Solutions → Data Loss Prevention → Policies → Create policy**

### Step 1 — Select a template
- Category: **Financial**
- Template: **U.S. Financial Data**
  - Includes: Credit Card Number, ABA Routing Number, US Bank Account
- Click **Next**

### Step 2 — Name the policy
- Name: `Lab - US Financial Data Protection`
- Description: `Blocks sharing of US financial data externally`

### Step 3 — Select locations
Enable all of the following:
- ☑ Exchange email
- ☑ SharePoint sites
- ☑ OneDrive accounts
- ☑ Teams chat and channel messages

> Leave **Devices** and **Defender for Cloud Apps** for Section B.

### Step 4 — Customize conditions
Change the default to:
- Content contains: **Credit Card Number**
- Confidence level: **High**
- Instance count: **2 or more**

### Step 5 — Configure actions
- For external sharing: **Block everyone except content owners**
- ☑ Show policy tip to users
- Customize tip: `This message contains financial data and cannot be shared externally.`

### Step 6 — Set notifications
- ☑ Send incident reports
- Severity: **High**
- Send email to: your admin account

### Step 7 — Enable in test mode
- Select: **Test it out first — show policy tips**
- Click **Submit**

### Step 8 — Test the policy
1. Compose an email to your external Gmail address
2. Body text: `Please process card number 4539578763621486 and 4916338506082832`
3. Observe the **policy tip** appearing before you send
4. Check your admin inbox for the incident report email

---

## Section B — Endpoint DLP

### Step 1 — Enable Endpoint DLP
Navigate to **DLP → Settings → Endpoint DLP settings**
- Verify device onboarding is configured

### Step 2 — Onboard a test device
1. Go to **Settings → Device onboarding → Onboarding**
2. Download the **onboarding script** (Local Script)
3. Run as Administrator on your test Windows machine
4. Verify device appears in the **Devices** list within 5–10 minutes

### Step 3 — Create an Endpoint DLP policy
1. Create a new DLP policy
2. Name: `Lab - Endpoint PII Protection`
3. Location: **Devices only**

### Step 4 — Configure endpoint actions
- Condition: Content contains **US Social Security Number (SSN)**
- Action: **Audit only** (for safe testing)
- ☑ Audit file activities on device

### Step 5 — Test on the endpoint
On the onboarded device:
1. Create a text file with content: `SSN: 123-45-6789`
2. Try to copy it to a USB drive
3. Try to upload to a personal cloud storage site

### Step 6 — Review endpoint alerts
Navigate to **DLP → Alerts** and filter by `Lab - Endpoint PII Protection`
- Review: file name, user, action type, device name

---

## Section C — DLP Alerts & Activity Explorer

### Step 1 — Open DLP Alerts
Navigate to **Data Loss Prevention → Alerts**
- Filter by: `Lab - US Financial Data Protection`

### Step 2 — Investigate an alert
Click on an alert and review:
- Matched content snippet
- User who triggered it
- Location (mailbox/site)
- Confidence level
- Matched rule name

### Step 3 — Review Activity Explorer
Navigate to **Data classification → Activity explorer**
- Filter: **Activity = DLP rule matched**
- Review the timeline of DLP events across all locations

### Step 4 — Export events
- Click **Export** in Activity Explorer
- Download CSV
- Open in Excel and review columns: `Date`, `User`, `Activity`, `Item`, `Policy`, `Rule`

---

## Validation Checklist

- [ ] Policy tip appears when composing an email with financial data
- [ ] Incident report email arrives in admin mailbox
- [ ] DLP Alerts dashboard shows matched events
- [ ] Activity Explorer shows DLP rule matched entries
- [ ] Endpoint DLP logs file copy activities on onboarded device

---

## Test Data Reference

Use these **test values only** — they pass Luhn checks but are not real card numbers:

| Type | Test Value |
|------|-----------|
| Visa | 4539578763621486 |
| Mastercard | 5425233430109903 |
| SSN (fake) | 123-45-6789 |
| ABA Routing | 021000021 |

---

## Key Concepts

| Concept | Notes |
|---------|-------|
| **SITs** | Sensitive Information Types — built-in pattern-matching classifiers |
| **Confidence levels** | High / Medium / Low — reduce false positives by using High |
| **Policy tips** | User-facing notifications before a policy violation occurs |
| **Test mode** | Logs events and shows tips but does NOT block — safe for initial testing |
| **Override justification** | Users can override with a reason — all overrides are audited |

---

## Troubleshooting

| Issue | Resolution |
|-------|-----------|
| Policy tip not showing | Wait 1 hour after policy creation; check Office app version |
| Alert not triggering | Verify instance count threshold; check confidence level |
| Endpoint not appearing | Re-run onboarding script as local admin; check firewall rules |

---

## Next Lab

➡ [Lab 03 — Insider Risk Management](../lab-03-insider-risk/README.md)
