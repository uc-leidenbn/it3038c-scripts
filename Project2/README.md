# Project 2

FortiGate AutoBackup v2.1
======

This script allows for the automated download, dating, and sorting of Fortinet FortiGate Live Config Files. 

This script requires the following to function:
a Fortinet FortiGate Unit or Licensed VM,
SCP Enabled for an administrator,
SSH Enabled on the interface used for this transaction,
Public/Private Keys Configured on each unit,
and a .txt file containing the IPs of the FortiGate(s) with a return after the last IP.

The first section gets the date in the proper format we want and assigns it to a variable. 
```powershell
$Date = Get-Date -Format "dd-MM-yyyy"
```

The next section lets operators specify a backup path without combing through the script to change it. 
```powershell
$BackupPath = "X:\Fortinet"
```

The next section lets operators specify the location of the list of IP addresses of FortiGates. 
```powershell
$Fgts = "X:\Fortinet\FortiGates.txt"
```

Now, the bulk of the script runs as many times as there are IP addresses in the $Fgts file. 
```powershell
ForEach ($fgt in (Get-Content "$Fgts")) {

Write-Host "Processing FortiGate: $fgt "
#Allows operator to see which Firewall is being processed. 

New-Item $BackupPath\$Date\$fgt -type directory
#Creates new directory for the backup. 

pscp -i X:\Fortinet\FortiPrivate.ppk “admin@$($fgt):sys_config” $BackupPath\$Date\$fgt\
#Uses SCP to pull sys_config.conf file from the FortiGate using a private/public key pair.  
#-i signals the SSH Private Key. 

Rename-Item -Path "$BackupPath\$Date\$fgt\sys_config" -NewName "sys_config.conf"
#Adds file extension to allow file to be opened in a text editor.

}
```


Results: https://mailuc-my.sharepoint.com/:v:/g/personal/leidenbn_mail_uc_edu/EavuIG2ZKKpGl2-nTemkm0ABblgxTl-z--RQhEgfd-mswg?e=BEaCcb

References
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item?view=powershell-7.1
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/rename-item?view=powershell-7.1
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date?view=powershell-7.1
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-content?view=powershell-7.1&viewFallbackFrom=powershell-6

