#!/bin/bash
#Create script that emails us stuff
emailaddress=leidenbn@mail.uc.edu
today=$(date +"%d-%m-%Y %H:%M:%S%p")
ip=$(ip a | grep 'dynamic ens192' | awk '{print $2}')

content="User $USER 
Server Name is $HOSTNAME 
IP Address is $ip
Date and Time is $today"

content2="Server Name is $HOSTNAME"

echo "Email will contain:" ; echo "$content"
mail -s "IT3038C Linux IP" $emailaddress <<< $(echo -e $content)

#u=$(printf "User %s\n" $USER)
#s=$(printf "Server Name is %s\n" $HOSTNAME)
#i=$(printf "IP Address is %s\n" $ip)
#t=$(printf "Date and Time is %s\n" $today)


#function SEND_STATS()
#{
#echo  "User $USER"
#echo  "Server Name is $HOSTNAME"
#echo  "IP Address is $ip"
#echo  "Date and Time is $today"
#}
