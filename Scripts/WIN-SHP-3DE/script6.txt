#Mounting van de img file
Write-Host("SharePoint img file wordt gemount.")
Mount-DiskImage -ImagePath "C:\SharePointInstall\officeserver.img"

#Installatie SharePoint wordt uitgevoerd.
Write-Host("Installatie van SharePoint start nu..")
Set-Location -Path "C:\"
Start-Process "E:\setup.exe" -ArgumentList "/config `"C:\\SharePointInstall\Installation.xml` "" -WindowStyle Minimized -wait
