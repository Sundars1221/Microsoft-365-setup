# 04-exchange-prereqs.ps1
# Install Exchange Server 2019 Prerequisites
# Run on Lab-EX01 as CORP\labadmin
# ⚠️ Server may reboot — re-run script after reboot if needed

Write-Host "Installing Exchange 2019 prerequisites..." -ForegroundColor Cyan

# Install required Windows Features
Install-WindowsFeature `
    NET-Framework-45-Features,
    RPC-over-HTTP-proxy,
    RSAT-Clustering,
    RSAT-Clustering-CmdInterface,
    RSAT-Clustering-Mgmt,
    RSAT-Clustering-PowerShell,
    Web-Mgmt-Console,
    WAS-Process-Model,
    Web-Asp-Net45,
    Web-Basic-Auth,
    Web-Client-Auth,
    Web-Digest-Auth,
    Web-Dir-Browsing,
    Web-Dyn-Compression,
    Web-Http-Errors,
    Web-Http-Logging,
    Web-Http-Redirect,
    Web-Http-Tracing,
    Web-ISAPI-Ext,
    Web-ISAPI-Filter,
    Web-Metabase,
    Web-Mgmt-Service,
    Web-Net-Ext45,
    Web-Request-Monitor,
    Web-Server,
    Web-Stat-Compression,
    Web-Static-Content,
    Web-Windows-Auth,
    Web-WMI,
    Windows-Identity-Foundation,
    RSAT-ADDS `
    -Restart

Write-Host "Prerequisites installed. If server rebooted, re-run this script to verify." -ForegroundColor Green
Write-Host "Then proceed to 05-exchange-ad-prep.ps1" -ForegroundColor Yellow
