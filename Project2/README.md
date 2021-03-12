# Project 2

FortiGate AutoBackup v2.1
======

This script allows for the automated download, dating, and sorting of Fortinet FortiGate Live Config Files. 

This script requires the following to function:
A Fortinet FortiGate Unit or Licensed VM.
SCP Enabled for an administrator.
SSH Enabled on the interface used for this transaction. 
Public/Private Keys Configured on each unit. 
A .txt file containing the IPs of the FortiGate(s) with a return after the last IP.

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
ForEach ($file in (Get-Content "$Fgts")) {

Write-Host "Processing FortiGate: $file "
#Allows the operator to see which Firewall is being processed. 

New-Item $BackupPath\$Date\$file -type directory
#Creates a new directory for the backup. 

pscp -i X:\Fortinet\FortiPrivate.ppk “admin@$($file):sys_config” $BackupPath\$Date\$file\
#Uses SCP to pull sys_config.conf file from the FortiGate using a private/public key pair.  
#-i signals pscp to use the SSH Private Key. 

Rename-Item -Path "$BackupPath\$Date\$file\sys_config" -NewName "sys_config.conf"
#Adds file extension to allow file to be opened in a text editor like Notepad++.

}
```


Results: https://mailuc-my.sharepoint.com/:f:/g/personal/leidenbn_mail_uc_edu/EnCM_A8nLfVCv0digq09yscBaMnoVkT13_y_sVi3NjqOuQ?e=Y0hKaR

References
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item?view=powershell-7.1
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/rename-item?view=powershell-7.1
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date?view=powershell-7.1
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-content?view=powershell-7.1&viewFallbackFrom=powershell-6
















Before running this script, we must install the necessary module, which is called the "Azure Active Directory PowerShell for Graph module."

In an administrative powershell window, run the following: 
```powershell
Install-Module -Name AzureAD
```

This script gathers basic information from a user in an AzureAD tenant.

First, define the UPN variable (userprincipalname) in the script you wish to get details from.

```powershell
$userprincipalname = 'username@domain.com'
```
Second, we will want to connect to our AzureAD Tenant using a properly authorized account. Running the script will bring up a authorization window. Sign in with the account you wish to use to access Azure AD. 

```powershell
Connect-AzureAD
```
After successfully signing in, the rest of the script will run as follows: 

```powershell
Get-AzureADUserRegisteredDevice -ObjectID "$userprincipalname"
```
```powershell
Get-AzureADUserManager -ObjectID "$userprincipalname"
```
```powershell
Get-AzureADUserLicenseDetail -ObjectID "$userprincipalname"
```
The output of the script will contain various detailed information about the parameters we called for in the commands above. 

Note: Each time the script is run, signing in to AzureAD is required. 
