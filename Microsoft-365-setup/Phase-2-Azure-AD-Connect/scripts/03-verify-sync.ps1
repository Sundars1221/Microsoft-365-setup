# 03-verify-sync.ps1
# Verify and trigger Azure AD Connect sync
# Run on Lab-DC01 as CORP\labadmin

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "  Azure AD Connect Sync Verification" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan

# Check if AAD Connect module is available
if (!(Get-Module -ListAvailable -Name ADSync)) {
    Write-Host "❌ ADSync module not found. Is Azure AD Connect installed?" -ForegroundColor Red
    exit
}

Import-Module ADSync

# Check current sync status
Write-Host "`nCurrent Sync Status:" -ForegroundColor Yellow
Get-ADSyncConnectorRunStatus

# Check last sync time
Write-Host "`nLast Sync Details:" -ForegroundColor Yellow
Get-ADSyncScheduler | Select LastSyncCycleStartedDate, LastSyncCycleResult, NextSyncCyclePolicyType

# Trigger a delta sync
Write-Host "`nTriggering Delta Sync..." -ForegroundColor Cyan
Start-ADSyncSyncCycle -PolicyType Delta

Write-Host "✅ Delta sync triggered. Wait 2-3 minutes then check Azure AD / M365 Admin Center." -ForegroundColor Green
Write-Host "`nVerify at:" -ForegroundColor Yellow
Write-Host "  - https://admin.microsoft.com → Users → Active Users" -ForegroundColor White
Write-Host "  - https://portal.azure.com → Azure Active Directory → Users" -ForegroundColor White
Write-Host "  - https://portal.azure.com → Azure Active Directory → Azure AD Connect" -ForegroundColor White
