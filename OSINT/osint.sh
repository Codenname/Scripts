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
echo "${RED}   {+}{+}{+}{+}{+} Current Supported Tools {+}{+}{+}{+}{+}"
echo "   _______________________________________________________"
echo " "
echo "${BLUE} {+} Linkedin2username"
echo "${BLUE} {+} theHarvester"
echo "${BLUE} {+} DNSenum (Top 5k domains)"
echo "${BLUE} {+} PyMeta"
echo "${BLUE} {+} Crt.sh"
echo "${BLUE} {+} MX Records with NSlookup"
echo "${BLUE} {+} Fierce"
echo "${BLUE} {+} Sublist3r"
echo "${BLUE} {+} Whois"
echo "${BLUE} {+} Metagoofil"
echo "${BLUE} {+} DNSrecon>"
echo "${BLUE} {+} Amass"

#echo "${BLUE} {+} Hunter.io"
#echo "${BLUE} {+} <TOOL>"
#echo "${BLUE} {+} Spiderfoot"
#echo "${BLUE} {+} "
echo "${BLUE} _____________________${NC}"
echo " "

sleep 7

echo " "
echo "${RED}   {+}{+}{+}{+}{+} Before you Begin!!!! {+}{+}{+}{+}{+}"
echo " "
echo " 1. Make sure you are logged into LinkedIn"
echo " 2. Make sure your are in a directory in which folders,subfolders, and docs can be save"
echo " 3. If running advanced theHarvester scan, make sure you have your API keys updated (api-keys.yaml)"
echo " 4. If running advanced DNSEnum, make sure you have the seclist wordlists in your /usr/share/wordlists"
echo " "
echo " "
echo " "

sleep 5

############################################################

# User Input

echo " "
echo "${PURPLE} [+][+][+] What is the testing domain?${NC}"
read domain
echo "${NC} "

echo " "
echo "${PURPLE} [+][+][+] What is the Comapny you are testing?${NC}"
read company
echo "${NC} "

echo " "
echo "${PURPLE} [+][+][+] What is the Comapny name as seen on LinkedIn for testing?${NC}"
read linkedin
echo "${NC} "

echo " "
echo "${PURPLE} [+][+][+] What is your LinkedIn email? ${NC}"
read email
echo "${NC} "

echo " "
echo "${ORANGE} [+][+][+] Would you like to run a Basic or Advance Harvestor scan? (B/A) ${NC}"
read havester
echo " "

echo " "
echo "${ORANGE} [+][+][+] Would you like to run a Basic or Advance DNSenum scan? (B/A) ${NC}"
read dnsenum
echo " "

echo " "
echo "${YELLOW} [+] The Domain is.... ${NC}" $domain
echo " "
echo "${YELLOW} [+] The Company is.... ${NC}" $company
echo " "
echo "${YELLOW} [+] Your email is.... ${NC}" $email
echo " "

############################################################

# Directory Setup


# Create Threat_Labs
mkdir Threat_Labs
# Create Projects
mkdir Threat_Labs/Projects
# Create Customer Folder
mkdir Threat_Labs/Projects/$company


#############################################################
# Tools Download/Install


#git clone -q "https://github.com/laramies/theHarvester.git" "Threat_Labs/Tools/theHarvester"
#python3 -m pip install -r Threat_Labs/Tools/theHarvester/requirements/base.txt  > /dev/null 2>&1
#sudo apt install dnsenum
#sudo apt install metagoofil -y
#apt-get install exiftool -y
#git clone -q "https://github.com/m8sec/pymeta" "Threat_Labs/Tools/pymeta" 
#git clone -q https://github.com/aboul3la/Sublist3r.git "Threat_Labs/Tools/sublist3r" 


#############################################################
# Tool Paths

# This section is used for when you want to run locally saved tools. 
# This will use the tools locally instead of the installed ones during

#theHarvester
theHarvester='/root/Tools/' #hardcode the path to your local 'theHavester.py' file


# Linkedin2Username
li2u='/root/Tools/' #hardcode the path to your local 'linkedin2username.py' file

#PyMeta
pymeta='/root/Tools/' #hardcode the path to your local 'pymeta.py' file


#############################################################


echo " "
echo "${YELLOW} [+] LinkedIn2Username Python Script found at ... ${NC} "$li2u
echo " "

echo
python3 $li2u -u $email -c $linkedin -n $domain 

mkdir Threat_Labs/Projects/$company/li2u
mv li2u* Threat_Labs/Projects/$company/li2u


##################
#                #
#  theHarvester  #
#                #
##################

if [ "$havester" = 'B' ]; then
	# Basic Scan
	echo " "
	echo "${CYAN} [+][+][+]  theHarvester - Google ${CYAN}[+][+][+]"
	echo " "
	$theHarvester -d "$domain" -b google > harvester_google_results 2>/dev/null
	
else
	# If you want to run an advanced scan, add your api keys to .yaml file in the running directory 
	# Otherwise this will not grab all the searches due to wrong api file being pulled
	#

	echo " "
	echo "${CYAN} [+][+][+]  theHarvester - All ${CYAN}[+][+][+]"
	$theHarvester -d "$domain" -b all > harvester_all_results 2>/dev/null
fi

mkdir Threat_Labs/Projects/$company/theHarvester
mv harvester_* Threat_Labs/Projects/$company/theHarvester


##################
#                #
#     Amass      #
#                #
##################


echo "${CYAN} [+][+][+]  Amass ${CYAN}[+][+][+]"
echo " "

amass enum -d $domain -passive > amass_results 2>/dev/null

mkdir Threat_Labs/Projects/$company/Amass
mv Amass* Threat_Labs/Projects/$company/Amass


##################
#                #
#     PyMeta     #
#                #
##################


echo "${CYAN} [+][+][+]  PyMeta ${CYAN}[+][+][+]"
echo " "

python3 $pymeta -d $domain > pymeta_results 2>/dev/null

mkdir Threat_Labs/Projects/$company/PyMeta
mv pymeta* Threat_Labs/Projects/$company/PyMeta


##################
#                #
#     Crt.sh     #
#                #
##################


echo "${CYAN} [+][+][+]  Crt.sh ${CYAN}[+][+][+]"
echo " "

mkdir Threat_Labs/Projects/$company/Crt
curl --retry 5 -s https://crt.sh/?q=%25.$domain | sort -u | grep $domain | cut -d '>' -f 2 | cut -d "<" -f 1 | sort -n | uniq -c  | sort -rn > Threat_Labs/Projects/$company/Crt/crt_results.out


##################
#                #
#   MX Records   #
#                #
##################


echo "${CYAN} [+][+][+]  MX Records with NSlookup ${CYAN}[+][+][+]"
echo " "
nslookup -type=mx $domain 1.1.1.1 > "./$domain-mx_records.out" 2>/dev/null

mkdir Threat_Labs/Projects/$company/MxRecords
mv *records.out Threat_Labs/Projects/$company/MxRecords


##################
#                #
#     Fierce     #
#                #
##################


echo "${CYAN} [+][+][+]  Fierce ${CYAN}[+][+][+]"
echo " "
mkdir Threat_Labs/Projects/$company/Fierce
fierce --domain $domain > "./Threat_Labs/Projects/$company/Fierce/$domain-fierce.out" 2>/dev/null


##################
#                #
#   Sublist3r    #
#                #
##################


sub=$(find / -name sublist3r.py | grep Tools/Sub)

echo "${CYAN} [+][+][+]  Sublist3r ${CYAN}[+][+][+]"
echo " "
echo "${CYAN} [+] Command is running and saving output to a file ${CYAN}[+]"
echo " "
python $sub -d $domain > ./$domain-sublist3r.out 2>/dev/null

mkdir Threat_Labs/Projects/$company/Sublist3r
mv *sublist3r.out Threat_Labs/Projects/$company/Sublist3r


##################
#                #
#     Whois      #
#                #
##################


echo "${CYAN} [+][+][+]  Whois ${CYAN}[+][+][+]"
echo " "
whois $domain > ./$domain-whois.out 2>/dev/null

mkdir Threat_Labs/Projects/$company/Whois
mv *whois.out Threat_Labs/Projects/$company/Whois


##################
#                #
#    DNSrecon    #
#                #
##################


echo " "
echo "${CYAN} [+][+][+]  DNSrecon ${CYAN}[+][+][+]"
echo " "
dnsrecon -d $domain  > dnsrecon_results 2>/dev/null

mkdir Threat_Labs/Projects/$company/DNSrecon
mv dnsrecon_* Threat_Labs/Projects/$company/DNSrecon


##################
#                #
#   Metagoofil   #
#                #
##################

echo "${CYAN} [+][+][+]  Metagoofil ${CYAN}[+][+][+]"

metagoofil -d $domain -t pdf,doc,xls,ppt,docx,xlsx,pptx,txt,bak -l 25 -e 15 -n 30 -o "$domain-meta"

mkdir Threat_Labs/Projects/$company/Metagoofil
mv *meta* Threat_Labs/Projects/$company/Metagoofil


##################
#                #
#    DNSenum     #
#                #
##################


if [ "$dnsenum" = 'B' ]; then
	# Basic Scan
	echo " "
	echo "${CYAN} [+][+][+]  DNSenum - Basic ${CYAN}[+][+][+]"
	echo " "
	dnsenum $domain  > dnsenum_basic_results 2>/dev/null
	
else
	echo " "
	echo "${CYAN} [+][+][+]  DNSenum - Advanced ${CYAN}[+][+][+]"
	echo " "
	dnsenum $domain -f /usr/share/wordlists/seclists/Discovery/DNS/subdomains-top1million-5000.txt > dnsenum_advanced_results 2>/dev/null
fi

mkdir Threat_Labs/Projects/$company/DNSenum
mv dnsenum_* Threat_Labs/Projects/$company/DNSenum
