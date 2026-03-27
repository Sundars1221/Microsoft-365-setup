# Lab 11 — Data Map

## Objective
Register and scan a data source in **Microsoft Purview Data Map** so that metadata can be captured and ingested into Purview. Microsoft states that the Data Map provides the foundation for data discovery and governance and that scanning captures metadata, extracts schema, and applies classifications. citeturn2search106turn2search103

## Why this lab matters
The market increasingly values Purview skills beyond classic Microsoft 365 compliance. Microsoft documents Data Map as the base for broader **data governance** across hybrid, on-premises, multicloud, and SaaS systems, and scanning is how metadata enters the governance plane. citeturn2search106turn2search103

## Recommended learning assets
- **Data Governance with Microsoft Purview Unified Catalog​** — internal learning object covering Data Map, Unified Catalog, lineage, and governance outcomes. citeturn2search89
- **Sample setup walkthrough of Microsoft Purview Unified Catalog and Data Map** — Microsoft walkthrough that shows governance domain setup, Data Map registration, data products, and data quality. citeturn2search104

## Prerequisites
- A Microsoft Purview account with access to **Data Map > Data sources**. citeturn2search105
- A supported data source to register and scan. Microsoft says you should review the supported-source documentation before scanning. citeturn2search105turn2search103
- An authentication method for scanning. Microsoft recommends **Managed Identity** whenever possible because it avoids storing secrets directly. citeturn2search103

## Steps
1. Register the data source in Microsoft Purview Data Map. Microsoft states registration gives Purview the address of the source and maps it to a collection or domain in Data Map. citeturn2search105
2. Go to **Data Map > Data sources** and locate the registered source. citeturn2search105
3. Select **New Scan**. citeturn2search105
4. Enter a **Name** for the scan and choose the **Credential** or authentication method. Microsoft lists several supported authentication types and recommends **Managed Identity** where possible. citeturn2search103turn2search105
5. Choose the collection or subcollection where the scan will store the discovered metadata. Microsoft states the scan is always in the same domain as the registered source but can use a subcollection. citeturn2search105
6. Select **Test connection** and continue if the connection succeeds. citeturn2search105
7. Scope the scan as needed. Microsoft says scans can target the entire source or only selected entities such as folders or tables. citeturn2search103turn2search105
8. Choose a **scan rule set** and run or schedule the scan. Microsoft states the rule set defines the classifications the scan checks for. citeturn2search105
9. Review the ingestion results after the scan. Microsoft explains that scanning brings metadata into Data Map and ingestion stores metadata in Unified Catalog from scans and lineage connections. citeturn2search103

## Validation
- Confirm the source is registered and visible in **Data Map > Data sources**. citeturn2search105
- Confirm at least one scan can be created and connected successfully. citeturn2search105
- Document whether the scan targeted the full source or a subset, because Microsoft explicitly supports both approaches. citeturn2search103turn2search105

## Expected result
At the end of this lab, you have a documented source registration and scan workflow and understand how metadata enters Microsoft Purview’s Data Map and governance model. citeturn2search103turn2search105turn2search106

## Lessons learned
Data Map is not only a connector catalog; it is the ingestion and metadata foundation for broader Purview governance experiences. Microsoft explicitly describes it as the basis for discovery and governance. citeturn2search106turn2search103
