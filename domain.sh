#!/bin/bash

#Telegram TOKEN and ID

token="Type your bot token here"
ID="Type the id of the person you want to send the message to"
URL="https://api.telegram.org/bot$token/sendMessage"

#Start script
if [[ -n $1 ]]; then
    filename=$1
    while read line; do 
        whois $line -H | grep -E "Domain Name|Creation Date|Registrant Country|Registrant State/Province" >> result.txt
        code_Verification=`echo $?`

        if [[ $code_Verification -eq 0]]; then
            Message="URL Founded: ${line} for more information look your telegram"
            echo " " >> ./result.txt
            curl -s -x POST $URL -d chat_id=$ID -d text ="$Message"
        else
            echo "The domain $line not found"
        fi 

        sleep 15s 

    done < $filename

    echo "Add another file for start again"

else
    echo "Please enter the permutations file"
fi
