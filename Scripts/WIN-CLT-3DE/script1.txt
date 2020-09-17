Rename-Computer -NewName "WIN-CLT1-3DE"

#Ethernet adapters worden aangepast met zijn juiste settings en naam.
Write-host("Netwerkadapter Ethernet heet nu LAN.");
Rename-NetAdapter -Name "Ethernet" -NewName "LAN";
Write-host("Instellen van DNS settings. ")
New-NetIPAddress -InterfaceAlias LAN -Dhcp Enabled
Set-DnsClientServerAddress -InterfaceAlias LAN -ServerAddresses 192.168.100.10

#Toevoegen aan het domein
Write-Host("Computer wordt toegevoegd in het domein.")
Add-Computer -domainname "kelvin.periode3" -Credential (Get-Credential KELVIN\Administrator)

#Downloaden van Adobe Reader
Write-Host("Download en installatie van Adobe Reader")
Invoke-WebRequest "http://ardownload.adobe.com/pub/adobe/reader/win/AcrobatDC/1502320053/AcroRdrDC1502320053_en_US.exe" -OutFile adobeReader.exe
.\adobeReader.exe /passive /norestart /silent