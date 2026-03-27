# Lab 2 — Sensitivity Labels

## Objective
Create and publish **sensitivity labels** in Microsoft Purview so that users and services can classify and protect content consistently. Microsoft states that all Microsoft Purview Information Protection solutions are implemented by using sensitivity labels. citeturn2search97

## Why this lab matters
Microsoft explains that sensitivity labels let organizations classify and protect data while allowing collaboration to continue. Labels can provide settings such as **encryption** and **content markings**, and the publish step makes the labels available to users in supporting applications. citeturn2search100turn2search97

## Recommended learning assets
- **Create and configure sensitivity labels with Microsoft Purview** — Microsoft Learn module covering label creation, publishing, encryption, auto-labeling, and monitoring. citeturn2search98
- **Get started with sensitivity labels** — Microsoft guidance on label taxonomy and deployment strategy. citeturn2search99

## Prerequisites
- Access to **Solutions > Information Protection** in the Microsoft Purview portal. citeturn2search97
- Permission to create and manage sensitivity labels. Microsoft explicitly notes that permissions are required to create and manage labels. citeturn2search97
- A draft label taxonomy for your lab, such as **Public**, **General**, **Confidential**, and **Highly Confidential**. Microsoft’s getting-started guidance uses these as recommended examples for many organizations. citeturn2search99turn2search102

## Steps
1. Sign in to the Microsoft Purview portal and go to **Solutions > Information Protection > Sensitivity labels**. citeturn2search97
2. Select **+ Create a label**. citeturn2search97
3. On **Define the scope for this label**, choose the appropriate scope. Microsoft states that the selected scope determines both which settings are available and where the label will be visible after publishing. citeturn2search97
4. Configure the label properties. Microsoft’s guidance suggests choosing names and terms that are intuitive for users and aligned to the organization’s classification taxonomy. citeturn2search99
5. Configure any protection settings you want the label to enforce. Microsoft states that labels can provide protection settings including **encryption** and **content markings** such as headers, footers, and watermarks. citeturn2search100
6. Save the label. citeturn2search97
7. After creating your labels, create one or more **label policies** to publish them. Microsoft states that labels are created first and then made available by publishing them through a label policy. citeturn2search97turn2search99
8. Assign the label policy to the intended users or pilot group. Microsoft notes that a label policy determines who receives the labels and which policy settings apply. citeturn2search97turn2search99

## Validation
- Confirm that the new labels appear in the **Sensitivity labels** page in Purview. citeturn2search97
- Verify that the label policy is assigned to the intended users. Microsoft states that publishing makes the labels visible to the selected users in supported apps. citeturn2search97
- Document which settings were applied to each label, especially if you configured encryption or content markings, because Microsoft identifies those as core label capabilities. citeturn2search100

## Expected result
At the end of this lab, your tenant has a published sensitivity label taxonomy and a repeatable process for classifying and protecting content with Purview Information Protection. citeturn2search97turn2search99turn2search100

## Lessons learned
Label design works best when the names are intuitive and when publishing starts with a limited pilot audience. Microsoft’s deployment guidance explicitly supports piloting label policies before broader rollout. citeturn2search99
