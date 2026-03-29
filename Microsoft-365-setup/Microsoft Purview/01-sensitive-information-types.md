# Sensitive Information Types (SITs)

## Objective

- Create a custom SIT using regex patterns and keyword validators
- Build a keyword dictionary SIT from a word list
- Configure an EDM classifier against a real data schema
- Upload and hash EDM source data
- Test all classifiers in Content Explorer and DLP policies
  
## Background — Classification Methods Compared

```
Pattern matching (Regex SIT)
────────────────────────────
Detects: EMP-12345, EMP-99999
Pros: No data upload needed, fast setup
Cons: False positives (matches any EMP-##### string)

Keyword dictionary SIT
──────────────────────
Detects: exact words from your list (e.g. project codenames)
Pros: Simple, no regex needed
Cons: Exact match only, no fuzzy matching

Exact Data Match (EDM)
──────────────────────
Detects: only values that exist in YOUR actual data table
e.g. matches "EMP-10042" only if 10042 is in your employee DB
Pros: Near-zero false positives
Cons: Requires data upload + hashing pipeline, E5 license
```
---

## Section A — Create a Custom Regex SIT

Navigate to **https://purview.microsoft.com → Solutions → Data loss prevention → Sensitive info types → + Create sensitive info type**

<img width="1920" height="1200" alt="image" src="https://github.com/user-attachments/assets/8205b7a9-8aba-4a35-8526-f89a7dc8117d" />

### Step 1 — Name the SIT

- **Name:** `Contoso Employee ID`
- **Description:** `Matches internal employee IDs in format EMP-NNNNN`
- Click **Next**
  
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/4dbcdab3-b1a1-49fd-824f-fde4214aed97" />

### Step 2 — Define the primary pattern

1. Click **+ Create pattern**
2. **Confidence level:** High
3. **Primary element:** Regular expression
4. **Character proximity:** `300` characters

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/e6f5243f-0929-4e0c-a542-671f40beede2" />

Regex to detect `EMP-` followed by exactly 5 digits:

```regex
[A-Z]{3}-[0-9]{5}
```

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/e2238ca1-f912-471f-89bd-d17ba87475e8" />

4. Click **Done**

### Step 3 — Add a supporting element (keyword validator)

Supporting elements reduce false positives by requiring nearby keywords.

1. In the pattern, click **+ Add supporting element**
2. Select: **Keyword list**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/9ef03737-f832-4dbd-a94f-ed51c5bdabc0" />

3. Keywords (one per line):
   ```
   employee ID
   employee number
   staff ID
   EMP ID
   personnel number
   ```
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/e292d4b7-bfb9-4e78-b546-b89438d805be" />

4. Click **Done**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/71a96183-d2c2-427c-9e20-11dcd0473828" />

### Step 4 — Review set confidence thresholds

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/3e7b9fbe-1c4d-414e-855e-c8292e75acc1" />

### Step 5 — Review and **Create**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/8b1ac11c-20c6-4cf4-8ca5-aba20c1ae08d" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/34ad5849-5ed8-4093-b7e5-0202d676178c" />

Review the pattern summary → click 

### Step 6 — Test the SIT

1. Paste this test content into any text based file:
```
employee ID
EMP-10042, EMP-83771, EMP-00293

```

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/b0d57df0-04a7-44ac-9fb7-e27e80d42081" />

2. Select custom SIT **Contoso Employee ID** and click **Test**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/92cbc83d-56ef-4b5d-943b-6cafed7f1884" />

3. Upload SIT test file → **Test**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/1c152b8c-1a9b-4cf4-8990-008e57d45178" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/52eb7b18-b2e7-4742-adde-7d414aa3a969" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/9285a34f-7c67-47ce-ab3d-1e20d0a00768" />

---

## Section B — Create a Second Regex SIT: Project Code

### Step 1 — Create the SIT

- **Name:** `Contoso Project Code`
- **Description:** `Internal project codes in format PROJ-[YEAR]-[4 digits]`

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/bfe05c74-8655-4f74-be03-4d3644ce272e" />

### Step 2 — Define the primary pattern

1. Click **+ Create pattern**
2. **Confidence level:** High
3. **Primary element:** Regular expression
4. 4. **Character proximity:** `300` characters

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/d24cb372-9fbd-4192-b4c1-eb3801bf3c28" />

Regex to detect `PROJ-` followed by `year-` and 5 digits:

```regex
\bPROJ-20[0-9]{2}-[0-9]{4}\b
```

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/f62ace3b-4151-4529-b550-48430d459af4" />

Examples matched: `PROJ-2024-1042`, `PROJ-2026-9901`

### Step 3 — Add supporting keywords

1. In the pattern, click **+ Add supporting element**
2. Select: **Keyword list**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/c60beb45-2af1-45a2-b472-97e513c22105" />

```
project code
project number
project ID
initiative code
```

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/74dc1572-a6d2-498a-860e-bd8316363f4c" />

3. Click **Done**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/43ca2f6b-a545-4f91-aa68-eb6381fbd12e" />

### Step 4 — Review set confidence thresholds

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/e367c8ce-3df3-453b-b1ab-8e2dff654ad1" />

### Step 5 — Review and **Create**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/2b634353-6878-4840-90bb-e91c76cc0170" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/680bdfa4-25ca-4d46-8edd-18767cdcaeef" />

### Step 6 — Test the SIT

1. Paste this test content into any text based file:
```
Budget approval required for PROJ-2026-1042 and PROJ-2025-8833.
Please include your project code on all expense submissions.
```

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/71c2d4a8-b572-4165-8482-fb54b5a548e1" />

2. Select custom SIT **Contoso Project Code** and click **Test**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/467d8610-d170-48ba-9fe2-81f432b336f3" />

3. Upload SIT test file → **Test**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/d60dbc89-1ceb-45da-a844-033ba522abf5" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/1e6116c0-3cf2-4a64-9c17-881703a13a07" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/39d21ef1-3829-4f3d-91d5-9e0ac7698d9d" />

---

## Section C — Create a Keyword Dictionary SIT

Keyword dictionaries are useful for lists of terms — internal codenames, restricted product names, regulated terminology.

### Step 1 — Prepare your keyword list

Create a plain text file `contoso-restricted-projects.txt`:

```
Operation Nightfall
Project Bluebird
Initiative Cerberus
Codename Atlas
Operation Phoenix
Project Titan
Initiative Sparrow
Classified Venture Alpha
Restricted Program Delta
```

### Step 2 — Create the keyword dictionary SIT

Navigate to **Classifiers → Sensitive info types → + Create**

1. **Name:** `Contoso Restricted Project Names` and **Description:** `Detects internal restricted project codenames`
2. Click **Next**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/9af397ec-c8e7-400c-ab86-6f59ca386430" />

4. **Create pattern** → Primary element: **Keyword dictionary**
5. Click **+ Create keyword dictionary**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/4460a278-90d6-4ba4-bad2-db1bef327ec9" />

6. **Dictionary name:** `Contoso Restricted Projects`
7. **Upload keywords:** upload your `contoso-restricted-projects.txt` file
   - Or paste the list directly into the text box

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/2c1b9bb1-217a-4f85-8705-6d7c91cbef11" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/ac787c68-79b0-4c90-adb7-f3bbc61f10fb" />

8. Click **Done**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/5622d4ac-0a2a-4e79-a140-9b2748d3bd6e" />

### Step 3 — Review set confidence thresholds

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/70ed42ca-a555-4806-93d9-e0ebba9b161d" />

### Step 5 — Review and **Create**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/2d19f1df-1d3c-4ffd-9acf-63d9229904f8" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/3acc8297-f9e4-434f-94a5-c27662d1d0a3" />

### Step 6 — Test the dictionary SIT

1. Paste this test content into any text based file:
```
Quarterly briefing: Operation Nightfall has entered Phase 2.
All stakeholders for Project Titan should report to Room 4B.
Standard project updates for Q3 will follow normal process.
```

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/c268065c-642d-4e4e-91e9-78837b56bdbf" />

2. Select custom SIT **Contoso Restricted Project Names** and click **Test**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/4c6f6848-3b16-4728-b651-f9e16a109d69" />

3. Upload SIT test file → **Test**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/b0dc5630-7af3-48ee-b682-290e33bca399" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/2c31d009-ad67-4faa-948c-cd20dcd4a6fa" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/dd453164-7d9b-4931-8d20-4ce6d79b5d81" />

---

## Section D — Exact Data Match (EDM) Setup

EDM matches content against actual records from your organization's database. It has 4 components:

```
1. EDM Schema       — defines the columns and which are searchable
2. Sensitive data   — your actual CSV data (employee/customer records)
3. Hash + upload    — data is hashed before upload (never stored in plaintext)
4. EDM SIT          — the classifier that uses the schema to detect matches
```

### Step 1 — Create sample EDM data (CSV)

Create a file named `EmployeeData.csv` with this content:

```csv
EmployeeID,FirstName,LastName,Email,Department,NationalID
EMP-10042,James,Holloway,j.holloway@contoso.com,Finance,987-65-4320
EMP-10043,Priya,Sharma,p.sharma@contoso.com,HR,987-65-4321
EMP-10044,David,Okafor,d.okafor@contoso.com,Finance,987-65-4322
EMP-10045,Sarah,Mitchell,s.mitchell@contoso.com,Legal,987-65-4323
EMP-10046,Chen,Wei,c.wei@contoso.com,Engineering,987-65-4324
EMP-10047,Amara,Diallo,a.diallo@contoso.com,Finance,987-65-4325
EMP-10048,Liam,Burke,l.burke@contoso.com,HR,987-65-4326
EMP-10049,Fatima,Al-Hassan,f.alhassan@contoso.com,Legal,987-65-4327
EMP-10050,Ravi,Patel,r.patel@contoso.com,Engineering,987-65-4328
```

### Step 2 — Define the EDM schema

Navigate to **Purview → Classifiers → EDM classifiers → + Create EDM schema**

1. **Schema name:** `ContosoEmployeeSchema`
2. **Description:** `Employee data schema for EDM classification`
3. Click **Next**

### Step 3 — Add schema fields

Add each column from your CSV:

| Field name | Searchable | Ignored delimiters | Match case insensitive |
|-----------|-----------|-------------------|----------------------|
| EmployeeID | ☑ Yes | Hyphen `-` | ☑ Yes |
| FirstName | ☑ Yes | | ☑ Yes |
| LastName | ☑ Yes | | ☑ Yes |
| Email | ☑ Yes | | ☑ Yes |
| Department | ☐ No | | |
| NationalID | ☑ Yes | Hyphen `-` | ☑ Yes |

> Mark only the fields you want Purview to scan documents for as **Searchable**. Non-searchable fields are used as corroborating evidence only.

4. Click **Next → Submit**

### Step 4 — Create the EDM SIT

Navigate to **Classifiers → Sensitive info types → + Create**

1. **Name:** `Contoso Employee EDM`
2. **Description:** `Exact match against Contoso employee records`
3. Click **Next**
4. **Primary element:** **EDM data store**
5. Select schema: **ContosoEmployeeSchema**
6. **Primary field:** `EmployeeID`
7. **Corroborating fields** (add at least one for high confidence):
   - `LastName`
   - `Email`
8. Click **Done → Next → Create**

---

## Section E — Hash and Upload EDM Data

EDM data is **never uploaded in plaintext**. The upload tool hashes the data locally and only sends the hash to Microsoft.

### Step 1 — Install the EDM Upload Agent

```powershell
# Download the EDM Upload Agent
$url = "https://go.microsoft.com/fwlink/?linkid=2088639"
Invoke-WebRequest -Uri $url -OutFile "$env:TEMP\EdmUploadAgent.exe"

# Install (run the downloaded installer as Administrator)
Start-Process "$env:TEMP\EdmUploadAgent.exe" -Wait
```

After installation, the tool is at:
```
C:\Program Files\Microsoft\EdmUploadAgent\EdmUploadAgent.exe
```

### Step 2 — Authenticate the EDM Upload Agent

```powershell
cd "C:\Program Files\Microsoft\EdmUploadAgent"

# Authenticate with your compliance admin credentials
.\EdmUploadAgent.exe /Authorize
# A browser window opens — sign in with your admin account
```

### Step 3 — Hash the CSV data

```powershell
# Hash the data (creates a .edmhash file — this is what gets uploaded, not the CSV)
.\EdmUploadAgent.exe /CreateHash `
    /DataStoreName ContosoEmployeeSchema `
    /DataFile "C:\EDMData\EmployeeData.csv" `
    /HashLocation "C:\EDMData\Hashed" `
    /Schema "C:\EDMData\ContosoEmployeeSchema.xml" `
    /AllowedBadLinesPercentage 5

# Expected output:
# Hashing complete. Output written to: C:\EDMData\Hashed\
```

> The `/AllowedBadLinesPercentage 5` flag tolerates up to 5% malformed rows without failing the job.

### Step 4 — Retrieve and save the schema XML

```powershell
# Save your schema to XML (needed for hashing)
.\EdmUploadAgent.exe /SaveSchema `
    /DataStoreName ContosoEmployeeSchema `
    /OutputDir "C:\EDMData"

# Verify the schema file was saved
Get-Item "C:\EDMData\ContosoEmployeeSchema.xml"
```

### Step 5 — Upload the hashed data

```powershell
# Upload the hashed data to Purview
.\EdmUploadAgent.exe /UploadHash `
    /DataStoreName ContosoEmployeeSchema `
    /HashLocation "C:\EDMData\Hashed"

# Monitor upload progress
.\EdmUploadAgent.exe /GetSession `
    /DataStoreName ContosoEmployeeSchema
```

### Step 6 — Verify the upload

```powershell
# Check that data is indexed and ready
.\EdmUploadAgent.exe /GetSession /DataStoreName ContosoEmployeeSchema

# Expected output when ready:
# Processing Complete. Your EDM table is ready.
```

> Indexing typically takes **15–60 minutes** for small datasets. Large datasets can take several hours.

---

## Section F — Test EDM Classification

### Step 1 — Test in the Purview SIT tester

1. Navigate to **Classifiers → Sensitive info types → Contoso Employee EDM**
2. Click **Test**
3. Paste this content:

```
Please process the termination for EMP-10042 (James Holloway).
Contact: j.holloway@contoso.com for exit interview confirmation.
```

✅ Expected: **1 match at High confidence** (EmployeeID + corroborating LastName + Email all present)

### Step 2 — Test with partial match (medium confidence)

```
Action required for employee EMP-10043.
Please update records accordingly.
```

✅ Expected: **1 match at Medium confidence** (EmployeeID only, no corroborating fields)

### Step 3 — Test with non-existent ID (should NOT match)

```
Please review account EMP-99999 for access rights.
Contact the HR team for employee number EMP-77777.
```

✅ Expected: **0 matches** — these IDs do not exist in your uploaded data

> This is the power of EDM — pattern-based SITs would have matched `EMP-99999`. EDM only matches real records.

---

## Section G — Use SITs in DLP and Auto-labeling

### Apply custom SITs in a DLP policy

Navigate to **Data Loss Prevention → Policies → Create policy → Custom policy**

```
Name: Lab - Custom SIT DLP Policy
Locations: Exchange, SharePoint, OneDrive, Teams

Condition:
  Content contains sensitive info types:
    - Contoso Employee ID          (High confidence, 1+ instances)
    - Contoso Employee EDM         (High confidence, 1+ instances)

Action:
  Block external sharing
  Show policy tip: "This document contains internal employee data."

Mode: Test with notifications
```

### Apply custom SITs in auto-labeling

Navigate to **Information Protection → Auto-labeling policies → Create**

```
Name: Auto-label Employee Data
Label to apply: Confidential - HR

Condition:
  Content contains:
    - Contoso Employee EDM (High confidence)

Locations: SharePoint (All sites), OneDrive (All)
```

---

## Section H — PowerShell Reference

```powershell
Connect-IPPSSession -UserPrincipalName admin@yourtenant.onmicrosoft.com

# ── List all custom SITs ──────────────────────────────────────────────────────
Get-DlpSensitiveInformationType |
    Where-Object { $_.Publisher -ne "Microsoft Corporation" } |
    Select-Object Name, Id, RecommendedConfidence, Description |
    Format-Table -AutoSize

# ── Get full detail on a specific SIT ────────────────────────────────────────
Get-DlpSensitiveInformationType -Identity "Contoso Employee ID" |
    Select-Object -ExpandProperty PrimaryRequirements

# ── List EDM data stores ──────────────────────────────────────────────────────
Get-DlpEdmSchema | Select-Object Name, Description | Format-Table

# ── Get EDM schema fields ─────────────────────────────────────────────────────
Get-DlpEdmSchema -Identity "ContosoEmployeeSchema" |
    Select-Object -ExpandProperty Fields

# ── Create a simple SIT via PowerShell ───────────────────────────────────────
$pattern = New-DlpSensitiveInformationTypeRulePackage `
    -FileData ([System.IO.File]::ReadAllBytes("C:\SIT\MyCustomSIT.xml"))

# ── Export SIT rule package to XML ───────────────────────────────────────────
Get-DlpSensitiveInformationTypeRulePackage |
    Where-Object { $_.Name -ne "Microsoft Rule Package" } |
    ForEach-Object {
        $_.SerializedClassificationRuleCollection |
        Out-File "C:\SIT\$($_.Name).xml" -Encoding utf8
    }
```

---

## EDM Upload Automation Script

For scheduling regular EDM data refreshes (e.g., nightly cron job):

```powershell
<#
.SYNOPSIS
    Automates the EDM hash-and-upload cycle for scheduled data refresh.
.NOTES
    Schedule this via Windows Task Scheduler to run nightly.
    Credentials must be pre-authorized via: EdmUploadAgent.exe /Authorize
#>

param(
    [string]$DataFile    = "C:\EDMData\EmployeeData.csv",
    [string]$SchemaFile  = "C:\EDMData\ContosoEmployeeSchema.xml",
    [string]$HashDir     = "C:\EDMData\Hashed",
    [string]$StoreName   = "ContosoEmployeeSchema",
    [string]$AgentPath   = "C:\Program Files\Microsoft\EdmUploadAgent\EdmUploadAgent.exe",
    [string]$LogFile     = "C:\EDMData\Logs\edm_upload_$(Get-Date -Format 'yyyyMMdd').log"
)

function Write-Log([string]$msg) {
    $line = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')  $msg"
    Add-Content -Path $LogFile -Value $line
    Write-Host $line
}

New-Item -ItemType Directory -Force -Path (Split-Path $LogFile) | Out-Null
Write-Log "=== EDM Upload Job Started ==="
Write-Log "Data file : $DataFile"
Write-Log "Schema    : $StoreName"

# Hash the data
Write-Log "Hashing data..."
& $AgentPath /CreateHash `
    /DataStoreName $StoreName `
    /DataFile $DataFile `
    /HashLocation $HashDir `
    /Schema $SchemaFile `
    /AllowedBadLinesPercentage 5

if ($LASTEXITCODE -ne 0) {
    Write-Log "ERROR: Hashing failed with exit code $LASTEXITCODE"
    exit 1
}
Write-Log "Hashing complete."

# Upload hashed data
Write-Log "Uploading hashed data..."
& $AgentPath /UploadHash `
    /DataStoreName $StoreName `
    /HashLocation $HashDir

if ($LASTEXITCODE -ne 0) {
    Write-Log "ERROR: Upload failed with exit code $LASTEXITCODE"
    exit 1
}
Write-Log "Upload complete."

# Poll for indexing completion
Write-Log "Waiting for indexing..."
$maxWait = 60
$elapsed = 0
do {
    Start-Sleep -Seconds 60
    $elapsed++
    $status = & $AgentPath /GetSession /DataStoreName $StoreName
    Write-Log "Indexing status: $status"
} while ($status -notmatch "Processing Complete" -and $elapsed -lt $maxWait)

if ($elapsed -ge $maxWait) {
    Write-Log "WARNING: Indexing did not complete within $maxWait minutes."
} else {
    Write-Log "Indexing complete. EDM table is ready."
}

Write-Log "=== EDM Upload Job Finished ==="
```

---

## Validation Checklist

- [ ] Regex SIT `Contoso Employee ID` matches `EMP-NNNNN` pattern
- [ ] Regex SIT only matches at High confidence when keywords are present
- [ ] Keyword dictionary SIT matches exact project codenames
- [ ] EDM schema `ContosoEmployeeSchema` created with 6 fields
- [ ] EDM data hashed and uploaded via EdmUploadAgent
- [ ] EDM indexing status shows "Processing Complete"
- [ ] EDM SIT matches real records (e.g. `EMP-10042 + Holloway`)
- [ ] EDM SIT does **not** match fake IDs (e.g. `EMP-99999`)
- [ ] Custom SITs used as conditions in a DLP policy
- [ ] Custom SITs used as conditions in an auto-labeling policy

---

## Key Concepts

| Concept | Notes |
|---------|-------|
| **Primary element** | The main pattern/regex/keyword that must match |
| **Supporting element** | Optional nearby keyword or pattern that boosts confidence |
| **Confidence level** | High/Medium/Low — determined by how many elements match |
| **EDM schema** | Defines column names and which are searchable |
| **Searchable field** | EDM field that Purview scans document content for |
| **Corroborating field** | Secondary EDM field that boosts confidence when also found nearby |
| **Hash** | One-way transformation of data — Purview never stores your raw data |
| **EDM upload cycle** | Should be refreshed whenever the source data changes (daily/weekly) |

---

## Common Issues & Fixes

| Issue | Cause | Fix |
|-------|-------|-----|
| SIT returns 0 matches in tester | Regex syntax error | Test regex at regex101.com before entering in Purview |
| SIT matches too broadly | No supporting elements | Add keyword validators to the pattern |
| EDM upload fails at hash step | Wrong schema XML | Re-download schema using `/SaveSchema` command |
| EDM status stuck at "In Progress" | Large dataset / first upload | Wait up to 24 hours for initial indexing |
| EDM SIT matches nothing after upload | Primary field not marked Searchable | Edit schema — ensure primary field has Searchable = Yes |
| Keyword dictionary not detecting | Extra whitespace in keyword file | Clean the file — one term per line, no trailing spaces |

---

*Part of the [Microsoft Purview Hands-On Lab Series](../README.md)*
