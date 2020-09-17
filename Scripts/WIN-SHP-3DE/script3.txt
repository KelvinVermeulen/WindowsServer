$User = "KELVIN\Administrator"
$Password = ConvertTo-SecureString "Admin_2019" –AsPlaintext –Force
$cred = New-Object System.Management.Automation.PsCredential($User,$Password)
Add-Computer -DomainName "kelvin.periode3" -Credential $cred  