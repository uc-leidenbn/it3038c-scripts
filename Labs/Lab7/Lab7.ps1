#Getting Detailed Information about a user's devices, manager, and applied licenses. 

Connect-AzureAD
#Log in using the GUI pop-up. 

$userprincipalname = 'jim@gigabition.com'
#specify user's UPN here, example shown. 


Get-AzureADUserRegisteredDevice -ObjectID "$userprincipalname"
#Fetches information about any devices a user has registered, includes version, hostname, etc. 

Get-AzureADUserManager -ObjectID "$userprincipalname"
#Fetches the user's manager information, includes name, UPN, etc. 

Get-AzureADUserLicenseDetail -ObjectID "$userprincipalname"
#Fetches applied licenses, example contains Business Standard & Power Automate. 

