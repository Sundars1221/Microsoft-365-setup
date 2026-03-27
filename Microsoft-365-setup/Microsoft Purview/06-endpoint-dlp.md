# Lab 5 — Endpoint DLP and DLP Investigation

## Objective
Extend DLP understanding to endpoint scenarios and document the investigation lifecycle for DLP alerts in Microsoft Purview. Microsoft’s official DLP learning path explicitly includes **Implement endpoint data loss prevention (DLP)** and **Investigate and respond to Microsoft Purview Data Loss Prevention alerts**. citeturn2search132

## Why this lab matters
Microsoft positions DLP as protection across both cloud workloads and endpoints. The DLP learning path shows that administrators are expected not only to create policies but also to investigate alerts and adapt policies over time. citeturn2search132turn2search127

## Recommended learning assets
- **Implement and manage Microsoft Purview Data Loss Prevention** learning path. citeturn2search132turn2search88
- **Microsoft 365 Administration: Managing Compliance Using Microsoft Purview** — course that covers DLP for workloads and endpoints, plus DLP alerts and reports. citeturn2search72

## Prerequisites
- A DLP policy foundation already documented in Lab 4. Microsoft structures the learning path so DLP planning and policy creation come before investigation and endpoint controls. citeturn2search132
- Access to the Purview DLP experience and the permissions needed to investigate DLP alerts. Microsoft describes investigation as part of the DLP admin workflow. citeturn2search127turn2search132

## Steps
1. Review the **Implement and manage Microsoft Purview Data Loss Prevention** learning path to understand how Microsoft organizes DLP operations. The path explicitly contains these modules:
   - **Understand and plan data loss prevention**
   - **Create and manage data loss prevention policies**
   - **Implement endpoint data loss prevention (DLP) with Microsoft Purview**
   - **Investigate and respond to Microsoft Purview Data Loss Prevention alerts** citeturn2search132
2. Use your existing DLP policy documentation from Lab 4 as the starting control set. citeturn2search127
3. Study the endpoint portion of the DLP learning path. Microsoft says endpoint DLP helps organizations protect sensitive data on endpoint devices by monitoring, restricting, or allowing actions such as file transfers, copying, and sharing. citeturn2search132
4. Study the alert investigation portion of the learning path. Microsoft states that Purview DLP and Microsoft Defender XDR help organizations detect potential data loss risks and respond quickly by reviewing alerts, applying remediation actions, and documenting findings. citeturn2search132
5. In your documentation, record how the endpoint DLP scenario differs from your tenant-wide DLP policy scenario, and record how alert investigation fits into your operating model. *(The comparison itself is your documentation step; the cited source supports that both scenarios exist in the learning path.)* citeturn2search132

## Validation
- Confirm that your DLP documentation now covers both **endpoint DLP** and **alert investigation**, not only policy creation. citeturn2search132
- Confirm that you can describe where to look for policy behavior and alert handling within the Purview DLP lifecycle. Microsoft explicitly positions alert investigation as part of the DLP management flow. citeturn2search127turn2search132

## Expected result
At the end of this lab, your documentation covers the broader DLP operational picture: policy planning, policy deployment, endpoint protection, and investigation/response. citeturn2search132turn2search127

## Lessons learned
Microsoft’s DLP learning path makes it clear that DLP is not complete at policy creation. Investigation and endpoint coverage are integral parts of the skill set. citeturn2search132
