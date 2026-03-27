# Lab 12 — Unified Catalog

## Objective
Set up core governance constructs in **Microsoft Purview Unified Catalog**, including **governance domains**, **data products**, and **data quality connections**. Microsoft states that Unified Catalog is the central platform for federated data governance and is designed to drive business value creation in the era of AI. citeturn2search108turn2search104

## Why this lab matters
Modern Purview governance is increasingly centered on Unified Catalog rather than only classic compliance tooling. Your organization already surfaces internal learning on this topic through **Data Governance with Microsoft Purview Unified Catalog​** and the **Unified Catalog Workshop**, both of which explicitly cover environment setup, Unified Catalog implementation, data products, business glossary management, lineage validation, and governance policy enforcement. citeturn2search89turn2search78turn2search90

## Recommended learning assets
- **Data Governance with Microsoft Purview Unified Catalog​**. citeturn2search89
- **Data Governance with Microsoft Purview​ Unified Catalog Workshop**. citeturn2search78turn2search90
- **Sample setup walkthrough of Microsoft Purview Unified Catalog and Data Map**. citeturn2search104

## Prerequisites
- Access to **Unified Catalog** in the Microsoft Purview portal. Microsoft states the new Unified Catalog experience provides a single integrated SaaS framework for data governance. citeturn2search108
- Appropriate **Data Governance** role assignments. Microsoft’s sample walkthrough states that setup requires the **Data Governance administrator** role for Unified Catalog. citeturn2search104
- A scanned or registered data source from Lab 11 so you have assets that can later be connected to governance structures. Microsoft’s sample setup walks through governance domains first, then Data Map registration, then data products. citeturn2search104

## Steps
1. In Unified Catalog, go to **Catalog management > Governance domains**. Microsoft documents this as the place to create governance domains. citeturn2search104
2. Create a **New governance domain**. Microsoft states governance domains establish accountability and federate governance ownership across the organization. citeturn2search104
3. Ensure your data has been registered and scanned into **Data Map**, because Microsoft’s setup walkthrough lists that as the next stage after governance domain creation. citeturn2search104
4. Publish or define **data products** in Unified Catalog. Microsoft explicitly lists **Publish your data products** as one of the main setup steps in the walkthrough. citeturn2search104
5. Configure a **data quality connection** by going to **Health management > Data quality**, selecting a governance domain, and using **Manage > Connections > New**. Microsoft documents this workflow for setting up data source connections used by data quality features. citeturn2search107
6. Enter the connection information, test the connection, and submit it. Microsoft states these connections are used to profile data and run data quality scans. citeturn2search107

## Validation
- Confirm the governance domain exists in Unified Catalog. citeturn2search104
- Confirm that the data quality connection can be created and tested successfully. citeturn2search107
- Document whether the lab included data products and how they were associated with the governance domain. Microsoft’s sample setup explicitly includes this step. citeturn2search104

## Expected result
At the end of this lab, you have a governance-centered Purview scenario documented: governance domain creation, linked data assets, data products, and a data quality connection path. citeturn2search104turn2search107turn2search108

## Lessons learned
Unified Catalog reflects Microsoft’s broader message that governance is no longer only about control; it is also about discoverability, ownership, and business value in AI-era data estates. citeturn2search108turn2search104
