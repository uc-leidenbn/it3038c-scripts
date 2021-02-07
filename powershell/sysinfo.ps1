function getIP{
    (Get-NetIPAddress).IPv4Address | Select-String "192*"
}

write-host(getIP)