Clear-Host;
Import-Module ServerManager;
Import-Module PackageManagement;

#Downloaden van software en daarna mounten. Dit kan heel lang duren (bestand van 6GB).
Set-Location -Path "C:\Packages\"
Write-Host("Downloaden van software start nu. Even geduld...")
Invoke-WebRequest "https://download.microsoft.com/download/6/6/F/66F70200-E2E8-4E73-88F9-A1F6E3E04650/ExchangeServer2016-x64-cu11.iso" -OutFile ExchangeIso.iso
Dism /Online /Enable-Feature /All /FeatureName:Server-Gui-Mgmt /Source:C:\TempTest
Mount-DiskImage -ImagePath "C:\Packages\ExchangeIso.iso"

#Installatie van Exchange.
Set-Location -Path "C:\"
#Windows Defender kan soms problemen geven.
sc stop WinDefend
#Opletten of het effectief drive E:\ is, zo niet: veranderen!
Set-Location -Path "E:\"
Write-Host("Installatie van Exchange Server 2016 start nu. Even geduld...")
.\Setup.exe /PrepareSchema /IAcceptExchangeServerLicenseTerms 
.\Setup.exe /PrepareAD /IAcceptExchangeServerLicenseTerms 
.\Setup.exe /M:Install /R:Mailbox, ManagementTools /IAcceptExchangeServerLicenseTerms
Set-Location -Path "C:\"
sc start WinDefend

#Om plaats te besparen worden de packages verwijderd.
Write-Host("Reeds gedownloade bestanden worden verwijderd.")
Remove-Item –path c:\Packages\* -include *.exe


#Opnieuw opstarten
Write-Host("Opnieuw opstarten...")
Start-Sleep -s 300
Restart-computer
