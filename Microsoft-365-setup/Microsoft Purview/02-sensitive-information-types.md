# Lab 1 — Sensitive Information Types (SITs)

## Objective
Create and validate a custom **Sensitive Information Type (SIT)** in Microsoft Purview. Microsoft Learn states that sensitive information types are used in **DLP policies**, **sensitivity labels**, **retention labels**, **Insider Risk Management**, **communication compliance**, **auto-labeling policies**, and **Microsoft Priva**. citeturn2search114

## Why this lab matters
Sensitive information types are one of the foundational building blocks in Microsoft Purview. Microsoft says identifying and classifying sensitive items is the first step in the information protection discipline, and SITs are pattern-based classifiers that can detect structured data such as account numbers and other types of sensitive content. citeturn2search114

## Recommended learning assets
- **Create and manage sensitive information types** — Microsoft Learn module covering built-in and custom SITs. citeturn2search113
- **Microsoft Purview: Manage and Protect Microsoft 365 Content** — course covering sensitive information types, trainable classifiers, labels, and DLP. citeturn2search69

## Prerequisites
- Access to the Microsoft Purview portal. citeturn2search109
- Appropriate Purview permissions for Information Protection administration. Microsoft documents that Purview features are governed by role-based access. citeturn2search127turn2search153
- A test file or sample content you can use to validate the pattern. *(Suggested by this repository for learning; not explicitly required by the cited Microsoft page.)*

## Steps
1. Sign in to the **Microsoft Purview portal**. citeturn2search109
2. Navigate to **Information Protection > Classifiers > Sensitive info types**. Microsoft documents this exact path for custom SIT creation and management. citeturn2search109turn2search111
3. Choose **Create sensitive info type**. citeturn2search109
4. Enter a **Name** and **Description**, then choose **Next**. citeturn2search109
5. Choose **Create pattern**. Microsoft says you can create multiple patterns, each with different elements and confidence levels. citeturn2search109
6. Select the pattern confidence level: **Low**, **Medium**, or **High**. citeturn2search109
7. Define the **Primary element**. Microsoft states the primary element can be a **Regular expression** (with optional validator), **Keyword list**, **Keyword dictionary**, or one of the preconfigured **Functions**. citeturn2search109
8. Save the SIT when the pattern is complete. citeturn2search109
9. If you need to adjust the SIT afterward, return to **Information Protection > Classifiers > Sensitive info types**, select the SIT, and choose **Edit**. Microsoft says you can modify custom SITs by adding or editing patterns and supporting elements. citeturn2search111

## Validation
- Confirm that the custom SIT appears in the **Sensitive info types** list. Microsoft documents that custom SITs can be modified and removed from this list. citeturn2search111
- Document which primary element and confidence settings you used for the SIT, because Microsoft explicitly identifies these as the core parts of the custom SIT definition. citeturn2search109

## Expected result
At the end of this lab, you have a reusable custom sensitive information type that can later be referenced by DLP, labels, retention labels, and other Purview controls. Microsoft explicitly lists SITs as inputs for those solutions. citeturn2search114

## Suggested extension
If you need deeper control than the portal offers, Microsoft also documents a PowerShell/XML approach for creating a custom SIT rule package. That path is more advanced and is best used when you need fine-grained pattern control. citeturn2search110

## Lessons learned
Custom SITs are the right place to encode organization-specific patterns before you move into auto-labeling or DLP. Microsoft’s documentation makes SITs the classification base for multiple downstream Purview controls. citeturn2search114turn2search113
