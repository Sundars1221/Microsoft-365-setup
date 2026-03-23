# 02-promote-dc.ps1
# Promote server to Domain Controller
# Run on Lab-DC01 after AD DS role is installed
# ⚠️ Server will reboot automatically after this script

# Replace these values with your own
$DomainName     = "corp.lab"
$NetBIOSName    = "CORP"
$DSRMPassword   = ConvertTo-SecureString "YourDSRMP@ssword!" -AsPlainText -Force

Write-Host "Promoting server to Domain Controller..." -ForegroundColor Cyan
Write-Host "Domain: $DomainName" -ForegroundColor Yellow

Install-ADDSForest `
    -DomainName $DomainName `
    -DomainNetbiosName $NetBIOSName `
    -ForestMode "WinThreshold" `
    -DomainMode "WinThreshold" `
    -InstallDns:$true `
    -SafeModeAdministratorPassword $DSRMPassword `
    -Force:$true

# Server will reboot automatically
