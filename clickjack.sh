#!/bin/bash

NC='\033[0m'
RED='\033[1;38;5;196m'
BLUE='\033[1;38;5;012m'
CP='\033[1;38;5;221m'
CNC='\033[1;38;5;051m'

function single_url() {
    clear
    banner
    echo -e -n ${BLUE}"\n[+] Reading URLs from login-auto.txt\n"
    urls=$(cat login-auto.txt)

    counter=1
    for url in $urls; do
        check=$(curl -s -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/81.0" --connect-timeout 5 --head $url)
        echo "$check" >> temp.txt
        sami=$(cat temp.txt | egrep -w 'X-Frame-Options|Content-Security-Policy|x-frame-options|content-security-policy:')
        
        if [[ $sami = '' ]]; then
            echo -e -n "\n[ ✔ ] ${NC}$url ${RED}VULNERABLE \n"
            sleep 1
            
            if [ -f vuln$counter.html ]; then
                rm vuln$counter.html
            fi
            if [ -f poc.html ]; then
                cat poc.html | sed "s|vuln|$url|" >> vuln$counter.html
                rm temp.txt
                echo -e -n ${CP}"[+] POC Saved As vuln$counter.html"
                sleep 1
                xdg-open vuln$counter.html
                counter=$((counter+1))
            else
                echo -e -n ${RED}"[ X ] POC File Not Found! Exiting"
                exit
            fi
        else
            echo -e -n ${CP}"\n[ X ] $url ${CG}NOT VULNERABLE "
        fi
    done
}

trap ctrl_c INT
ctrl_c() {
    clear
    echo -e ${RED}"[*] (Ctrl + C ) Detected, Trying To Exit... "
    echo -e ${RED}"[*] Stopping Services... "
    if [ -f temp.txt ]; then
        rm temp.txt
    fi
    sleep 1
    echo ""
    echo -e ${CP}"[*] Thanks For Using CLICK-J1CK3R  :)"
    exit
}

function menu() {
    clear
    echo -e ${CP}"\n[*] Are you ready to test: \n "
    echo -e "  ${NC}[${CG}"1"${NC}]${CNC} Start the Attack"
    echo -e "  ${NC}[${CG}"2"${NC}]${CNC} Exit"

    echo -n -e ${CP}"\n[+] Select: "
    read redi_play

    if [ $redi_play -eq 1 ]; then
        single_url
    elif [ $redi_play -eq 2 ]; then
        exit
    fi
}

menu
