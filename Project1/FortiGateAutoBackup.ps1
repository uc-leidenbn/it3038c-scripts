#Developed & Owned by Gigabition Technologies - Copyright 2021
#Developed by Benjamin Leidenbor, President, on February 10th, 2021. 
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


$Date = Get-Date -Format “dd-MM-yyyy”
#Gets Date in Proper Format.

$BackupPath = “X:\Fortinet”
#Variable allows easy changing of backup repository.

New-Item $BackupPath\$Date\ -type directory
#Creates new Directory for Backup.

pscp -v -i X:\Fortinet\FortiPrivate.ppk “admin@10.0.1.159:sys_config” $BackupPath\$Date\ 
#Uses SCP to pull sys_config.conf file from non-production (but live) FortiGate. 
#-v adds visual output of script actions. 
#-i signals the SSH Private Key. 

Rename-Item -Path "X:\Fortinet\$Date\sys_config" -NewName "sys_config.conf"
#Adds file extension to allow file to be opened in a text editor. 

#Results: https://mailuc-my.sharepoint.com/:f:/g/personal/leidenbn_mail_uc_edu/EnCM_A8nLfVCv0digq09yscBaMnoVkT13_y_sVi3NjqOuQ?e=Y0hKaR

#References
#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item?view=powershell-7.1
#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/rename-item?view=powershell-7.1
#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date?view=powershell-7.1