function getIP{
    (Get-NetIPAddress).ipv4address | Select-String "192*"
}


$IP=getIP
$getuser=$env:USERNAME
$gethostname=$env:COMPUTERNAME
$getDate=Get-Date -UFormat "%A, %B %e, %Y"
$Psversion=$Host.Version.Major

$mailbody="This machine's IP is $IP. User is $getuser. Hostname is $gethostname. Powershell Version $psversion. Today's Date is $getDate."

Send-MailMessage -To "leidenbn@mail.uc.edu" -From "us1-hosting@gigabition.com" -Subject "IT3038C Windows Sysinfo" -Body $mailbody -SmtpServer smtp.office365.com -port 587 -UseSsl -Credential (Get-Credential)
