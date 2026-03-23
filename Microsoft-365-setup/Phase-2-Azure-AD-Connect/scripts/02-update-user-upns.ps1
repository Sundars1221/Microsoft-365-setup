# 02-update-user-upns.ps1
# Update all user UPNs in LabUsers OU to routable domain
# Run on Lab-DC01 as CORP\labadmin

# Replace with your values
$RoutableDomain = "yourdomain.com"
$OUPath         = "OU=LabUsers,DC=corp,DC=lab"

Write-Host "Updating UPNs for users in: $OUPath" -ForegroundColor Cyan
Write-Host "New UPN suffix: @$RoutableDomain" -ForegroundColor Yellow

# Get all users in the OU
$Users = Get-ADUser -Filter * -SearchBase $OUPath

foreach ($User in $Users) {
    $NewUPN = $User.SamAccountName + "@" + $RoutableDomain
    Set-ADUser $User -UserPrincipalName $NewUPN
    Write-Host "Updated: $($User.SamAccountName) → $NewUPN" -ForegroundColor Green
}

Write-Host "`n✅ All UPNs updated successfully!" -ForegroundColor Green

# Verify
Write-Host "`nVerification — Current UPNs:" -ForegroundColor Yellow
Get-ADUser -Filter * -SearchBase $OUPath | Select Name, UserPrincipalName | Format-Table -AutoSize
