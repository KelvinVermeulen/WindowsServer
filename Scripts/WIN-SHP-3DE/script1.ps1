Clear-Host;
Import-Module ServerManager;
Import-Module PackageManagement;

#Instellen van toetsenbord en regio naar juiste waarden.
Write-host("Het toetsenbord wordt AZERTY.");
Set-WinUserLanguageList -LanguageList NL-BE -Force;
Write-host("De tijdszone wordt ingesteld op Brussel.");
Set-TimeZone "Romance Standard Time";

#Configureren van Ethernet adapter
Write-host("Ethernet-adapter heet nu LAN.");
Rename-NetAdapter -Name "Ethernet" -NewName "LAN";
Write-host("Instellen van IP-adres, Subnetmask en Default Gateway.")
New-NetIPAddress -InterfaceAlias LAN -AddressFamily IPv4 -IPAddress 192.168.100.50 -PrefixLength 24 -DefaultGateway 192.168.100.10
Write-host("Instellen van correcte DNS-adres.")
Set-DnsClientServerAddress -InterfaceAlias LAN -ServerAddresses 192.168.100.10

#Toevoegen aan domein
Write-Host("Server wordt gevoegd aan het domein kelvin.periode3.")
Add-Computer -DomainName "kelvin.periode3" -Credential (Get-Credential KELVIN\Administrator)

#Naam veranderen
Write-Host("Server wordt hernoemd naar WIN-SHP-3DE")
Rename-Computer -NewName "WIN-SHP-3DE"

#Systeem herstarten.
Write-Host("Systeem wordt opnieuw opgestart om de wijzigingen door te voeren.")
Start-Sleep -s 20
Restart-computer