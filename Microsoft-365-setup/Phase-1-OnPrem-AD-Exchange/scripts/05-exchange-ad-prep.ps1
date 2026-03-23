# 05-exchange-ad-prep.ps1
# Prepare Active Directory for Exchange Server 2019
# Run on Lab-EX01 as CORP\labadmin
# ⚠️ Exchange ISO must be mounted (e.g., as D:\) before running

# Set your Exchange ISO drive letter
$ExchangeDrive = "D:"

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "  Exchange AD Preparation" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan

# Verify running as domain account
$currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
Write-Host "Running as: $currentUser" -ForegroundColor Yellow

if ($currentUser -notlike "*CORP\*") {
    Write-Host "⚠️  WARNING: You are NOT logged in as a domain account!" -ForegroundColor Red
    Write-Host "Please log out and log back in as CORP\labadmin" -ForegroundColor Red
    exit
}

# Step 1: Prepare Schema
Write-Host "`nStep 1: Preparing AD Schema..." -ForegroundColor Cyan
& "$ExchangeDrive\Setup.exe" /PrepareSchema /IAcceptExchangeServerLicenseTerms_DiagnosticDataOFF
Write-Host "Schema preparation complete." -ForegroundColor Green

# Step 2: Prepare AD
Write-Host "`nStep 2: Preparing Active Directory..." -ForegroundColor Cyan
& "$ExchangeDrive\Setup.exe" /PrepareAD /OrganizationName:"LabOrg" /IAcceptExchangeServerLicenseTerms_DiagnosticDataOFF
Write-Host "AD preparation complete." -ForegroundColor Green

# Step 3: Prepare All Domains
Write-Host "`nStep 3: Preparing all domains..." -ForegroundColor Cyan
& "$ExchangeDrive\Setup.exe" /PrepareAllDomains /IAcceptExchangeServerLicenseTerms_DiagnosticDataOFF
Write-Host "Domain preparation complete." -ForegroundColor Green

Write-Host "`n✅ All AD preparation steps complete!" -ForegroundColor Green
Write-Host "Now run Setup.exe from the ISO to install Exchange Server 2019." -ForegroundColor Yellow
