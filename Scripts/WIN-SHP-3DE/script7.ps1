#Declaratie van de variabelen.
$DBServer = 'WIN-SQL-3DE.kelvin.periode3'
$ConfigDB = 'spFarmConfiguration'
$CentralAdminContentDB = 'spCentralAdministration'
$CentralAdminPort = '2016'
$PassPhrase = 'Password_1'
$SecPassPhrase = ConvertTo-SecureString $PassPhrase –AsPlaintext –Force
$FarmAcc = 'KELVIN\spFarmAcc'
$FarmPassword = 'SharePointFarm'
$FarmAccPWD = ConvertTo-SecureString $FarmPassword  –AsPlaintext –Force
$cred_FarmAcc = New-Object System.Management.Automation.PsCredential $FarmAcc,$FarmAccPWD
$ServerRole = "Custom"

write-host ("---------------------------------------------------------------")

#SP powershell cmdlets worden geënabled.
Write-Host "Enabling SP PowerShell cmdlets..."
If ((Get-PsSnapin |?{$_.Name -eq "Microsoft.SharePoint.PowerShell"})-eq $null)
{
    Add-PsSnapin Microsoft.SharePoint.PowerShell | Out-Null
}
Start-SPAssignment -Global | Out-Null

write-host ("---------------------------------------------------------------")

Write-Host " Creating configuration database..."
New-SPConfigurationDatabase –DatabaseName "$ConfigDB" –DatabaseServer "$DBServer" –AdministrationContentDatabaseName "$CentralAdminContentDB" –Passphrase $SecPassPhrase –FarmCredentials $cred_FarmAcc -LocalServerRole $ServerRole

write-host ("---------------------------------------------------------------")

Write-Host " - Installing Help Collection..."
Install-SPHelpCollection -All

write-host ("---------------------------------------------------------------")

Write-Host " - Securing Resources..."
Initialize-SPResourceSecurity

write-host ("---------------------------------------------------------------")

Write-Host " - Installing Services..."
Install-SPService

write-host ("---------------------------------------------------------------")

Write-Host " - Installing Features..."
$Features = Install-SPFeature –AllExistingFeatures -Force

write-host ("---------------------------------------------------------------")

Write-Host " - Creating Central Admin..."
$NewCentralAdmin = New-SPCentralAdministration -Port $CentralAdminPort -WindowsAuthProvider "NTLM"

write-host ("---------------------------------------------------------------")

Write-Host " - Waiting for Central Admin to provision..." -NoNewline
sleep 5
Write-Host "Created!"

write-host ("---------------------------------------------------------------")

Write-Host " - Installing Application Content..."
Install-SPApplicationContent

write-host ("---------------------------------------------------------------")

Stop-SPAssignment -Global | Out-Null
