# Lab 3 — Auto-labeling

## Objective
Configure and validate **auto-labeling** so that Microsoft Purview can classify and protect content based on detected signals rather than relying only on manual user action. Microsoft Learn explicitly includes **implement auto-labeling policies** as part of the sensitivity-label workflow. citeturn2search98

## Why this lab matters
Manual labeling is useful for user-driven classification, but Microsoft documents auto-labeling as a key capability for consistent, scalable classification and protection. Microsoft also positions sensitive information types as one of the supported ways to identify content that can then be classified or protected in downstream solutions. citeturn2search98turn2search114

## Recommended learning assets
- **Create and configure sensitivity labels with Microsoft Purview** — includes auto-labeling implementation and monitoring of label usage. citeturn2search98
- **Microsoft Purview: Manage and Protect Microsoft 365 Content** — covers sensitive information types, trainable classifiers, labels, and DLP together. citeturn2search69

## Prerequisites
- One or more sensitivity labels already created and published. Microsoft states that labels must be created before they can be published or reused in label policies. citeturn2search97turn2search99
- A sensitive information type or other supported detection signal to map to the label. Microsoft states that sensitive information types are used in sensitivity labels and auto-labeling policies. citeturn2search114
- Access to the Purview Information Protection experience. citeturn2search97

## Steps
1. Confirm the target sensitivity labels already exist and are published for the intended scope. citeturn2search97turn2search99
2. Identify the detection logic you will use for this lab, such as a custom **Sensitive Information Type (SIT)** created in Lab 1. Microsoft documents SITs as one of the mechanisms used in sensitivity labels and auto-labeling policies. citeturn2search114
3. In the sensitivity label workflow, configure **auto-labeling** for the label policy scenario. Microsoft Learn includes **Implement auto-labeling policies** as part of the label configuration module. citeturn2search98
4. Save and apply the policy configuration. citeturn2search98
5. Track and evaluate label usage by using the Purview data classification and monitoring views. Microsoft Learn explicitly includes **Track and evaluate sensitivity label usage in Microsoft Purview** in the same module. citeturn2search98

## Validation
- Confirm that the label configuration includes auto-labeling behavior and that the target label remains published to the relevant users or scope. citeturn2search97turn2search98
- Review the available label-usage tracking views in Purview after the policy is in place. Microsoft explicitly documents evaluation of label usage as part of the learning module. citeturn2search98

## Expected result
At the end of this lab, you have a documented auto-labeling scenario in which Purview can classify content automatically based on supported detection criteria, helping scale your protection model beyond manual labeling. citeturn2search98turn2search114

## Lessons learned
Auto-labeling is best introduced after label taxonomy and SIT design are stable. Microsoft’s learning path places auto-labeling after the fundamentals of label creation and protection configuration, which matches a practical implementation sequence. citeturn2search98turn2search99
