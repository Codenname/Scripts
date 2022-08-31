#!/usr/bin/sh

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


echo " "
echo "${ORANGE} [+][+][+] Would you like to begin Updates? (Y/N) ${NC}"
read nmap_answer
echo " "

if [ "$nmap_answer" = 'Y' ]; then
	# Check up updates
	echo " "
	echo "${CYAN} [+][+][+]  Checking for Updates  ${CYAN}[+][+][+]"
	echo " "
	sudo apt-get update -y > /dev/null
	wait 5

	# Distro upgrades
	echo " "
	echo "${CYAN} [+][+][+]  Now Checking for Upgrades along with disto upgrades  [+][+][+]"
	echo " "
	sudo apt-get full-upgrade -y > /dev/null 2>&1
	wait 5

	# Update 'SearchSploit' data base
	echo " "
	echo "${CYAN} [+][+][+]  Updating SearchSploit offline database  [+][+][+]"
	echo " "
	sudo apt update > /dev/null 2>&1
	sudo apt install exploitdb > /dev/null 2>&1
	sudo searchsploit --update > /dev/null 2>&1
	wait 5

	# Remove Un-needed
	sudo apt autoremove -y > /dev/null 2>&1

	# Clear Screen
	clear
	echo " "
	echo "${BLUE}   Script has finished and ready to hack${NC}"
	echo " "

else
	echo " "
	echo "${ORANGE}   Skipping Updates${NC}"
	echo " "
fi

