Clear-Host;
Import-Module ServerManager;
Import-Module PackageManagement;

#Instellen regio en toetsenbord
Write-host("Het toetsenbord wordt ingesteld op AZERTY.");
Set-WinUserLanguageList -LanguageList NL-BE -Force;
Write-host("De tijdzone wordt ingesteld op Brussel");
Set-TimeZone "Romance Standard Time";

#Ethernet adapter krijgt juiste naam en IP-adres. Hierdoor kunnen we verbinding maken met het internet.
Write-host("Veranderen naam Ethernet naar LAN.");
Rename-NetAdapter -Name "Ethernet" -NewName "LAN";
Write-host("IP-adres, subnetmask, Default Gateway en DNS van LAN-adapter worden geconfigureerd. ")
New-NetIPAddress -InterfaceAlias LAN -AddressFamily IPv4 -IPAddress 192.168.100.40 -PrefixLength 24 -DefaultGateway 192.168.100.10
Write-host("DNS adres wordt geconfigureerd.")
Set-DnsClientServerAddress -InterfaceAlias LAN -ServerAddresses 192.168.100.10

#Het systeem wordt toegevoegd aan het domein.
Write-Host("Server wordt toegevoegd aan het domein kelvin.periode3")
Add-Computer -DomainName "kelvin.periode3" -Credential (Get-Credential KELVIN\Administrator)

#Het systeem krijgt de naam: WIN-SCCM-3DE.
Write-Host("Server krijgt nieuwe naam: WIN-SCCM-3DE")
Rename-Computer -NewName "WIN-SCCM-3DE"
Start-Sleep -s 30

#Systeem herstarten.
Write-Host("Server wordt herstart.")
Restart-computer