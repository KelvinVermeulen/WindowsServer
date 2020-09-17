Import-Module ActiveDirectory;
Import-Module Servermanager;

#Aanmaken van noodzakelijke gebruikers
New-ADOrganizationalUnit -path "dc=kelvin, dc=periode3" -name "Users SP2016" -ProtectedFromAccidentalDeletion:$false
New-ADUser -Path "CN=Users,DC=kelvin,DC=periode3" -Name "spAdmin" -AccountPassword (ConvertTo-SecureString "Password1" –AsPlaintext –Force) -Description "SharePoint Setup Account" -ChangePasswordAtLogon:$False -CannotChangePassword:$True -PasswordNeverExpires:$True -Enabled:$True
New-ADUser -Path "CN=Users,DC=kelvin,DC=periode3" -Name "sqlSvcAcc" -AccountPassword (ConvertTo-SecureString "Password2" –AsPlaintext –Force) -Description "SQL Server Service Account" -ChangePasswordAtLogon:$False -CannotChangePassword:$True -PasswordNeverExpires:$True -Enabled:$True
New-ADUser -Path "CN=Users,DC=kelvin,DC=periode3" -Name "spFarmAcc" -AccountPassword (ConvertTo-SecureString "Password3" –AsPlaintext –Force) -Description "SharePoint Farm Account" -ChangePasswordAtLogon:$False -CannotChangePassword:$True -PasswordNeverExpires:$True -Enabled:$True
New-ADUser -Path "CN=Users,DC=kelvin,DC=periode3" -Name "spAppPool" -AccountPassword (ConvertTo-SecureString "Password4" –AsPlaintext –Force) -Description "SharePoint Application Pool Account" -ChangePasswordAtLogon:$False -CannotChangePassword:$True -PasswordNeverExpires:$True -Enabled:$True

#spAdmin wordt toegevoegd aan admin groep van domein
Write-Host("spAdmin wordt toegevoegd aan admin groep van domein.")
Add-ADGroupMember `
-Identity 'Administrators' `
-Members "CN=spAdmin,CN=Users,DC=kelvin,DC=periode3"
Add-ADGroupMember `
-Identity 'Domain Users' `
-Members "CN=spAdmin,CN=Users,DC=kelvin,DC=periode3"
Add-ADGroupMember `
-Identity 'Enterprise Admins' `
-Members "CN=spAdmin,CN=Users,DC=kelvin,DC=periode3"
Add-ADGroupMember `
-Identity 'Group Policy Creator Owners' `
-Members "CN=spAdmin,CN=Users,DC=kelvin,DC=periode3"
Add-ADGroupMember `
-Identity 'Schema Admins' `
-Members "CN=spAdmin,CN=Users,DC=kelvin,DC=periode3"

#sqlSvcAcc wordt toegevoegd aan admin groep van domein
Write-Host("spAdmin wordt toegevoegd aan admin groep van domein.")
Add-ADGroupMember `
-Identity 'Domain Admins' `
-Members "CN=sqlSvcAcc,CN=Users,DC=kelvin,DC=periode3"
Add-ADGroupMember `
-Identity 'Administrators' `
-Members "CN=sqlSvcAcc,CN=Users,DC=kelvin,DC=periode3"
Add-ADGroupMember `
-Identity 'Enterprise Admins' `
-Members "CN=sqlSvcAcc,CN=Users,DC=kelvin,DC=periode3"
Add-ADGroupMember `
-Identity 'Group Policy Creator Owners' `
-Members "CN=sqlSvcAcc,CN=Users,DC=kelvin,DC=periode3"
Add-ADGroupMember `
-Identity 'Schema Admins' `
-Members "CN=sqlSvcAcc,CN=Users,DC=kelvin,DC=periode3"

#spFarmAcc wordt toegevoegd aan juiste groepen.
Write-Host("spFarmAcc wordt toegevoegd aan admin groep van domein.")
Add-ADGroupMember `
-Identity 'Domain Admins' `
-Members "CN=spFarmAcc,CN=Users,DC=kelvin,DC=periode3"
Add-ADGroupMember `
-Identity 'Administrators' `
-Members "CN=spFarmAcc,CN=Users,DC=kelvin,DC=periode3"
Add-ADGroupMember `
-Identity 'Enterprise Admins' `
-Members "CN=spFarmAcc,CN=Users,DC=kelvin,DC=periode3"
Add-ADGroupMember `
-Identity 'Group Policy Creator Owners' `
-Members "CN=spFarmAcc,CN=Users,DC=kelvin,DC=periode3"
Add-ADGroupMember `
-Identity 'Schema Admins' `
-Members "CN=spFarmAcc,CN=Users,DC=kelvin,DC=periode3"

#spAppPool wordt toegevoegd aan juiste groepen.
Write-Host("Gebruiker spAppPool wordt toegevoegd aan admin groep van domein.")
Add-ADGroupMember `
-Identity 'Domain Admins' `
-Members "CN=spAppPool,CN=Users,DC=kelvin,DC=periode3"
Add-ADGroupMember `
-Identity 'Administrators' `
-Members "CN=spAppPool,CN=Users,DC=kelvin,DC=periode3"
Add-ADGroupMember `
-Identity 'Enterprise Admins' `
-Members "CN=spAppPool,CN=Users,DC=kelvin,DC=periode3"
Add-ADGroupMember `
-Identity 'Group Policy Creator Owners' `
-Members "CN=spAppPool,CN=Users,DC=kelvin,DC=periode3"
Add-ADGroupMember `
-Identity 'Schema Admins' `
-Members "CN=spAppPool,CN=Users,DC=kelvin,DC=periode3"

#Installeren van belangrijke features
Write-Host " Volgende installaties kunnen heel lang duren..."
Write-Host " - Installing .NET Framework Feature..."
get-windowsfeature|where{$_.name -eq "NET-Framework-Core"}|install-windowsfeature –Source d:\sources\sxs
get-windowsfeature|where{$_.name -eq "NET-HTTP-Activation"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "NET-Non-HTTP-Activ"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "NET-WCF-HTTP-Activation45"}|install-windowsfeature

Write-Host " - Installing 'Application Server' role..."
get-windowsfeature|where{$_.name -eq "AS-AppServer-Foundation"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "AS-Web-Support"}|install-windowsfeature

Write-Host " - Installing 'Web Server' role..."
get-windowsfeature|where{$_.name -eq "Web-Static-Content"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "Web-Default-Doc"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "Web-Dir-Browsing"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "Web-Http-Errors"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "Web-Http-Redirect"}|install-windowsfeature

get-windowsfeature|where{$_.name -eq "Web-App-Dev"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "Web-Asp-Net45"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "Web-Net-Ext"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "Web-Net-Ext45"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "Web-ISAPI-Ext"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "Web-ISAPI-Filter"}|install-windowsfeature

get-windowsfeature|where{$_.name -eq "Web-Http-Logging"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "Web-Log-Libraries"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "Web-Request-Monitor"}|install-windowsfeature

get-windowsfeature|where{$_.name -eq "Web-Stat-Compression"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "Web-Dyn-Compression"}|install-windowsfeature

get-windowsfeature|where{$_.name -eq "Web-Filtering"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "Web-Basic-Auth"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "Web-Windows-Auth"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "Web-Digest-Auth"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "Web-Client-Auth"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "Web-Cert-Auth"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "Web-Url-Auth"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "Web-IP-Security"}|install-windowsfeature

get-windowsfeature|where{$_.name -eq "Web-Mgmt-Tools"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "Web-Mgmt-Console"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "Web-Mgmt-Compat"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "Web-Metabase"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "Web-Lgcy-Mgmt-Console"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "Web-Lgcy-Scripting"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "Web-WMI"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "Web-Scripting-Tools"}|install-windowsfeature

Write-Host " - Installing WAS Feature..."
get-windowsfeature|where{$_.name -eq "WAS-Process-Model"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "WAS-NET-Environment"}|install-windowsfeature
get-windowsfeature|where{$_.name -eq "WAS-Config-APIs"}|install-windowsfeature

Write-Host " - Installing Windows Identity Foundation Feature..."
get-windowsfeature|where{$_.name -eq "Windows-Identity-Foundation"}|install-windowsfeature
