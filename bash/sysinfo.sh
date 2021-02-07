#!/bin/bash
# This is the script for Lab 2
emailaddress=leidenbn@mail.uc.edu
today=
ip=
content=
echo "Name: "$USER
echo "Server Name is "$HOSTNAME
echo "IP Address is "$(ip a | grep 'dynamic ens192' | awk '{print $2}')

d=$(date +"%m-%d-%Y %H:%M%p")
echo "Date and Time is "$d

echo "Email will contain: $content"
mail -s "IT3038C Linux IP" $emailaddress <<< $(echo -e $content)


