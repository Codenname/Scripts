#!/usr/bin/sh

#Bash Colors so it looks professional
ORANGE="\e[0;33m"
RED="\e[0;31m"
BLUE="\e[0;34m"
YELLOW="\e[0;33m"
PURPLE="\e[0;35m"
CYAN="\e[0;36m"
NC="\e[0m"
BLACK="\e[0;30m"



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
#echo "${PURPLE} [+][+][+] What is the testing domain?${NC}"
read domain
echo "${NC} "

echo " "
echo "${PURPLE} [+][+][+] What is the Comapny name for testing? (As seen in LinkedIn URL)${NC}"
read company
echo "${NC} "

echo " "
#echo "${YELLOW} [+] The Domain is.... ${NC}" $domain
echo " "
echo "${YELLOW} [+] The Comapny is.... ${NC}" $company
echo " "


mkdir Threat_Labs
mkdir Threat_Labs/Projects
mkdir Threat_Labs/Projects/$company
mkdir Threat_Labs/Tools

#cd Threat_Labs/Tools
echo " "
echo "${RED}   {+}{+} Installing Tools, user input required! {+}{+}"
echo " "

git clone -q "https://github.com/laramies/theHarvester.git" "Threat_Labs/Tools/theHarvester"
spawn python3 -m pip install -r Threat_Labs/Tools/theHarvester/requirements/base.txt > /dev/null 2>&1
expect "Username for 'https://github.com':" {send "\r"}
sudo apt install dnsenum
#sudo apt install metagoofil -y
#apt-get install exiftool -y
git clone -q "https://github.com/m8sec/pymeta" "Threat_Labs/Tools/pymeta" 
git clone -q "https://github.com/aboul3la/Sublist3r.git" "Threat_Labs/Tools/sublist3r" 