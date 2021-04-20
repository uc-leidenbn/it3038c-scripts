#Developed & Owned by Gigabition Technologies - Copyright 2021
#Developed by Benjamin Leidenbor, President, on April 18th, 2021. 
#mailto: licensing@gigabition.com
#Unauthorized Use, Sale, or Distribution is prohibited.

#Developed using FortiGate 100E & running FortiOS 6.4.3.
#Create Basic Task in TaskScheduler for regular operations. 

#This script allows for the automated download and dating of Fortinet FortiGate Config Files. 

#This script requires the following to function:
#A Fortinet FortiGate Unit or Licensed VM.
#SCP Enabled for an administrator.
#SSH Enabled on the interface used for the transaction. 
#Public/Private Keys configured on all units.
#A .txt file containing the IPs of the FortiGate(s) with a return after the last IP. 

Enable-NetAdapter -Name "Ethernet"
#Enables the network adapter to access the FortiGate units.

Start-Sleep -s 10
#Pauses script while network adapter connects to network. 

$Date = Get-Date -Format "dd-MM-yyyy"
#Gets date in proper format.

$BackupPath = "X:\Fortinet"
#Backup repository to store configuration files.

$Fgts = "X:\Fortinet\FortiGates.txt"
#References list of IP addresses of FortiGates. 

$backuplog = "X:\Fortinet\BackupRunLog.txt"
#File containing all dates and times of script uses. 


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
#This ForEach section processes the file line by line and sets the $fgt variable to the current line. 

Add-Content -Path $backuplog -Value (Get-Date)
#Adds the date and time of the script execution to a file. 

Disable-NetAdapter -Name "Ethernet" -Confirm:$false
#Disables the network adapter to prevent unauthorized access to this VM over the network. 

#Results:https://mailuc-my.sharepoint.com/:v:/g/personal/leidenbn_mail_uc_edu/EVeF3e5aLv9JjYUyknzeL5UB4VCVyVaIao8ylLFUjD4ULw?e=qCwxY1

#References
#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item?view=powershell-7.1
#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/rename-item?view=powershell-7.1
#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date?view=powershell-7.1
#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-content?view=powershell-7.1&viewFallbackFrom=powershell-6
#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/add-content?view=powershell-7.1
#https://stackoverflow.com/questions/4753702/automatic-confirmation-of-deletion-in-powershell
