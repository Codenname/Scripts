#!/bin/bash

ORANGE=$'\e[0;33m'
RED=$'\e[0;31m'
NC=$'\e[0m'


for host in $(cat IPs.txt); do
	cat Data/$(echo $host)/nmap/all_port_intial | grep 'http' | cut -d "/" -f 1 > Data/$(echo $host)/nmap/port80
	if grep "80" Data/$(echo $host)/nmap/port80 > /dev/null; then
		mkdir Data/$(echo $host)/Gobuster
		echo " "
		echo "${ORANGE}	[+][+][+] TCP Port 80 Found. Attempting to run Gobuster against the IP/port  ${NC}"
		echo " "
		gobuster dir -u $(echo $host) -w /usr/share/wordlists/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt --wildcard > Data/$(echo $host)/Gobuster/Gobuster_info
	else
		echo "Not found, keep working"
	fi
done