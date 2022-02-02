# NUKE BY CHARLES
An executable Backdoor with PowerShell and Ncat. Not to be used with malicious intent!

NUKE is a free to use backdoor installer which uses PowerShell to perform a scan of the Victims device, and then install and run an executable allowing you,
the host, to operate their system.

results folder is where scan results are stored
nuke/host is where the main executable for the 'host' is stored
startupNC is used for running C:\Program Files (x86)\Nmap\NcatClientService.exe

NcatClient.exe is the main executable responsible for attempting to connect to the host
NcatClientService.exe is responsible for making sure that NcatClient.exe is up and running

unins.exe is the uninstall executable and remove all traces of C:\Program Files(x86)\Nmap

Folder labelled 'Nmap' has everything else that is needed and contains NcatClient.exe and NcatClientService.exe

Any help or suggestions on improvements / helpful feedback from experts would be greatly appreciated
