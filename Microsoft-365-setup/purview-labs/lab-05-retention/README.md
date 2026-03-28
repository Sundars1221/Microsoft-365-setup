# Lab 05 — Retention Policies & Labels

**Duration:** 60 minutes | **Level:** Core Skill | **Skill Area:** Records Management

---

## Objectives

- Create org-wide retention policies with different lifecycle rules
- Configure retention labels with disposition review
- Apply labels as regulatory records and test deletion prevention
- Understand the Preservation Hold Library behavior
- Test the disposition review workflow

---

## Section A — Retention Policies

Navigate to **https://purview.microsoft.com → Solutions → Data Lifecycle Management → Retention policies**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/b31ac2f5-9ff6-481d-9b01-d61002560f29" />

### Create a 7-year financial retention policy
1. Click **New retention policy**



2. Name: `7 Year Financial Retention` and Description: `Retain all financial data for 7 years`

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/cf4f2735-3a79-4d34-9053-49bc0959108a" />

3. Skip **admin units** assignment
4. Choose: **Static**
5. Click **Next**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/e47c5c5c-7f64-4a10-867c-8eba0b3a2d32" />


6. **Choose locations** to apply this policy

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/870fc506-0b90-4507-bb80-acad880ce56b" />

Enable:
| Location | Scope |
|----------|-------|
| Exchange mailboxes | All mailboxes |
| SharePoint sites | All sites |
| OneDrive accounts | All accounts |
| Microsoft 365 Groups | All groups |

Click **Next**

7. **Set retention settings**
- Retain items for: **7 years**
- Based on: **When items were created**
- After retention period: **Do nothing** (keep indefinitely)
- Click **Next → Submit**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/0c06670e-bbb2-4602-b316-1ab1c93e63ac" />

8. Review and **Submit**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/a7298f18-8932-4093-954a-a933bff6a2c6" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/a3010f83-1a65-4cb8-9ffc-d05cf6474164" />

## Section B — Retention Labels

Navigate to **https://purview.microsoft.com → Solutions → Data Lifecycle Management → Retention labels**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/dc60b24b-66ad-4d07-ae54-fb9c472cb91a" />

### Step 1 - Create a 5 year retention label
1. Click **Create a label**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/914376fd-4ddc-4b5d-a71f-1ffa2eca4204" />

2. Name: `HR Record - 5 Year` and Description: `Apply to HR records to retain them for next 5 years.`

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/ade42600-83be-4ae4-ab87-8d3d5b6e0a1e" />

3. **Set retention settings**
- Retain items for: **5 years**
- Based on: **When items were created**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/3a0f2792-72d2-4e84-b351-f09b7ccb3eab" />

4. To assign **Disposition review**, should be part of **Records Management** role groups

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/32d3ad1a-6b08-4487-93b7-86570b17d6b6" />

5. **Set disposition review**
- Create stages and assign reviewers
  
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/e6b1b0ad-4210-4964-9d5e-34aba0fa9137" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/8b898907-4d0d-4d22-9f41-d99ccc171efb" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/0c28f92b-461a-4464-b4fb-30f133f5337a" />

8. Review and **Create Label**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/53e861bc-b888-4117-8d96-9e0fc6beb469" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/344675d8-ca0b-4e99-af80-bc7fe4262f4e" />

### Step 2 — Publish the label
1. Click **Publish labels**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/da634738-26c1-4416-b3c8-6fff5855b9b9" />

2. Add label: **HR Record - 5 Year**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/e874349a-5e65-4be3-9516-749ef6165794" />

3. Skip **admin units** assignment
4. Choose: **Static**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/139d6f01-b3b3-44bf-a98f-405ed5f52600" />

3. Locations: SharePoint sites and OneDrive (All)

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/77dd52d3-57e9-4bf7-8d11-d3bf3b7ea18f" />

4. Name the policy: `HR Records Policy`

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/385ece40-d23c-4ac0-867a-f706fbd8f148" />

5. Click **Next → Submit**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/35d9f8e2-e10f-44c2-b940-370b21b796a9" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/5f65ac4d-a5b9-4592-83be-54168a870929" />
  
> ⏱ Allow up to 1 day for the label to appear in SharePoint document libraries.

## Section C — Verify changes

### Step 1 — Apply the label in SharePoint
1. Go to a SharePoint document library
2. Select a test document
3. Click **Details pane** (ⓘ icon) on the right
4. Under **Retain**, click **Apply label**
5. Choose: **Financial Record - 7 Year**
6. Click **Save**

### Step 2 — Attempt to delete the labeled document
1. Select the labeled document
2. Click **Delete**
3. ✅ You should see an error:
   ```
   This item has been declared a record and cannot be deleted.
   ```

### Step 3 — Review the Preservation Hold Library
1. Go to the SharePoint site
2. Navigate to: **Site contents → Preservation Hold Library**
3. If any items were deleted while under retention (from a non-regulatory label), they appear here
4. Preserved items cannot be permanently deleted until the retention period ends

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
