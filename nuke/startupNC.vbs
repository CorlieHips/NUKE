Set WshShell = CreateObject("WScript.Shell")
set objShell = CreateObject("Wscript.Shell")

progLoc = objShell.ExpandEnvironmentStrings("%PROGRAMFILES(x86)%") & ("\Nmap\NcatClientService.exe")

WshShell.Run chr(34) & progLoc & Chr(34), 0
Set WshShell = Nothing