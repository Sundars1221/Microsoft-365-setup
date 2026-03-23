# 01-install-adds.ps1
# Install Active Directory Domain Services Role
# Run on Lab-DC01 as local Administrator

Write-Host "Installing AD DS Role..." -ForegroundColor Cyan

Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

Write-Host "AD DS Role installed successfully. Now run 02-promote-dc.ps1" -ForegroundColor Green
