# Phase 3: Hybrid Exchange Configuration 🔄

## Overview
This phase covers configuring a hybrid Exchange environment between on-premises Exchange 2019 and Exchange Online (Microsoft 365).

**Status: 🔄 In Progress — Coming Next Session**

---

## What Will Be Covered

- Running the Hybrid Configuration Wizard (HCW)
- Configuring Send/Receive connectors
- Setting up OAuth authentication
- Configuring MRS Proxy for mailbox migration
- Testing hybrid mail flow
- Migrating a test mailbox to Exchange Online

---

## Prerequisites (All Complete ✅)

- [x] On-premises Exchange 2019 installed and running
- [x] Azure AD Connect syncing users to Azure AD
- [x] Custom domain verified in M365
- [x] Exchange Hybrid option enabled in AAD Connect
- [x] M365 E3/E5 license available

---

## Steps (Coming Soon)

### Part A: Run Hybrid Configuration Wizard
- Download and run HCW from Exchange Admin Center
- Configure Classic Hybrid
- Enable OAuth
- Configure MRS Proxy

### Part B: Verify Connectors
- Verify Send connector created for hybrid
- Verify Receive connector created for hybrid
- Test OAuth connectivity

### Part C: Test Mail Flow
- Send email from on-prem to cloud mailbox
- Send email from cloud to on-prem mailbox

### Part D: Test Mailbox Migration
- Create migration batch
- Migrate test mailbox to Exchange Online
- Verify migrated mailbox

---

> 📝 This section will be updated in the next lab session.
