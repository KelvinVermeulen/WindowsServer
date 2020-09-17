#Scherm leegmaken
Clear-Host;
#Maakt het makkelijker om rollen en services toe te voegen
Import-Module ServerManager;
Import-Module PackageManagement;


#We stellen het toetsenbord in op AZERTY en veranderen de tijdszone naar Brussel
write-Host ("Toetsenbord instellen naar AZERTY.")
Set-WinUserLanguageList -LanguageList NL-BE -Force;
Write-host("De tijdszone wordt ingesteld.");
Set-TimeZone "Romance Standard Time";


#We installeren de AD DS feature. AD DS staat voor Active Directory Domain Services
#en is een server rol die het toelaat aan admins om bijvoorbeeld de rechten en settings
#in het netwerk van een organisatie te beheren of automatisch software te installeren.
Add-WindowsFeature AD-Domain-Services
#We maken een forest aan en promoten dit apparaat tot domeincontroller van deze forest.
Install-ADDSForest -DomainName kelvin.periode3 -InstallDNS

#hierna wordt tweemaal gevraagd om het wachtwoord in te geven, in dit geval: Admin_2019
#druk hierna op "yes to all"

#De naamgeving van de twee netwerkadapters wordt aangepast.
Write-host("Netwerkadapter Ethernet 2 heeft nieuwe naamgeving,LAN.");
Rename-NetAdapter -Name "Ethernet 2" -NewName "LAN";
Write-host("Netwerkadapter Ethernet heeft nieuwe naamgeving,WAN.");
Rename-NetAdapter -Name "Ethernet" -NewName "WAN";

#statisch ip toevoegen aan interne NIC en dns-adres toevoegen aan WAN
netsh interface ip set address "LAN" static 192.168.100.10 255.255.255.0
Set-DnsClientServerAddress -InterfaceAlias WAN -ServerAddresses 192.168.100.10
Write-Host ("Script beëindigd.")

Write-Host ("Computer wordt herstart om de wijzigingen door te voeren.")
Restart-Computer -Force

pause
