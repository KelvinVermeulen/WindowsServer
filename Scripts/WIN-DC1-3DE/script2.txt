#Set hostname to 'WIN-DC1-3DE' as specified in the assignment.
write-host "Changing hostname"
Rename-Computer -NewName WIN-DC1-3DE

#Installeren van DHCP feature. DHCP staat voor Dynamic Host Configuration Protocol en zorgt ervoor dat het eerstvolgende IP adres dat beschikbaar is in zijn "pool"
#toegekend wordt wanneer er een computer verbinding maakt met netwerk. Dit vergemakkelijkt de installatie van nieuwe apparaten binnen één netwerk enorm.
write-host ("DHCP wordt geïnstalleerd.")
Install-WindowsFeature DHCP -IncludeManagementTools

#Beschikbaar maken van DHCP in het domein.
write-host ("DHCP feature wordt geconfigureerd.")
Add-DhcpServerInDC
Get-DhcpServerInDC


#Installeren en configureren van de DHCP-scope (="pool") waaruit de toekomstige windows clients hun IP adres zullen verkrijgen.
write-host("Instellen van IP-range voor clients.")
Add-DhcpServerv4Scope -name "HoGent3DE" -StartRange 192.168.100.160 -EndRange 192.168.100.200 -SubnetMask 255.255.255.0
Get-DhcpServerv4Scope

#Instellen van router en DNS voor DHCP server.
Write-host("Router en DNS server informatie wordt ingesteld.")
Set-DhcpServerv4OptionValue -Router 192.168.100.10 -DnsServer 192.168.100.10
Get-DhcpServerv4OptionValue

#Opnieuw opstarten van DHCP server om wijzigingen door te voeren.
write-host ("De dhcp service wordt herstart.")
Restart-Service dhcpserver
Get-Service dhcpserver

#Verzoeken waar niet op kunnen geantwoord worden worden doorgestuurd naar DNS-server van de school en van Google
write-host "DNS Forwarders 193.190.173.1 en 8.8.8.8 worden toegevoegd"
Add-DnsServerForwarder -IPAddress 193.190.173.1 
Add-DnsServerForwarder -IPAddress 8.8.8.8 
Get-DnsServerForwarder

#Installeren van de routing feature. Er wordt herstart indien nodig.
write-host ("Routing feature wordt geinstalleerd.")
Install-windowsFeature Routing -IncludeManagementTools -Restart

#Configureren van NAT. NAT staat voor Network Address Translation en het komt erop neer dat we via deze interface ervoor gaan zorgen dat we internet toegang hebben op ons intern netwerk.
write-host ("NAT wordt geconfigureerd.")
Install-RemoteAccess -VpnType Vpn
netsh routing ip nat install
netsh routing ip nat add interface "WAN"
netsh routing ip nat set interface "WAN" mode=full
netsh routing ip nat add interface "LAN"

Restart-Computer

pause