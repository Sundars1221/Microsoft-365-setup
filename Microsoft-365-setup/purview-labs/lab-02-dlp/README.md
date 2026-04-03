# Data Loss Prevention (DLP) Policies

---

## Objectives

- Build multi-location DLP policies across Exchange, SharePoint, Teams, and Endpoint
- Configure policy tips, override justification, and blocking rules
- Set up incident reporting and alerts
- Test DLP with real Sensitive Information Types (SITs)
- Review events in Activity Explorer

---

## Section A — Create a DLP Policy for Financial Data

Navigate to **https://purview.microsoft.com → Solutions → Data Loss Prevention → Policies → Create policy**

<img width="1920" height="1200" alt="image" src="https://github.com/user-attachments/assets/85a61f60-e36a-4da8-bf4b-1816ae1d790e" />

### Step 1 — Choose info which do you want to protect
- Choose **Enterprise applications & devices**

### Step 2 — Select a template
- Category: **Financial**
- Template: **U.S. Financial Data**
  - Includes: Credit Card Number, ABA Routing Number, US Bank Account
- Click **Next**

<img width="1920" height="1200" alt="image" src="https://github.com/user-attachments/assets/60bbb170-1425-4b63-8b1e-5408038f4e81" />

### Step 3 — Name the policy
- Name: `US Financial Data Protection`
- Description: `Blocks sharing of US financial data externally`

<img width="1920" height="1200" alt="image" src="https://github.com/user-attachments/assets/36ad2f57-425e-4374-baf9-b77dd5ad1aba" />

### Step 4 — Assign admin units
- Skip Admin units

### Step 5 — Select locations
Enable all of the following:
- ☑ Exchange email
- ☑ SharePoint sites
- ☑ OneDrive accounts
- ☑ Teams chat and channel messages

<img width="1920" height="1200" alt="image" src="https://github.com/user-attachments/assets/4de78c11-0282-4df6-af2c-021089b76029" />

### Step 4 — Define policy settings
- Review and customize default settings
- or create advanced DLP rules

<img width="1920" height="1200" alt="image" src="https://github.com/user-attachments/assets/af1a6ca5-6ef3-4b17-8c7a-e3f0a1d88f02" />

- Info to protect
- Detect when this content is shared from Microsoft 365 → "With people outside my organization"

<img width="1920" height="1200" alt="image" src="https://github.com/user-attachments/assets/f3dffcb8-5e4b-44f0-a977-5dcc031292c3" />

### Step 5 — Protect actions
- ☑ Show policy tip to users
- Customize tip: `This message contains financial data and cannot be shared externally.`
- Configure specific set of admins to be notified
- Upate compliance URL for end user

<img width="1920" height="1200" alt="image" src="https://github.com/user-attachments/assets/d7bab996-aa76-4de8-840b-f9e116dc7c9e" />

<img width="1920" height="1200" alt="image" src="https://github.com/user-attachments/assets/b77933c6-743f-4cb5-8bed-7aef9b51534a" />

<img width="1920" height="1200" alt="image" src="https://github.com/user-attachments/assets/d5efdbfc-dd15-4380-b724-9bb8f6794f32" />

- ☑ Send alerts if any of the DLP rules match  (optional)
- ☑ Send incident reports

<img width="1920" height="1200" alt="image" src="https://github.com/user-attachments/assets/a314d267-476d-4c89-bddb-57dcb0f0ec45" />

### Step 7 — Customize access and override settings

<img width="1920" height="1200" alt="image" src="https://github.com/user-attachments/assets/8075d955-ce9d-49e5-90dc-c11deb5dc886" />

### Step 8 — Run the policy in simulation mode
- Select: **Show policy tips while in simulation mode**
- Click **Next**

<img width="1920" height="1200" alt="image" src="https://github.com/user-attachments/assets/f5f7e53c-152b-4cfd-a336-e8f2cb310e93" />

### Step 8 — Review and create policy

<img width="1920" height="1200" alt="image" src="https://github.com/user-attachments/assets/65f30ac8-9188-470c-a1a9-669e3d8f11d9" />

<img width="1920" height="1200" alt="image" src="https://github.com/user-attachments/assets/41dd2b8d-1534-4ea9-9a20-de10cdbfa154" />

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
