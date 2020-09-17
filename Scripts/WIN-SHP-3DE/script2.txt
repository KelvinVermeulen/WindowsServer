$OrganizationalUnit = "Users SP2016"
$Domain = "kelvin"
$DomainEnding = "periode3"

Import-Module ActiveDirectory

New-ADOrganizationalUnit -path "dc=$Domain, dc=$DomainEnding" -name $OrganizationalUnit -ProtectedFromAccidentalDeletion:$false  
New-ADUser -Path "OU=$OrganizationalUnit,DC=$Domain,DC=$DomainEnding" -Name "spAdmin" -AccountPassword (ConvertTo-SecureString "Password_1" –AsPlaintext –Force) -Description "SharePoint Setup Account" -ChangePasswordAtLogon:$False -CannotChangePassword:$True -PasswordNeverExpires:$True -Enabled:$True  
New-ADUser -Path "OU=$OrganizationalUnit,DC=$Domain,DC=$DomainEnding" -Name "sqlSvcAcc" -AccountPassword (ConvertTo-SecureString "Password_1" –AsPlaintext –Force) -Description "SQL Server Service Account" -ChangePasswordAtLogon:$False -CannotChangePassword:$True -PasswordNeverExpires:$True -Enabled:$True  
New-ADUser -Path "OU=$OrganizationalUnit,DC=$Domain,DC=$DomainEnding" -Name "spFarmAcc" -AccountPassword (ConvertTo-SecureString "Password_1" –AsPlaintext –Force) -Description "SharePoint Farm Account" -ChangePasswordAtLogon:$False -CannotChangePassword:$True -PasswordNeverExpires:$True -Enabled:$True  
New-ADUser -Path "OU=$OrganizationalUnit,DC=$Domain,DC=$DomainEnding" -Name "spAppPool" -AccountPassword (ConvertTo-SecureString "Password_1" –AsPlaintext –Force) -Description "SharePoint Application Pool Account" -ChangePasswordAtLogon:$False -CannotChangePassword:$True -PasswordNeverExpires:$True -Enabled:$True 