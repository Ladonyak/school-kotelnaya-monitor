#!/bin/bash

ad=y
while  [ "$ad" = "y" ]
do
clear
echo -e "               Kotelnaya $(date +"%T, %d-%m-%Y"), delay 10s."
echo -e "   ┌───────┐               ┌───────────────┐"
echo -e "${K[0]}(1)\E[0m┼─     ─┼${K[1]}(2)\E[0m            │               ├─${K[6]}(7)\E[0m           ${K[8]}(9)\E[0m▄"
echo -e "   │       │           ${K[4]}(5)\E[0m─┤               │                ┴─┴"
echo -e "   │       │               │               │             │        │"
echo -e "   │       │               │               │             ├${K[9]}(10)\E[0m${K[10]}(11)\E[0m┤"
echo -e "${K[2]}(3)\E[0m┼─     ─┼${K[3]}(4)\E[0m            │   ${CYAN}TANK, II\E[0m    │             │        │"
echo -e "   └───────┘               │               │             "
echo -e " ${GREEN}Head Exchanger, I\E[0m     ${K[5]}(6)\E[0m─┤               │           ${MAGENTA}Heating main, III\E[0m"
echo -e "                           │               ├─${K[7]}(8)\E[0m"
echo -e "                           └───────────────┘"


LIST=`cat /etc/temploggerd.conf  | grep [0-9] | awk '{print $2}'`
SENS=`cat /etc/temploggerd.conf  | grep '^sensor [0-9]'`
FSENS=`cat /etc/temploggerd.conf  | grep '^sensor [0-9]' | awk '{print $2}'`
NSENS=(`cat /etc/temploggerd.conf  | grep '^sensor [0-9]' | awk '{print $3,$4,$5}'`)

RED='\E[0;31m'       #  ${RED}
GREEN='\E[0;32m'     #  ${GREEN}
YELLOW='\E[0;33m'     #  ${YELLOW}
BLUE='\E[0;34m'       #  ${BLUE}
MAGENTA='\E[0;35m'     #  ${MAGENTA}
CYAN='\E[0;36m'       #  ${CYAN}
NORMAL='\E[0m'      #  ${NORMAL}
BLINK='\E[5m'       #  ${BLINK}
BOLD='\033[1m'       #  ${BOLD}

OWFS="/var/opt/owfs/"

T="/temperature"

S=0


TH=90
TL=-50

for I in $FSENS; do
        TEMP=`cat $OWFS$I$T 2>/dev/null | sed 's/ *//' | cut -d"." -f1`
        if (($TL < $TEMP && $TEMP < $TH)) 2>/dev/null
        then
                case $S in
                        [0-3])
                        KK=${GREEN}
                        ;;
                        [4-7])
                        KK=${CYAN}
                        ;;
                        [8-9])
                        KK=${MAGENTA}
                        ;;
                        10)
                        KK=${MAGENTA}
                        ;;
                        *)
                        KK=${YELLOW}
                        ;;
                esac
        K[$S]=${NORMAL}
        echo -e "${NSENS[$S]}   ${KK}$TEMP°C\E[0m"


        else

        K[$S]=${RED}
        echo -e "${NSENS[$S]}   $RED$BOLD!!!!!\E[0m"

        fi
        let "S=$S+1"

done

sleep 10s


done
