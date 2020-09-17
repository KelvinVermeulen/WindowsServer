Clear-Host;
Import-Module ServerManager;
Import-Module PackageManagement;

#Installatie van Chocolatey. Dit is een "package manager" die helpt bij het automatiseren van Windows programmas.
#In dit geval: SQL Server 2017 (nodig voor SCCM).
#Chocolatey wordt geïnstalleerd.
Write-Host("Chocolatey wordt geïnstalleerd. Dit kan even duren.");
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'));
choco feature enable -n allowGlobalConfirmation;

#Installatie van SQL server. Dit is een voorwaarde om SCCM te installeren/gebruiken.
Write-Host("SQLServer wordt momenteel gëinstalleerd. Dit kan even duren.");
choco install sql-server-management-studio -y
choco install webdeploy -y

#Voorwaarde voor SCCM.
Set-Location -Path "C:\Users\Administrator\Documents"
choco install sql-server-express --params='/ConfigurationFile="SQLConfig.ini"' -y

#Herstarten om wijzigingen door te voeren.
Start-Sleep -s 30
Write-Host("Server wordt opnieuw opgestart.")
Restart-computer
