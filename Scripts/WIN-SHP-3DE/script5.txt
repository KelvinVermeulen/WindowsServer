$RootFolder = "C:\SharePointInstall"
$Prereqs2Folder = "$RootFolder\SharePoint_Prerequisites\PrerequisiteInstaller"

$Downloads = @{
    "https://download.microsoft.com/download/F/1/0/F1093AF6-E797-4CA8-A9F6-FC50024B385C/AppFabric-KB3092423-x64-DEU.exe" = "$Prereqs1Folder\AppFabric-KB3092423-x64-DEU.exe";
    "https://download.microsoft.com/download/5/7/2/57249A3A-19D6-4901-ACCE-80924ABEB267/ENU/x64/msodbcsql.msi" = "$Prereqs2Folder\msodbcsql.msi";
    "https://download.microsoft.com/download/E/0/0/E0060D8F-2354-4871-9596-DC78538799CC/Synchronization.msi" = "$Prereqs2Folder\Synchronization.msi";
    "http://download.microsoft.com/download/D/7/2/D72FD747-69B6-40B7-875B-C2B40A6B2BDD/Windows6.1-KB974405-x64.msu" = "$Prereqs2Folder\Windows6.1-KB974405-x64.msu";
    "http://download.microsoft.com/download/0/1/D/01D06854-CA0C-46F1-ADBA-EBF86010DCC6/rtm/MicrosoftIdentityExtensions-64.msi" = "$Prereqs2Folder\MicrosoftIdentityExtensions-64.msi";
    "http://download.microsoft.com/download/3/C/F/3CF781F5-7D29-4035-9265-C34FF2369FA2/setup_msipc_x64.exe" = "$Prereqs2Folder\setup_msipc_x64.exe";
    "https://download.microsoft.com/download/1/C/A/1CAA41C7-88B9-42D6-9E11-3C655656DAB1/WcfDataServices.exe" = "$Prereqs2Folder\WcfDataServices56.exe";
    "https://download.microsoft.com/download/C/3/A/C3A5200B-D33C-47E9-9D70-2F7C65DAAD94/NDP46-KB3045557-x86-x64-AllOS-ENU.exe" = "$Prereqs2Folder\NDP46-KB3045557-x86-x64-AllOS-ENU.exe";
    "https://download.microsoft.com/download/F/1/0/F1093AF6-E797-4CA8-A9F6-FC50024B385C/AppFabric-KB3092423-x64-ENU.exe" = "$Prereqs2Folder\AppFabric-KB3092423-x64-ENU.exe";
    "https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe" = "$Prereqs2Folder\vcredist_x64.exe";
    "http://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/vc_redist.x64.exe" = "$Prereqs2Folder\vc_redist.x64.exe"
    "http://silverlight.dlservice.microsoft.com/download/F/8/C/F8C0EACB-92D0-4722-9B18-965DD2A681E9/30514.00/Silverlight_x64.exe" = "$Prereqs3Folder\Silverlight_x64.exe";
    "https://download.microsoft.com/download/7/6/1/7614E07E-BDB8-45DD-B598-952979E4DA29/EwsManagedApi.msi" = "$Prereqs3Folder\EwsManagedApi.msi";
    "https://download.microsoft.com/download/2/5/6/256CCCFB-5341-4A8D-A277-8A81B21A1E35/clearcompressionflag.exe" = "$Prereqs1Folder\clearcompressionflag.exe";
    "https://download.microsoft.com/download/A/6/7/A678AB47-496B-4907-B3D4-0A2D280A13C0/WindowsServerAppFabricSetup_x64.exe" = "$Prereqs1Folder\WindowsServerAppFabricSetup_x64.exe";
    "https://download.microsoft.com/download/B/E/D/BED73AAC-3C8A-43F5-AF4F-EB4FEA6C8F3A/ENU/x64/sqlncli.msi" = "$Prereqs1Folder\sqlncli.msi";
    "https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU4/vcredist_arm.exe" = "$Prereqs1Folder\vcredist_arm.exe";
    #"https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe" = "$Prereqs1Folder\vcredist_x64.exe";
}

#Aangezien het zoveel downloads zijn gebruiken we een scriptje om te overlopen welke downloads reeds gebeurd zijn.
Import-Module BitsTransfer
function DownloadFiles
{
    Write-Host ""
    Write-Host "====================================================================="
    Write-Host "             Downloading SharePoint Prerequisites"
    Write-Host "====================================================================="

    $ReturnCode = 0

    $Downloads.GetEnumerator() | ForEach {
        $DownloadURL = $_.get_key()
        $Filespec = $_.get_value()
        # Get the file name based on the portion of the file path after the last slash
        $FilePath = Split-Path $Filespec
        $FileName = Split-Path $Filespec -Leaf
        Write-Host "DOWNLOADING: $FileName"
        Write-Host "       FROM: $DownloadURL"
        Write-Host "         TO: $FilePath"
        Try
        {
            # Controleer of de file al bestaat
            If (!(Test-Path "$Filespec"))
            {
                # Begin download
                Start-BitsTransfer -Source $DownloadURL -Destination "$Filespec" -DisplayName "Downloading `'$FileName`' to $FilePath" -Priority High -Description "From $DownloadURL..." -ErrorVariable err
                If ($err) {Throw ""}
                Write-Host "     STATUS: Downloaded"
                Write-Host
                $params = "/norestart /passive /silent"
                Invoke-Expression ("."+ "\" + $FileName + " " +$params)
            }
            Else
            {
                Write-Host "     STATUS: Already exists. Skipping."
                Write-Host
            }
        }
        Catch
        {
            $ReturnCode = -1
            Write-Warning " AN ERROR OCCURRED DOWNLOADING `'$FileName`'"
            Write-Error   $_
            Break
        }
    }
    return $ReturnCode
}

$rc = DownloadFiles 

if($rc -ne -1)  
{
    Write-Host ""
    Write-Host "DOWNLOADS ARE COMPLETE."
}