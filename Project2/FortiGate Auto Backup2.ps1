#Developed & Owned by Gigabition Technologies - Copyright 2021
#Developed by Benjamin Leidenbor, President, on March 11th, 2021. 
#mailto: licensing@gigabition.com
#Unauthorized Use, Sale, or Distribution is prohibited.

#Developed using FortiGate 100E running FortiOS 6.4.3.
#Create Basic Task in TaskScheduler for regular operations. 

#This script allows for the automated download and dating of Fortinet FortiGate Config Files. 

#This script requires the following to function:
#A Fortinet FortiGate Unit or Licensed VM.
#SCP Enabled for an administrator.
#SSH Enabled on the interface used for this transaction. 
#Public/Private Keys Configured.
#A .txt file containing the IPs of the FortiGate(s) with a return after the last IP. 

$Date = Get-Date -Format "dd-MM-yyyy"
#Gets Date in Proper Format.

$BackupPath = "X:\Fortinet"
#Variable allows easy changing of backup repository.

$Fgts = "X:\Fortinet\FortiGates.txt"
#References list of IP addresses of FortiGates. 


ForEach ($file in (Get-Content "$Fgts")) {

Write-Host "Processing FortiGate: $file "
#Allows operator to see which Firewall is being processed. 

New-Item $BackupPath\$Date\$file -type directory
#Creates new directory for the backup. 

pscp -i X:\Fortinet\FortiPrivate.ppk “admin@$($file):sys_config” $BackupPath\$Date\$file\
#Uses SCP to pull sys_config.conf file from the FortiGate using a private/public key pair.  
#-i signals the SSH Private Key. 

Rename-Item -Path "$BackupPath\$Date\$file\sys_config" -NewName "sys_config.conf"
#Adds file extension to allow file to be opened in a text editor.

}
#This ForEach Section processes the file line by line and sets the $file variable to the current line. 

#Results: https://mailuc-my.sharepoint.com/:f:/g/personal/leidenbn_mail_uc_edu/EnCM_A8nLfVCv0digq09yscBaMnoVkT13_y_sVi3NjqOuQ?e=Y0hKaR

#References
#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item?view=powershell-7.1
#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/rename-item?view=powershell-7.1
#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date?view=powershell-7.1
#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-content?view=powershell-7.1&viewFallbackFrom=powershell-6
