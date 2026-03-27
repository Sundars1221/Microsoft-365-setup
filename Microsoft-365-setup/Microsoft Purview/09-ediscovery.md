# Lab 8 — eDiscovery

## Objective
Create and manage an **eDiscovery case** in Microsoft Purview, then document the search-and-investigation workflow. Microsoft states that eDiscovery is used to identify, preserve, collect, review, analyze, and export electronically stored information (ESI) across Microsoft 365 services. citeturn2search136turn2search135

## Why this lab matters
Microsoft Purview eDiscovery supports internal investigations, legal matters, and regulatory review. Microsoft’s documentation organizes the workflow around case creation, data sources, search, refinement, and actions such as export or review sets. citeturn2search138turn2search133

## Recommended learning assets
- **Manage investigations with Microsoft Purview eDiscovery** learning path. citeturn2search137
- **Microsoft Purview: Records Management and eDiscovery in Microsoft 365** — useful companion course for retention + legal hold scenarios. citeturn2search73

## Prerequisites
- Appropriate eDiscovery permissions. Microsoft states that eDiscovery-related tools require the correct role assignments. citeturn2search136
- Required eDiscovery apps enabled and correctly configured. Microsoft says these are part of eDiscovery setup prerequisites. citeturn2search136
- A Microsoft 365 E3/E5 licensing context for admins and users working with eDiscovery cases, as documented by Microsoft. citeturn2search136

## Steps
1. Complete the setup prerequisites from **Get started with eDiscovery**, especially:
   - assigning permissions,
   - verifying required eDiscovery apps,
   - and reviewing any relevant settings. citeturn2search136
2. Open the **Cases dashboard** in Microsoft Purview eDiscovery. Microsoft states that this dashboard shows all cases in the organization and lets you create and manage them. citeturn2search133
3. Create a new case. Microsoft documents **Create a case** as a core function of the eDiscovery case workflow. citeturn2search133
4. Add the relevant data sources to the case. Microsoft explicitly lists **Add data sources to a case** as part of case management. citeturn2search133
5. Run a search within the case and refine it based on results. Microsoft’s eDiscovery workflow describes the next stage as **Search, evaluate results, and refine**. citeturn2search138
6. From the results, document one or both of the next-stage actions:
   - **Export search results**
   - **Create review sets** citeturn2search138
7. If desired, review the full learning path which also covers holds, review sets, and investigation preparation. citeturn2search137

## Validation
- Confirm the case appears on the **Cases dashboard** and is accessible with the expected status and details. citeturn2search133
- Confirm you can attach data sources to the case and perform at least one search. citeturn2search133turn2search138
- Document whether you used **export** or **review sets** as the next action from the search results. citeturn2search138

## Expected result
At the end of this lab, you have a complete baseline eDiscovery workflow documented for your test tenant: prerequisites, case creation, data sources, search, refinement, and next-step handling of results. citeturn2search136turn2search133turn2search138

## Lessons learned
eDiscovery in Purview is case-centric, not just search-centric. Microsoft’s workflow consistently frames the investigation around a managed case workspace that contains holds, searches, review sets, and export activities. citeturn2search137turn2search138
