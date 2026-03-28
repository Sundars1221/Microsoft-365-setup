# Sensitivity Labels & Information Classification

## Objectives

- Create a full sensitivity label taxonomy with parent and child labels
- Configure protection settings (encryption, visual markings, watermarks)
- Publish labels via a label policy to users
- Apply labels manually in Word and Outlook
- Configure and test auto-labeling policies in simulation mode

## Section A — Create Sensitivity Labels

Navigate to **https://purview.microsoft.com → Solutions → Information Protection → Senstivity Labels**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/90e4e237-ae73-4800-951c-c1bc5a31b782" />

### Step 1 — Create parent label: `Highly Confidential`
1. Click **Create a label**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/3bd202a3-7e2b-47b4-bf5b-09c157dedbbf" />

2. Name: `Confidential` and Description: `Sensitive business data`
   
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/04197831-cb4c-4782-97df-c8d76657450f" />

3. Click **Next** through **Scope** section, we'll enable scope for group & sites later

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/8f027123-beb7-4805-950e-d66447f4f0e6" />

4. Select **Control access** and **Apply content marking**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/872e5f7f-9faa-465f-abb0-60c684ba6c05" />

5. Configure **Access control** and **Content marking**, then next

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/b225d0c9-50b2-451b-9c21-9898611f525c" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/018a9dfc-daaf-40db-9e3b-7f10465bcd6d" />

6. Skip **Auto-labelling** and **Group & sites** section

7. Review settings and **Create label**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/b7c049d1-3d59-4eba-a183-35b33ec989c8" />
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/b9fecb66-088f-4194-aa7a-c87787c079f5" />


### Step 2 — Create child label: `Confidential - HR`
1. Create new label, Name: `Confidential - HR`  and Description: `Confidential - HR data`

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/b78fb9f1-3077-4553-be1f-d740f00d56d5" />

2. Click **Next** through **Scope** section

3. Select **Control access** and **Apply content marking**

4. Configure **Access control** and assign permissions to HR security group

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/4a72485f-078a-4e03-aaf5-cb9a31a8d12f" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/30604a6c-2833-4a68-ac23-2edf2dc96539" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/a10a12b2-ed7f-4432-9c1a-29f15e79dc12" />

5. Assign custom permissions to block **Print** and **Forward**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/3719c38d-7ed0-421a-8c75-b4ab2e495d6c" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/293459c7-3a9b-434b-ac74-f200b1059f08" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/8fae095f-416d-4e4c-9eab-8a42b2ff011c" />

6. Configure **Content marking**, then next

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/7e492b21-7e9d-417f-96f8-07bb143ee0d2" />

6. Skip **Auto-labelling** and **Group & sites** section

7. Review settings and **Create label**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/e0671bad-8e48-4dae-a2e2-a13102e9426c" />

8. Move created label under "Confidential" label group

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/28f2f5f3-f33b-49d0-b325-58c7a6dbbdc1" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/decb8ddb-acf6-4c3d-8650-fad1e8fd9ed3" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/09d87f22-850f-4a48-a888-f2cb81eb9d48" />

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
