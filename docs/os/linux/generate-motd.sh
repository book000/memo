#!/bin/sh
echo -e "\e[32m" > motd
figlet Nuts >> motd
echo -e "\e[m" >> motd
echo -e "-----= Hello. This server is \e[3;32mNuts\e[m. =-----" >> motd
