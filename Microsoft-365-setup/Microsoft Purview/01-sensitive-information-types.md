# Lab 1 — Sensitive Information Types (SITs)

## Objective
Create and validate a custom **Sensitive Information Type (SIT)** in Microsoft Purview. Microsoft Learn states that sensitive information types are used in **DLP policies**, **sensitivity labels**, **retention labels**, **Insider Risk Management**, **communication compliance**, **auto-labeling policies**, and **Microsoft Priva**. citeturn2search114

## Why this lab matters
Sensitive information types are one of the foundational building blocks in Microsoft Purview. Microsoft says identifying and classifying sensitive items is the first step in the information protection discipline, and SITs are pattern-based classifiers that can detect structured data such as account numbers and other types of sensitive content. citeturn2search114

## Steps
1. Sign in to the **Microsoft Purview portal**. 
2. Navigate to **Information Protection > Classifiers > Sensitive info types**. 

3. Choose **Create sensitive info type**.
4. Enter a **Name** and **Description**, then choose **Next**.
5. Choose **Create pattern**. Microsoft says you can create multiple patterns, each with different elements and confidence levels.
6. Select the pattern confidence level: **Low**, **Medium**, or **High**.
7. Define the **Primary element**. Microsoft states the primary element can be a **Regular expression** (with optional validator), **Keyword list**, **Keyword dictionary**, or one of the preconfigured **Functions**.
8. Save the SIT when the pattern is complete.
9. If you need to adjust the SIT afterward, return to **Information Protection > Classifiers > Sensitive info types**, select the SIT, and choose **Edit**. Microsoft says you can modify custom SITs by adding or editing patterns and supporting elements.

## Validation
- Confirm that the custom SIT appears in the **Sensitive info types** list. Microsoft documents that custom SITs can be modified and removed from this list. citeturn2search111
- Document which primary element and confidence settings you used for the SIT, because Microsoft explicitly identifies these as the core parts of the custom SIT definition. citeturn2search109

## Expected result
At the end of this lab, you have a reusable custom sensitive information type that can later be referenced by DLP, labels, retention labels, and other Purview controls. Microsoft explicitly lists SITs as inputs for those solutions. citeturn2search114

## Suggested extension
If you need deeper control than the portal offers, Microsoft also documents a PowerShell/XML approach for creating a custom SIT rule package. That path is more advanced and is best used when you need fine-grained pattern control. citeturn2search110

## Lessons learned
Custom SITs are the right place to encode organization-specific patterns before you move into auto-labeling or DLP. Microsoft’s documentation makes SITs the classification base for multiple downstream Purview controls. citeturn2search114turn2search113
