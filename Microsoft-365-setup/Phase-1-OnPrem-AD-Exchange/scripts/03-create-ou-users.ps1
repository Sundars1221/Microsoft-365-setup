# 03-create-ou-users.ps1
# Create Organizational Unit and Test Users
# Run on Lab-DC01 as CORP\labadmin after DC promotion

# Replace with your domain
$DomainDN = "DC=corp,DC=lab"
$OUName   = "LabUsers"

Write-Host "Creating OU: $OUName" -ForegroundColor Cyan

# Create OU
New-ADOrganizationalUnit `
    -Name $OUName `
    -Path $DomainDN `
    -ProtectedFromAccidentalDeletion $false

Write-Host "OU created successfully." -ForegroundColor Green

# Create test user
$Password = ConvertTo-SecureString "YourStr0ngP@ssword!" -AsPlainText -Force

New-ADUser `
    -Name "Test User" `
    -GivenName "Test" `
    -Surname "User" `
    -SamAccountName "testuser" `
    -UserPrincipalName "testuser@yourdomain.com" `
    -Path "OU=$OUName,$DomainDN" `
    -AccountPassword $Password `
    -Enabled $true `
    -PasswordNeverExpires $true `
    -ChangePasswordAtLogon $false

Write-Host "Test user created successfully." -ForegroundColor Green

# Verify
Get-ADUser -Filter * -SearchBase "OU=$OUName,$DomainDN" | Select Name, UserPrincipalName, Enabled
