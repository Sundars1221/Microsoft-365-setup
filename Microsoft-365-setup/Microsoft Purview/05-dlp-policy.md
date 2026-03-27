# Lab 4 — Data Loss Prevention (DLP) Policy

## Objective
Design, simulate, and deploy a **Microsoft Purview Data Loss Prevention (DLP)** policy. Microsoft states that DLP policies are the mechanism used to identify, monitor, and automatically protect sensitive data across enterprise applications, devices, and inline web traffic scenarios. citeturn2search127turn2search130

## Why this lab matters
DLP is one of the most operationally important Purview skill sets. Microsoft’s DLP guidance stresses that an effective policy begins with a **policy intent statement** and is deployed gradually by using **simulation mode**, **policy tips**, and finally **full enforcement** to avoid disruption. citeturn2search129turn2search127

## Recommended learning assets
- **Implement and manage Microsoft Purview Data Loss Prevention** — official learning path aligned to SC-401. citeturn2search132turn2search93
- **Create and manage data loss prevention policies** — Microsoft Learn module on policy design and deployment. citeturn2search131

## Prerequisites
- Permission to create and deploy DLP policies. Microsoft lists role groups such as **Compliance administrator**, **Compliance data administrator**, **Information Protection**, **Information Protection Admin**, and **Security administrator**. citeturn2search127
- Defined data categories or sensitive information types you want to protect. Microsoft’s DLP planning guidance says planning begins by identifying the categories of sensitive information to protect and setting goals and strategy. citeturn2search127turn2search129
- A documented business goal for the policy, even if simple. Microsoft says every DLP policy should be tied to a clear business intent statement. citeturn2search129

## Steps
1. Document the **policy intent statement**. Microsoft says that policy design starts by clearly defining the business need and writing a statement that explains the purpose of the policy. citeturn2search129
2. Determine the core design elements Microsoft says every DLP policy requires:
   - what you want to monitor,
   - the policy scoping,
   - where you want to monitor, and
   - the conditions that must be matched for the policy to apply. citeturn2search129
3. Create the DLP policy in Microsoft Purview for the appropriate location set. Microsoft documents DLP for **Enterprise applications & devices** and **Inline web traffic** scenarios. citeturn2search127turn2search130
4. Set the initial policy state to **Keep it off** while the design is being reviewed. Microsoft explicitly recommends this state while developing and reviewing the policy. citeturn2search127
5. Change the state to **Run the policy in simulation mode**. Microsoft states that in this mode no actions are enforced and events are audited so you can monitor policy behavior safely. citeturn2search127
6. Review the simulation behavior and tune the policy if needed. Microsoft says the purpose of simulation is to gather behavior data and adjust the policy before tighter enforcement. citeturn2search127
7. Move to **Run the policy in simulation mode and show policy tips** for your pilot group. Microsoft says this mode still avoids enforcement but raises awareness for users through policy tips and notifications. citeturn2search127
8. After successful pilot validation, move the policy to **Turn it on right away** for enforcement. Microsoft documents this as full enforcement mode. citeturn2search127
9. If appropriate for your scenario, document which policy action level you used, such as **Audit only**, **Block with override**, or **Block**. Microsoft explicitly describes these actions and their effect on user activity. citeturn2search127

## Validation
- Confirm the policy exists in Purview and that its state matches the phase you selected. citeturn2search127
- If you use simulation, confirm that the policy is generating activity for review without enforcing actions. citeturn2search127
- Document the chosen scope, action level, and rollout phase for the policy. Microsoft’s deployment guidance treats scope, state, and actions as the three main axes of deployment management. citeturn2search127

## Expected result
At the end of this lab, you have a DLP policy that is documented, aligned to a defined business intent, and deployed using Microsoft’s recommended staged rollout model. citeturn2search127turn2search129

## Lessons learned
Simulation-first rollout is the safest way to implement DLP. Microsoft is explicit that rushing straight to enforcement can negatively affect business processes and user acceptance, while simulation gives you time to tune the policy. citeturn2search127
