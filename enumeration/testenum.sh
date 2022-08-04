#!/bin/bash

#Nmap Initial SYN enumeration scans

ORANGE=$'\e[0;33m'
RED=$'\e[0;31m'
NC=$'\e[0m'



for host in $(cat IPs.txt); do
	mkdir Data/$(echo $host)/nmap
	echo "${ORANGE}   [+][+][+] Beginning Nmap Quick All Port (--min-rate) Scan on host $(echo $host) ${NC}

	"
	nmap --min-rate 10000 -Pn -p- -oN Data/$(echo $host)/nmap/all_port_intial $host
	sleep 5
	echo "${ORANGE}   [+][+][+] Parsing open ports from scan results for $(echo $host) ${NC}

	"

	cat Data/$(echo $host)/nmap/all_port_intial | grep 'open' | cut -d "/" -f 1 > Data/$(echo $host)/nmap/nmap_open_ports
	cat Data/$(echo $host)/nmap/nmap_open_ports | awk '{print $1}' | tr '\n' ',' > Data/$(echo $host)/port_list
	sleep 5 
done

port_list = "$(cat Data/$(echo $host)/port_list)"

for host in $(cat IPs.txt); do
	echo "   [+] Beginning Nmap SYN (-sS) Scan on host $(echo $host)"
	nmap -sS -vvv -Pn -oN Data/$(echo $host)/nmap/initial_scan $host
	echo "Parsing Output File for open ports"
done

#More target port scan

for host in $(cat IPs.txt); do
	echo "   [+] Beginning Nmap Target Port (port) Scan on host $(echo $host)"
	nmap -A -vvv -Pn -p $(cat Data/$(echo $host)/port_list) -oN Data/$(echo $host)/nmap/target_port_scan $host
done