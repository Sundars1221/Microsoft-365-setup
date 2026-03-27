# Lab 0 — Tenant Readiness

## Objective
Prepare your test tenant for Microsoft Purview hands-on work by confirming portal access, role readiness, and the most relevant Microsoft learning path for this journey: **SC-401**. Your organization also surfaces internal certification guidance in **Microsoft-Security-Certifications.aspx**, which explicitly references **Information Security Administrator Associate [SC-401]**. citeturn2search153turn2search96

## Why this lab matters
Microsoft Learn positions the Microsoft Purview portal as the entry point for compliance, governance, and protection workflows, while GitHub-style documentation is easiest to maintain when your initial setup is captured clearly and once. Before you start building labels, DLP, or eDiscovery scenarios, confirm the tenant can access the required Purview solutions and that your admin account is using the correct role assignments. citeturn2search67turn2search153

## Recommended learning assets
- **Microsoft Purview: Introduction and Getting Started** — good orientation to what Purview is, how to access the components, and how the platform is organized. citeturn2search67
- **Microsoft-Security-Certifications.aspx** — internal guidance that lists **SC-401** as the Information Security Administrator certification relevant to Microsoft cloud security and data protection. citeturn2search96

## Prerequisites
- A Microsoft 365 test tenant with administrator access. *(Suggested by this repository for safe learning; not a Microsoft-cited prerequisite.)*
- Access to the **Microsoft Purview portal**. Microsoft states that Compliance Manager and other Purview solutions are accessed from the Microsoft Purview portal. citeturn2search153turn2search152
- A user account with appropriate Purview roles. Microsoft states that features like DLP, Audit, eDiscovery, and Compliance Manager require role-based access. citeturn2search127turn2search145turn2search136turn2search153

## Steps
1. Sign in to the **Microsoft Purview portal** with your admin account. Microsoft documents this as the starting point for Compliance Manager setup and general Purview administration. citeturn2search153turn2search152
2. Review the roles your account has for Purview. Microsoft states that role-based access control is used for solutions such as Compliance Manager and that only assigned users can access the solution and perform actions. citeturn2search153
3. Confirm the role requirements for the first lab areas you plan to use:
   - DLP policy creation requires a role group such as **Compliance administrator**, **Compliance data administrator**, **Information Protection**, **Information Protection Admin**, or **Security administrator**. citeturn2search127
   - Audit search requires **Audit Logs** or **View-Only Audit Logs** roles. citeturn2search145turn2search146
   - eDiscovery requires the correct eDiscovery permissions and enabled apps before you can create and manage cases. citeturn2search136
4. Open the tenant-visible learning object **Microsoft Purview: Introduction and Getting Started** and use it to familiarize yourself with the major Purview components before deeper labs. This course explicitly says it covers what Purview is, how to get started, and how to access Purview components. citeturn2search67
5. Review the internal security certification page and note the SC-401 alignment for this lab journey. The page explicitly lists **Information Security Administrator Associate [SC-401]**. citeturn2search96

## Validation
- You can sign in to the Microsoft Purview portal successfully. citeturn2search153
- You can identify which role assignments are required for the labs you intend to run. citeturn2search127turn2search145turn2search136turn2search153
- You have a learning baseline through **Microsoft Purview: Introduction and Getting Started** and the internal **SC-401** certification guidance. citeturn2search67turn2search96

## Expected result
At the end of this lab, your tenant is ready for Purview hands-on work, you know which admin account to use, and you have a documented alignment to the SC-401 learning journey. citeturn2search67turn2search96turn2search153

## Lessons learned
Purview labs become easier to troubleshoot when you verify roles first. Microsoft’s documentation consistently places permissions and tenant readiness before the feature workflow, especially for DLP, Audit, eDiscovery, and Compliance Manager. citeturn2search127turn2search145turn2search136turn2search153
