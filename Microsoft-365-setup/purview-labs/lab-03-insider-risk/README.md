# Insider Risk Management

---

## Objectives

- Configure Insider Risk Management indicators, thresholds, and priority content
- Create a data theft policy using the departing user template
- Generate test signals to trigger alerts
- Investigate a case using the user activity timeline
- Escalate a case to eDiscovery

---

## Section A — Initial Setup

Navigate to **https://purview.microsoft.com → Solutions → Insider Risk Management**

### Step 1 — Accept privacy notice
First time opening IRM, click **Accept** on the Microsoft privacy notice.

### Step 2 — Configure privacy settings
Go to **Settings → Privacy**
- Select: **Show anonymized versions of usernames**
- This pseudonymizes user data in alerts (e.g., `User1` instead of real name)

### Step 3 — Configure indicators
Go to **Settings → Indicators**

Enable the following:
| Category | Indicators to Enable |
|----------|---------------------|
| Office indicators | File downloaded from SharePoint, File copied to USB |
| Exfiltration | Sending email with attachment to outside org |
| Device | Printing sensitive files |
| Risk score boosters | ☑ Cumulative exfiltration activities |

Click **Save**

### Step 4 — Set detection thresholds
Go to **Settings → Intelligent detections**
- Set thresholds to: **Low** (generates alerts more easily in test environment)
- Click **Save**

### Step 5 — Configure priority content
Go to **Settings → Priority content**

Add the following:
- **Sensitivity labels:** `Confidential`, `Confidential - Finance`, `Confidential - HR`
- **SharePoint sites:** Add a test SharePoint site URL
- Click **Save**

> Priority content increases the risk score when it is involved in potentially risky activities.

---

## Section B — Create an Insider Risk Policy

Navigate to **Insider Risk Management → Policies → Create policy**

### Step 1 — Select template
- Template: **Data theft by departing users**
- This detects unusual data exfiltration activity 90 days before/after an employee departure
- Click **Next**

### Step 2 — Name the policy
- Name: `Lab - Departing User Data Theft`
- Description: `Detects data exfiltration near employee departure`
- Click **Next**

### Step 3 — Choose users and groups
- Select: **All users** (for lab purposes)
- In production: target only HR-flagged departing users
- Click **Next**

### Step 4 — Configure priority content
- Add sensitivity labels: `Confidential - Finance`, `Confidential - HR`
- Add SharePoint sites from your test environment
- Click **Next**

### Step 5 — Set triggers
- Primary trigger: **Resignation date indicator from HR connector**
- Also enable: **User performs a high volume of file downloads** (for lab testing without HR data)
- Click **Next**

### Step 6 — Review and submit
- Leave threshold scores at default
- Click **Submit**
- Policy activates within a few minutes

---

## Section C — Generate Test Signals

Using a **non-admin test user account**, perform the following activities to generate IRM signals:

### Activity 1 — Bulk SharePoint downloads
1. Log in as the test user
2. Go to a SharePoint document library with 15–20 files
3. Download all files in rapid succession (individually, not as ZIP)

### Activity 2 — External email with attachments
1. Compose an email from the test user to an external address (your Gmail)
2. Attach 3–5 documents labeled `Confidential` or `Internal Only`
3. Send the email

### Activity 3 — OneDrive personal upload (simulated)
1. If personal cloud upload is not blocked, try uploading to a personal OneDrive/Dropbox
2. This triggers the **exfiltration to personal cloud** indicator

> ⏱ Alerts may take **24–48 hours** in a test tenant. Check the Alerts tab regularly.

---

## Section D — Investigate an Alert & Case

### Step 1 — Review the alert
Navigate to **Insider Risk Management → Alerts**
1. When an alert appears, click on it
2. Review:
   - **Risk score** (0–100)
   - **Contributing factors** listed
   - **Activity summary**

### Step 2 — Confirm the alert (create a case)
1. Click **Confirm alert**
2. This promotes the alert to a full **Case**
3. Add a case note: `Test investigation - bulk downloads detected. Reviewing file types and destinations.`

### Step 3 — Explore the user activity timeline
1. In the case, click **User activity**
2. Review the chronological view of all user actions
3. Filter by activity type:
   - **File operations** — downloads, copies, prints
   - **Email** — external sends with attachments
   - **Cloud app activity** — personal cloud uploads

### Step 4 — Review the Content Explorer (E5 only)
1. In the case, go to **Content explorer**
2. Browse the actual files the user accessed
3. Note the sensitivity labels on accessed files

### Step 5 — Add case notes
Navigate to the **Notes** tab in the case
- Add: `All downloads confirmed as financial reports. User had legitimate access but volume is unusual. Escalating for review.`
- Save

### Step 6 — Escalate to eDiscovery
1. In the case actions, click **Escalate for investigation**
2. This creates a linked eDiscovery (Premium) case
3. Note the case name — you will use this in Lab 04

---

## Validation Checklist

- [ ] Insider Risk policy is active (green status)
- [ ] Test signals generated by non-admin user
- [ ] Alert appeared with a risk score
- [ ] Case created from alert
- [ ] User activity timeline shows events
- [ ] Case escalated to eDiscovery

---

## Key Concepts

| Concept | Notes |
|---------|-------|
| **Risk score** | Cumulative score based on detected risky activities; 0–100 |
| **Sequence detection** | Series of risky actions in short time scores higher than individual actions |
| **Priority content boost** | Activities involving priority labels/sites multiply the risk score |
| **HR triggers** | Resignation/termination triggers amplify risk scores significantly |
| **Anonymization** | User pseudonymization can be toggled per-investigation after alert confirmation |

---

## Insider Risk Indicators Summary

```
Low risk signals (individually)       High risk signals
─────────────────────────────         ────────────────────────────
• Occasional file download            • 50+ downloads in 24 hours
• Email with attachment               • Multiple external sends + downloads
• Single USB copy                     • USB copy + cloud upload sequence
                        ↘                         ↙
                    SEQUENCE DETECTION combines these into
                    a cumulative high-risk score
```

---

## Next Lab

➡ [Lab 04 — eDiscovery & Audit Investigations](../lab-04-ediscovery/README.md)

> If you escalated an IRM case to eDiscovery in Step 6, that case will be available in Lab 04.
