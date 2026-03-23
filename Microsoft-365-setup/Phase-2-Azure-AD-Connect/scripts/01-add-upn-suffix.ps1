# 01-add-upn-suffix.ps1
# Add routable UPN suffix to AD Forest
# Run on Lab-DC01 as CORP\labadmin

# Replace with your real domain
$RoutableDomain = "yourdomain.com"

Write-Host "Adding UPN suffix: $RoutableDomain" -ForegroundColor Cyan

# Add the routable UPN suffix
Get-ADForest | Set-ADForest -UPNSuffixes @{Add = $RoutableDomain}

# Verify
Write-Host "`nCurrent UPN suffixes:" -ForegroundColor Yellow
(Get-ADForest).UPNSuffixes
