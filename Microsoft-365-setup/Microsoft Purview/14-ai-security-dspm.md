# Lab 13 — AI Security / DSPM for AI

## Objective
Document how Microsoft Purview can manage data security and compliance for **Microsoft 365 Copilot** and other AI interactions by using **Data Security Posture Management (DSPM) for AI** and related Purview controls. Microsoft states that Purview can mitigate and manage the risks associated with AI usage and apply corresponding protection and governance controls. citeturn2search117turn2search118

## Why this lab matters
AI governance is one of the newest and fastest-growing Purview skill areas. Your organization already surfaces the learning path **Secure AI interactions and environments with Microsoft Purview**, which explicitly focuses on protecting sensitive information in AI-enabled environments across Microsoft 365 Copilot, non-Microsoft AI apps, and developer AI scenarios. citeturn2search95

## Recommended learning assets
- **Secure AI interactions and environments with Microsoft Purview**. citeturn2search95
- **Microsoft Purview data security and compliance protections for Microsoft 365 Copilot and other generative AI apps**. citeturn2search117
- **Use Microsoft Purview to manage data security & compliance for Microsoft 365 Copilot & Microsoft 365 Copilot Chat**. citeturn2search118

## Prerequisites
- Access to Microsoft Purview AI-related compliance and security experiences. Microsoft documents these under the Purview portal and DSPM for AI experiences. citeturn2search117turn2search116
- For some AI integrations, Microsoft documents additional prerequisites such as pay-as-you-go billing or tenant settings. For example, Microsoft notes that managing some AI interactions requires **pay-as-you-go billing**, and for Security Copilot it requires the option to allow Purview to access and process customer data from the service. citeturn2search115turn2search119
- Awareness that support coverage differs by AI app. Microsoft documents capability matrices per app. citeturn2search117turn2search118turn2search119

## Steps
1. Review the Purview AI security overview and identify the AI app category relevant to your tenant scenario. Microsoft groups support into **Copilot experiences and agents**, **Enterprise AI apps**, and **Other AI apps**. citeturn2search117
2. Use **DSPM for AI** as the primary entry point. Microsoft explicitly says to use DSPM for AI (classic) or the newer DSPM experience as the “front door” to discover, secure, and apply compliance controls for AI usage. citeturn2search118turn2search116turn2search115
3. Review the supported capabilities for **Microsoft 365 Copilot & Microsoft 365 Copilot Chat**. Microsoft states that these AI interactions are supported by:
   - DSPM for AI,
   - Auditing,
   - Data classification,
   - Sensitivity labels,
   - Encryption without sensitivity labels,
   - Data loss prevention,
   - Insider Risk Management,
   - Communication compliance,
   - eDiscovery,
   - Data Lifecycle Management,
   - Compliance Manager. citeturn2search118
4. Review the DSPM recommendations and one-click policy options available for your chosen AI scenario. Microsoft documents that DSPM provides recommendations and one-click actions such as securing Copilot interactions, detecting risky AI usage, and addressing oversharing risks. citeturn2search118turn2search116turn2search115
5. If your scenario includes **Microsoft Security Copilot**, document the service-specific prerequisites. Microsoft states that Security Copilot requires the option **Allow Microsoft Purview to access, process, copy, and store Customer Data** and that managing these AI interactions requires **pay-as-you-go billing**. citeturn2search115
6. If your scenario includes **Copilot in Fabric**, document the tenant prerequisite. Microsoft states that **Allow Microsoft Purview to secure AI interactions** in the Microsoft Fabric admin portal must be enabled and that managing these interactions also requires pay-as-you-go billing. citeturn2search119

## Validation
- Confirm which Purview capabilities are supported for the specific AI app scenario being documented. Microsoft publishes separate capability tables for supported apps. citeturn2search117turn2search118turn2search119
- Confirm whether any special prerequisites such as billing or service options were required by the scenario. citeturn2search115turn2search119
- Document the DSPM recommendations or views used in the lab so the workflow is repeatable. Microsoft states that DSPM provides graphical tools, reports, recommendations, and one-click policy actions. citeturn2search118turn2search116

## Expected result
At the end of this lab, you have a documented AI governance scenario for Microsoft Purview that explains how DSPM for AI and related Purview controls can be used to manage AI interaction risks. citeturn2search117turn2search118turn2search116

## Lessons learned
Microsoft treats AI governance as an extension of existing Purview controls rather than a separate product silo. DSPM for AI is documented as the centralized experience that brings together audit, labels, DLP, eDiscovery, lifecycle, and compliance controls for AI-enabled workflows. citeturn2search118turn2search117turn2search115
