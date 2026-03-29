# Sensitivity Labels & Information Classification

## Objectives

- Create a full sensitivity label taxonomy with parent and child labels
- Configure protection settings (access control, watermarks)
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

Navigate to **Information Protection → Policies → Label publishing policies**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/6f7742b3-ecef-4ce0-84cc-d6396c075bfe" />

### Step 1 — Create a new label policy

1. Select **Publish Policy**

2. Choose senstivity labels to publish

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/7be62551-709a-43c6-8341-d140f8b3df41" />

3. Skip **admin units** assignment

4. Scope to **all Users and groups**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/ff22613c-eb9e-4379-9d4d-756ff0f18140" />

5. Configure **Settings** 

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/4a868630-ad78-4d28-a243-3213f992428e" />
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/03ed824a-8898-4dd4-be53-6c74c3236934" />
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/ca1e7afa-1155-4b09-8351-3d5dd46cddbb" />
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/379db84f-5c1b-49bf-821c-7534e11313b8" />
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/3dac3c86-1f40-48a9-b087-4f0c06a378c4" />
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/34506bca-71d3-4d26-a780-8daa030dbc4a" />

6. Name: `Default Policy`

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/3e6dc4e9-76d2-43aa-853c-412dca335dad" />

7. Review settings and **Submit** to create label policy

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/5207f73c-dd20-4ef7-99fd-2f2cbb428874" />
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/bb7aae95-7749-4bb4-8abd-5bb31c326e81" />

> ⏱ **Note:** Policies take up to 24 hours to fully propagate.

---

## Section C — Enable built-in labeling for supported Office files and PDF files in SharePoint and OneDrive

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/bc006e35-0335-404a-885e-c51e23a62885" />

```powershell
Set-SPOTenant -EnableAIPIntegration $true
```
# Section C — Verify Changes

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/56b8f977-b28c-4dc5-93c5-9535f55056f8" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/5183bdb1-e7ec-4af7-91d1-5febfc2ab720" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/619446f5-1c42-4f53-960d-6b6bafe22c0c" />

---

## Section E — Configure Auto-Labeling

Navigate to **Information Protection → Policies → Auto-labeling policies → Create auto-labeling policy**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/26e22375-1bf2-4b57-a6d0-2d7a3aabd95f" />



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
