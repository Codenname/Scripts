#!/bin/bash

# Must have libnotify-bin installed // apt-get install libnotify-bin 
# If you don't want to use notifications, just remove the lines below
# NEED TO UPDATE WHEN TESTING

## IMPORTANT:      Current directory setup needs a .txt of IPs and a "Data" directory (empty)
# All files will be stored within this "Data" directory and further by host (IP address).


#Bash Colors so it looks professional
ORANGE="\e[0;33m"
RED="\e[0;31m"
BLUE="\e[0;34m"
YELLOW="\e[0;33m"
PURPLE="\e[0;35m"
CYAN="\e[0;36m"
NC="\e[0m"


#ASCII Art


echo "${ORANGE}  "                                          
echo "  _________            .___                                           "
echo "  \_   ___ \  ____   __| _/____   ____   ____  _____    _____   ____  "
echo "  /    \  \/ /  _ \ / __ |/ __ \ /    \ /   '\'\__  \  /     \_/ __ \ "
echo "  \     \___(  <_> ) /_/ \  ___/|   |  \   |  \/ __  \|  Y Y  \  ___/ "
echo "   \______  /\____/\____ |\___  >___|  /___|  (____  / __|_|  /\___ > "
echo "          \/            \/    \/     \/     \/     \/       \/     \/ "
echo " "
echo " ${NC} "

echo "........How to use this script........."
echo " "
echo "This script was a personal project to take some of the enumeration techniques and automate them. "
echo "With automation in place, while certain tools are running, a user is able to review the  output files and multi-task"
echo " "
echo "The script can be called from any directory but within the current working directory, a directory called 'Data' is needed"
echo "along with a file called 'IPs.txt' for the IP addresses you are testing."
echo " "

sleep 2

echo "${RED}
####################################
#                                  #
#  Making the working directories  #
#                                  #
#################################### ${NC}"

echo " "
echo "${CYAN} [+][+][+] Creating the IP Directories ${NC}"
echo " "
for host in $(cat IPs.txt); do
	mkdir Data/$(echo $host)
done

echo "${RED}
########################################
#                                      #  
#  Nmap Initial SYN enumeration scans  #
#                                      #
######################################## ${NC}"

echo " "
echo "${ORANGE} [+][+][+] Would you like to begin Nmap Enumeration? (Yes/No) ${NC}"
read nmap_answer
echo " "

if [ "$nmap_answer" = 'Y' ]; then
for host in $(cat IPs.txt); do
	mkdir Data/$(echo $host)/nmap
	echo " "
	echo "${ORANGE} [+][+][+] Beginning Nmap Quick All Port (--min-rate) Scan on host $(echo $host) ${NC}"
	echo " "
	nmap --min-rate 10000 -Pn -p- -oN Data/$(echo $host)/nmap/all_port_intial $host
	sleep 5
	
# Work on fine turning the parsing of open ports. (Maybe add Regex)
	# echo " "
	# echo "${ORANGE} [+][+][+] Parsing open ports from scan results for $(echo $host) ${NC}"
	# echo " "
	# cat Data/$(echo $host)/nmap/all_port_intial | grep 'open' | cut -d "/" -f 1 > Data/$(echo $host)/nmap/nmap_open_ports
	# cat Data/$(echo $host)/nmap/nmap_open_ports | awk '{print $1}' | tr '\n' ',' > Data/$(echo $host)/port_list
	# sleep 5 

done

#port_list = "$(cat Data/$(echo $host)/port_list)"

#echo "${RED}
####################
#                  #
# Target Port Scan #
#                  #
####################  ${NC}"

#for host in $(cat IPs.txt); do
#	echo " "
#	echo "${ORANGE} [+][+][+] Beginning Nmap Target Port (port) Scan on host $(echo $host) ${NC}"
#	echo " "
#	nmap -A -v -Pn -p $(cat Data/$(echo $host)/port_list) -oN Data/$(echo $host)/nmap/target_port_scan $host
#	sleep 5
#done

for host in $(cat IPs.txt); do
	echo " "
	echo "${ORANGE} [+][+][+] Beginning Nmap SYN (-sS) Scan on host $(echo $host) ${NC}"
	echo " "
	nmap -sS -v -Pn -oN Data/$(echo $host)/nmap/initial_scan $host
	sleep 5
done

echo "${RED}
#####################
#                   #
#  Nmap frag Scans  #
#                   #
##################### ${NC}"


for host in $(cat IPs.txt); do
	echo " "
	echo "${ORANGE}	[+][+][+] Beginning Nmap frag (-f) Scan on host $(echo $host) ${NC}"
	echo " "
	nmap -f -v -Pn -T4 -oN Data/$(echo $host)/nmap/frag_scan $host
done

else
	echo 'Skipping nmap enumeration'
fi

echo "${RED}
####################
#                  #
#  Nmap UDP Scans  #
#                  #
####################  ${NC}"


for host in $(cat IPs.txt); do
	echo " "
	echo "${ORANGE}	[+][+][+] Beginning Nmap UDP (-sU) Scan on host $(echo $host) ${NC}"
	echo " "
	nmap -sU -Pn -T4 -oN Data/$(echo $host)/nmap/udp_scan $host
done


##########################
#                        #
#  Gobuster Enumeration  #
#                        #
##########################


#for host in $(cat IPs.txt); do
#	cat Data/$(echo $host)/nmap/all_port_intial | grep 'http' | cut -d "/" -f 1 > Data/$(echo $host)/nmap/port80
#	if grep "80" Data/$(echo $host)/nmap/port80 > /dev/null; then
#		mkdir Data/$(echo $host)/Gobuster > /dev/null
#		echo " "
#		echo "${ORANGE}	[+][+][+] TCP Port 80 Found. Attempting to run Gobuster against the IP/port  ${NC}"
#		echo " "
#		gobuster dir -u $(echo $host) -w /usr/share/wordlists/seclists/Discovery/Web-Content/common.txt --wildcard > Data/$(echo $host)/Gobuster/Gobuster_info
#	else
#		echo "${RED} [+][+][+] Port 80 file not found through nmap enumeration. Assuming it is closed, please review nmap output files ${NC}"
#	fi
#done

###########################
#                         # 
#  Dirbuster Enumeration  #
#                         #
###########################


#for host in $(cat IPs.txt); do
#	cat Data/$(echo $host)/nmap/all_port_intial | grep 'https' | cut -d "/" -f 1 > Data/$(echo $host)/nmap/port443
#	if grep "443" Data/$(echo $host)/nmap/port443 > /dev/null; then
#		mkdir Data/$(echo $host)/Dirbuster
#		echo " "
#		echo "${ORANGE}	[+][+][+] TCP Port 443 Found. Attempting to run Dirb against the IP/port  ${NC}"
#		echo " "
#		dirb https://$(echo $host)/ -o Data/$(echo $host)/Dirbuster/Dirbuster_info
#	else
#		echo "${RED} [+][+][+] Port 443 file not found through nmap enumeration. Assuming it is closed, please review nmap output files ${NC}"
#	fi
#done


###########################
#                         #
#    wfuzz Enumeration    #
#                         #
###########################


###########################
#                         #
#     SMB Enumeration     #
#                         #
###########################

