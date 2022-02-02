#Variable list
$progfiles = (Get-ChildItem "env:ProgramFiles(x86)" | Select-Object Value); $progfiles = $progfiles.Value
$startupLoc = [Environment]::GetFolderPath('Startup')

#Ending possibly existing Processes
If ($null -ne (Get-Process -Name NcatClientService -ErrorAction SilentlyContinue)){Stop-Process -Name NcatClientService}; If ($null -ne (Get-Process -Name NcatClient -ErrorAction SilentlyContinue)){Stop-Process -Name NcatClient}; If ($null -ne (Get-Process -Name Ncat -ErrorAction SilentlyContinue)){Stop-Process -Name Ncat};
Start-Sleep 1


#Check for and uninstall Nmap in C:\Program Files(x86)
If($null -ne (Get-Item -Path "$progfiles\Nmap" -ErrorAction SilentlyContinue))
{Remove-item -Path "$progfiles\Nmap" -Recurse -Confirm:$false;If($null -eq (Get-Item -Path "$progfiles\Nmap" -ErrorAction SilentlyContinue)){Write-Host "Nmap deleted"}Else{Write-Host "An error occured deleting Nmap"; Pause}}Else{Write-Host "Nmap was not found"}

#Check for and uninstall Nmap and startupNC.vbs
If($null -ne (Get-Item -Path "$startupLoc\startupNC.vbs" -ErrorAction SilentlyContinue))
{Remove-Item -Path "$startupLoc\startupNC.vbs" -Recurse -Confirm:$false
If($null -eq (Get-Item -Path "$startupLoc\startupNC.vbs" -ErrorAction SilentlyContinue))
{Write-Host "Startup deleted"}Else{Write-Host "An error occured deleting startupNC"; Pause}}Else{Write-Host "StartupNC was not found"}