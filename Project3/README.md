# Project 3

FortiGate AutoBackup v3.1
======

This script allows for the automated download, dating, and sorting of Fortinet FortiGate Live Config Files. 

This script requires the following to function:
a Fortinet FortiGate Unit or Licensed VM,
SCP Enabled for an administrator,
SSH Enabled on the interface used for this transaction,
Public/Private Keys Configured on each unit,
and a .txt file containing the IPs of the FortiGate(s) with a return after the last IP.


The first section enables our network adapter to allow communication between the VM and the FortiGates. 
```powershell
Enable-NetAdapter -Name "Ethernet"
```

This section tells the script to pause for 10 seconds. This allows the network to connect. 
```powershell
Start-Sleep -s 10
```

This section gets the date in the proper format we want and assigns it to a variable. 
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

The next section lets operators specify the location of the log file that shows execution times of this script. 
```powershell
$backuplog = "X:\Fortinet\BackupRunLog.txt"
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

This section adds the date and timestamp to the log file. 
```powershell
Add-Content -Path $backuplog -Value (Get-Date)
```

This section disables the network adapter to prevent unauthorized network access to this VM without prompting for confirmation. 
```powershell
Disable-NetAdapter -Name "Ethernet" -Confirm:$false
```

Results: https://mailuc-my.sharepoint.com/:v:/g/personal/leidenbn_mail_uc_edu/EVeF3e5aLv9JjYUyknzeL5UB4VCVyVaIao8ylLFUjD4ULw?e=qCwxY1

References
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item?view=powershell-7.1
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/rename-item?view=powershell-7.1
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date?view=powershell-7.1
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-content?view=powershell-7.1&viewFallbackFrom=powershell-6
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/add-content?view=powershell-7.1
https://stackoverflow.com/questions/4753702/automatic-confirmation-of-deletion-in-powershell

