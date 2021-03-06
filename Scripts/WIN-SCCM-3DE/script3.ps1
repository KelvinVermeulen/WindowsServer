Clear-Host;
Import-Module ServerManager;
Import-Module PackageManagement;

#De prerequisities worden ge�nstalleerd op de server.
Write-host("De De prerequisities worden ge�nstalleerd op de server. Dit kan even duren.")
Get-Module servermanager
Install-WindowsFeature Web-Windows-Auth
Install-WindowsFeature Web-Asp-Net
Install-WindowsFeature Web-ISAPI-Ext
Install-WindowsFeature Web-WMI
Install-WindowsFeature Web-Metabase
Install-WindowsFeature Web-Asp-Net45
Install-WindowsFeature BITS
Install-WindowsFeature RDC
Install-WindowsFeature NET-HTTP-Activation
Install-WindowsFeature NET-Non-HTTP-Activ
Install-WindowsFeature NET-Framework-Features
Install-WindowsFeature WDS -IncludeManagementTools
dism /online /enable-feature /featurename:NetFX3 /all /Source:d:\sources\sxs /LimitAccess
wdsutil /initialize-server /remInst:"C:\remInstall"

#De Windows 10 ISO file wordt verplaats naar een nieuwe locatie die makkelijker te bereiken is.
Write-Host("ISO file wordt verplaats naar C:\ISO\.")
Move-Item -Path "C:\Windows10_EN" -Destination "C:\ISO\Windows10_EN"

#Windows 10 ISO wordt gemount. Dit is eigenlijk "doen alsof" je een CD in je CD-lezer steekt
#om alle bestanden op die CD (in dit geval een ISO) te kunnen lezen.
Write-Host("ISO file wordt gemount.")
Set-Location -Path "C:\"
Mount-DiskImage -ImagePath "C:\Windows10_EN.iso"

#Configureren van WDS (Windows Deployment Service). WDS laat ons toe om via ��n gecentraliseerde server (dit apparaat)
#ontelbaar andere toestellen (andere servers, clients, programma's voor die clients...) te voorzien.
Write-Host("WDS wordt geconfigureerd.")
Import-WdsBootImage -Path "F:\sources\boot.wim"
New-WdsInstallImageGroup -Name "clients"
Import-WdsInstallImage -Path "C:\install.wim" -ImageGroup "clients"

#Installatie en configuratie van ADK (= Assessment and Deplyment Kit). Bevat enkele tools die het deployen van systemen vergemakkelijken.
Write-host("ADK wordt ge�nstalleerd en geconfigureerd.")
Invoke-WebRequest "http://go.microsoft.com/fwlink/p/?LinkId=526740&ocid=tia-235208000" -OutFile "ADK.exe"
.\ADK.exe /installpath "C:\Program Files (x86)\Windows Kits\10" /features OptionId.DeploymentTools OptionId.UserStateMigrationTool OptionId.WindowsPreinstallationEnvironment /ceip off /norestart /silent

#WSUS feature wordt gei�nstalleerd. WSUS staat voor Windows Server Update Services en zorgt
#ervoor dat updates voor ieder systeem centraal beheerd en ingesteld en gepland kunnen worden.
Write-Host("WSUS feature wordt ge�nstalleerd.")
Install-WindowsFeature -Name UpdateServices-Services, UpdateServices-DB -IncludeManagementTools

#Installatie van SCCM gebeurt hieronder.
Write-Host("Installatie van SCCM start nu...")
Move-Item -Path "C:\Users\Administrator\Documents" -Destination "C:\Files\"
Set-Location -Path "C:\Files\"

#.\SC2016_SCVMM.EXE /passive /norestart /silent
#.\SC2016_SCSM_X86.EXE /passive /norestart /silent
#.\SC2016_SCSM_AUTH.EXE /passive /norestart /silent
#.\SC2016_SCSM.EXE /passive /norestart /silent
#.\SC2016_SCOM_EN.EXE /passive /norestart /silent
#.\SC2016_SCO.EXE /passive /norestart /silent
#.\SC2016_SCDPM.EXE /passive /norestart /silent
.\SC_Configmgr_SCEP_1606.exe /passive /norestart /silent

Set-Location -Path "C:\"
.\SC_Configmgr_SCEP_1606\SMSSETUP\BIN\X64\setup.exe /script "C:\Files\Config.ini" /passive /norestart /silent


