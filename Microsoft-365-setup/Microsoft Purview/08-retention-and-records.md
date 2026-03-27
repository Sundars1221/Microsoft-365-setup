# Lab 7 — Retention and Records Management

## Objective
Create and publish **retention labels** and document how Microsoft Purview supports **records management** and **disposition**. Microsoft states that retention labels help organizations retain what they need and delete what they do not at the item level, and that records management uses retention labels to declare items as records. citeturn2search122turn2search125turn2search124

## Why this lab matters
Retention and records management are central to compliance operations. Microsoft’s learning path **Implement retention, eDiscovery, and Communication compliance in Microsoft Purview** includes hands-on exercises for **static and adaptive retention policies**, **retention labels**, and **records/disposition** scenarios. citeturn2search123turn2search126

## Recommended learning assets
- **Implement retention, eDiscovery, and Communication compliance in Microsoft Purview** learning path. citeturn2search123
- **Microsoft Purview: Records Management and eDiscovery in Microsoft 365** — covers retention policies, file plans, retention labels, disposition, and eDiscovery. citeturn2search73

## Prerequisites
- Access to either **Records Management** or **Data Lifecycle Management** in the Microsoft Purview portal. Microsoft states retention label policies can be created from either solution. citeturn2search122
- Permissions to create and publish retention labels and policies. Microsoft explicitly notes that permissions are required. citeturn2search122
- A defined retention scenario, such as document retention or record declaration. *(Suggested by this repository for lab clarity; not explicitly required by the cited page.)*

## Steps
1. Create the retention labels you want to use in your scenario. Microsoft says retention labels are the first step before publishing them. citeturn2search122
2. Publish the retention labels by creating a **retention label policy**. Microsoft documents the navigation as:
   - **Solutions > Records Management > Policies > Label policies**, or
   - **Solutions > Data Lifecycle Management > Policies > Label policies**. citeturn2search122
3. Select **Publish labels** and follow the prompts. Microsoft states you select the labels to publish and choose whether the policy will be **adaptive** or **static**. citeturn2search122
4. If your scenario requires record declaration, create a retention label that marks the item as a **record**. Microsoft states retention labels can mark content as a record or a regulatory record. citeturn2search121turn2search125
5. If you need the **regulatory record** option, connect to Office 365 Security & Compliance PowerShell and run **Set-RegulatoryComplianceUI -Enabled $true**. Microsoft documents this as the way to expose the regulatory record option in the label wizard. citeturn2search121
6. Apply or publish the retention labels to the target content and document the behavior you observe. Microsoft states published labels can then be applied to documents and emails. citeturn2search122turn2search121
7. If you want broader coverage in your notes, review the official learning module that includes retention policies, adaptive scopes, event-based retention, and disposition review. citeturn2search126turn2search123

## Validation
- Confirm the retention label policy exists and includes the intended labels. citeturn2search122
- Confirm whether the label was configured as a standard retention label, a record label, or a regulatory record label. citeturn2search121turn2search125
- Document whether your scenario used **adaptive** or **static** policy scoping. Microsoft explicitly presents both options in the retention label policy workflow. citeturn2search122

## Expected result
At the end of this lab, your tenant has a documented retention-label scenario and a records-management workflow that you can reuse for future compliance labs. citeturn2search122turn2search125turn2search126

## Lessons learned
Retention labels are more flexible than a simple “keep or delete” control. Microsoft’s documentation shows they also support record declaration, adaptive scoping, event-based retention, and disposition processes. citeturn2search123turn2search125turn2search126
