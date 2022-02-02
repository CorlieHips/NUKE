for(;;){
try
{
Clear-Host
$title="
########################################################################
#                                                                      #
#                        Netcat ReverseSSH.exe                         #
#                             by Charles                               #
#                                                                      #
########################################################################

"
$title

$clientPort = Read-Host "Connect to Client; (1001-1010)"

If($clientPort -In 1001..1010)
{
    Break
}
}
catch    {    }    

}
Clear-Host
$title

ncat -lvvkp $clientPort