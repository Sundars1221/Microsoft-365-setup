# Lab 07 — Data Map, Catalog & Lineage

**Duration:** 90 minutes | **Level:** Advanced | **Skill Area:** Data Governance

---

## Objectives

- Create a Microsoft Purview governance account in Azure
- Register and scan data sources (Azure Blob, SQL, SharePoint)
- Explore auto-classified assets in the Data Catalog
- Build a business glossary and link terms to assets
- View data lineage across pipeline stages

## Learning Outcomes

| Outcome | Validated By |
|---------|-------------|
| Register data sources | Sources visible in Data Map |
| Build business glossary | Terms linked to catalog assets |
| Explore data lineage | Lineage graph shows source-to-destination flow |

---

## Prerequisites

- [ ] An **Azure subscription** (free tier is sufficient)
- [ ] **Contributor** role on an Azure resource group
- [ ] At least one of: Azure Blob Storage, Azure SQL Database, SharePoint site
- [ ] Microsoft Purview governance account created (see Setup step)

> **Alternative:** Use the Purview Demo Environment at **https://aka.ms/PurviewDemo** if you don't have an Azure subscription. The demo is pre-populated with sample data sources and catalog assets.

---

## Setup — Create a Microsoft Purview Account

### Step 1 — Create in Azure Portal
1. Go to **https://portal.azure.com**
2. Click **Create a resource → Search: "Microsoft Purview"**
3. Click **Create**
4. Settings:
   - Subscription: your Azure subscription
   - Resource group: create new `rg-purview-lab`
   - Account name: `purview-lab-[yourname]` (must be globally unique)
   - Location: your nearest region
5. Click **Review + Create → Create**
6. Deployment takes ~3–5 minutes

### Step 2 — Open the governance portal
1. Go to the created Purview resource in Azure Portal
2. Click **Open Microsoft Purview Governance Portal**
3. Or navigate directly to: `https://web.purview.azure.com`

---

## Section A — Register & Scan Data Sources

### Step 1 — Register Azure Blob Storage
1. In the governance portal, go to **Data Map → Sources**
2. Click **Register**
3. Select: **Azure Blob Storage**
4. Settings:
   - Subscription: your Azure subscription
   - Storage account: select your test storage account
5. Click **Register**

### Step 2 — Create and run a scan (Blob)
1. Select the registered Blob source
2. Click **New scan**
3. Name: `Lab-BlobScan`
4. Credential: use **Managed Identity** (recommended)
5. Scan ruleset: **System Default**
6. Schedule: **Weekly** (recurring)
7. Click **Save and run**
8. Wait 5–15 minutes for scan to complete

### Step 3 — Register Azure SQL Database
1. In Azure Portal, create a simple SQL database if needed:
   - Server: create new, note the server name
   - Database name: `lab-db`
   - Sample data: **AdventureWorksLT** (pre-populated test data)
2. Back in Purview → **Sources → Register → Azure SQL Database**
3. Configure: subscription, server name, database name
4. Create scan: `Lab-SQLScan`
5. Authentication: SQL authentication or Managed Identity
6. Run the scan

### Step 4 — Register Microsoft 365 (SharePoint)
1. **Sources → Register → Microsoft 365**
2. This scans SharePoint sites for file classification
3. Run a scan on a SharePoint site containing labeled documents from Lab 01

### Step 5 — View the Data Map
1. Go to **Data Map → Map view**
2. Explore the visual representation of all sources
3. Click on connections between sources to see relationships

---

## Section B — Explore Data Catalog

### Step 1 — Search the catalog
1. Go to **Data Catalog → Browse**
2. Search for a filename or table name from your scanned sources
3. Open an asset to see its full details

### Step 2 — Review asset details
For a **database table** (e.g., from AdventureWorksLT):

| Tab | What You'll See |
|-----|----------------|
| **Overview** | Table name, source, description |
| **Schema** | Columns, data types, detected classifications |
| **Classifications** | Auto-detected: email addresses, credit cards, SSNs |
| **Contacts** | Owners and experts you can assign |
| **Lineage** | Upstream/downstream data flows |
| **Related** | Related assets and glossary terms |

### Step 3 — Review auto-classifications
Auto-classification runs during the scan. Check if Purview detected:
- **MICROSOFT.PERSONAL.EMAIL** — email address columns
- **MICROSOFT.FINANCIAL.CREDIT_CARD_NUMBER** — card number fields
- **MICROSOFT.GOVERNMENT.US.SOCIAL_SECURITY_NUMBER** — SSN fields

### Step 4 — Manually classify a column
1. Find a database column (e.g., `EmailAddress`)
2. Click **Edit** on the asset
3. Under Schema, find the column
4. Click the classification cell → **Add classification**
5. Choose: **MICROSOFT.PERSONAL.EMAIL**
6. Click **Save**

### Step 5 — Assign an asset owner
1. In the asset, go to **Contacts** tab
2. Click **Edit**
3. Add **Owner:** your admin account
4. Add **Expert:** a subject matter expert account
5. Click **Save**

---

## Section C — Business Glossary

Navigate to **Data Catalog → Glossary**

### Step 1 — Create a glossary term
1. Click **New term**
2. Template: **System default**
3. Name: `Financial Statement`
4. Definition: `Official quarterly or annual financial report documenting revenue, expenses, and net income.`
5. Acronym: `FS`
6. Resources: add a link to your finance policy document
7. Click **Save**

### Step 2 — Create additional terms
Repeat for:

| Term | Definition |
|------|-----------|
| `PII` | Personally Identifiable Information — any data that can identify an individual |
| `Data Custodian` | Person responsible for the technical management of a data asset |
| `Data Owner` | Business owner accountable for a data domain |
| `Retention Period` | Duration for which a data asset must be preserved per policy |

### Step 3 — Create a glossary term hierarchy
1. Open the `PII` term
2. Click **Edit**
3. Under **Related terms**, link: `Financial Statement` as a related term
4. Create a **parent term**: `Regulated Data` and make `PII` a child term

### Step 4 — Link glossary terms to catalog assets
1. Find a database column or file asset in the catalog
2. Open it → **Edit**
3. Under **Glossary terms**, click **Add**
4. Select: `Financial Statement`
5. Click **Save**

### Step 5 — Browse by glossary term
1. Go to **Data Catalog → Browse by glossary term**
2. Select `PII`
3. See all assets tagged with this term — shows the business context of your data

---

## Section D — Data Lineage

### Step 1 — View lineage on a catalog asset
1. Open any scanned asset
2. Click the **Lineage** tab
3. If lineage data is available (from ADF, Synapse, or other connectors), you'll see the flow graph

### Step 2 — Create manual lineage
If automatic lineage isn't available:
1. Open an asset → **Lineage** tab → **Edit**
2. Click **+ Add lineage**
3. Link two assets:
   - Upstream source: `lab-db.SalesData`
   - Downstream: a SharePoint Excel file
4. Save the relationship

### Step 3 — Explore lineage graph features
In the lineage view:
- Click **Switch to lineage view** for full graph
- Hover over nodes to see asset details
- Click a node to navigate to that asset
- Use **Column-level lineage** (if ADF connector) to trace individual column transformations

---

## Validation Checklist

- [ ] Purview governance account created in Azure
- [ ] At least 2 data sources registered and scanned
- [ ] Assets appear in the Data Catalog
- [ ] Auto-classifications visible on database columns
- [ ] Business glossary has 3+ terms
- [ ] Glossary terms linked to catalog assets
- [ ] Collection hierarchy created in Data Map

---

## Key Concepts

| Concept | Notes |
|---------|-------|
| **Data Map** | Live, automated map of your data estate across clouds |
| **Scan** | Process that discovers and classifies assets in a source |
| **Classification** | Auto-detected sensitive data patterns in asset content |
| **Glossary** | Business-defined vocabulary linked to technical data assets |
| **Lineage** | End-to-end data flow from source through transformations to destination |
| **Collection** | Logical grouping for access control on the data map |

---

## Multi-Cloud Support

Microsoft Purview Data Map can scan sources beyond Azure:

| Platform | Supported Sources |
|----------|------------------|
| Azure | Blob, ADLS, SQL, Synapse, Cosmos DB, ADF |
| AWS | S3, RDS |
| Google Cloud | GCS, BigQuery |
| On-premises | SQL Server, SAP, Teradata, Oracle |
| SaaS | Salesforce, Power BI, Microsoft 365 |

---

## Next Lab

➡ [Lab 08 — Compliance Manager & Score Improvement](../lab-08-compliance-manager/README.md)
