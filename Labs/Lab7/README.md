# Lab7 ReadME

AzureAD User Information
======

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
