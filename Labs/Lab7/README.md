# Lab7 ReadME

AzureAD User Information
======

#This script gathers basic information from a user in an AzureAD tenant.

#First, define the UPN (userprincipalname) you wish to get details from.

```powershell
$userprincipalname = 'username@domain.com'
```
#Second, we will want to connect to our AzureAD Tenant using a properly authorized account. Run the following command & enter the account information you wish to use. 

```powershell
Connect-AzureAD
```
#After successfully signing in, the rest of the script will run as follows: 

