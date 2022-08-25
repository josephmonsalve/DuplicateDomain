#!/bin/bash

#Telegram TOKEN and ID

token="Type your bot token here"
ID="Type the id of the person you want to send the message to"
URL="https://api.telegram.org/bot$token/sendPhoto"

#Start script
if [ "$#" -eq "0" ]; then
	echo "please add list of permutations"
	exit 1	
fi
filename=$1
while read line; do 
    whois $line -H | grep -E "Domain Name|Creation Date|Registrant Country|Registrant State/Province" >> result.txt
    code_Verification=`echo $?`
    if [[ $code_Verification -eq 0]]; then
        Message="URL Founded: ${line} for more information look your telegram"
        echo " " >> ./result.txt
        x-www-browser $line &
		sleep 45
		scrot capture.png
		pkill browser 
		curl -X POST $URL -F chat_id=$ID -F caption="$Message" -F photo="@./capture.png" 
		rm capture.png
    else
        echo "The domain $line not found"
    fi 

     sleep 15s 

 done < $filename

 echo "Add another file for start again"
