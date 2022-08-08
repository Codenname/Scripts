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
echo "${BLUE} {+} Recon-NG"

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
echo " "
echo " 2. Make sure your are in a directory in which folders,subfolders, and docs can be save"
echo " "
echo " 3. If running advanced theHarvester scan, make sure you have your API keys updated (api-keys.yaml)"
echo " "
echo " 4. If running advanced DNSEnum, make sure you have the seclist wordlists in your /usr/share/wordlists"
echo " "
echo " 5. Recon-ng will run with a set of modules that do no require API Keys. For best results spend some time"
echo "    and put in the API keys. 
				(bing_api google_api shodan_api github_api builtwith_api twitter_api ipinfodb_api)"
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

apt-get install scrot -y

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
scrot -u -d 1 -F li2u.png
echo " "
echo "${RED} Screenshot was taken and saved"
echo " "
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
	$theHarvester -d "$domain" -b yahoo,bing,hackertarget > harvester_google_results 2>/dev/null
	
else
	# If you want to run an advanced scan, add your api keys to .yaml file in the running directory 
	# Otherwise this will not grab all the searches due to wrong api file being pulled
	#

	echo " "
	echo "${CYAN} [+][+][+]  theHarvester - All ${CYAN}[+][+][+]"
	$theHarvester -d "$domain" -b all > harvester_all_results 2>/dev/null
fi

head --lines 20 harvester_*
scrot -u -d 1 -F harvester.png
echo " "
echo "${RED} Screenshot was taken of the top 20 lines and saved. **Verify Screenshot**${NC}"
echo " "

mkdir Threat_Labs/Projects/$company/theHarvester
mv harvester_* Threat_Labs/Projects/$company/theHarvester
mv harvester* Threat_Labs/Projects/$company/theHarvester

##################
#                #
#     Amass      #
#                #
##################


echo "${CYAN} [+][+][+]  Amass ${CYAN}[+][+][+]"
echo " "

amass enum -d $domain -passive > amass_results 2>/dev/null

mkdir Threat_Labs/Projects/$company/Amass
mv amass* Threat_Labs/Projects/$company/Amass


##################
#                #
#     PyMeta     #
#                #
##################


echo "${CYAN} [+][+][+]  PyMeta ${CYAN}[+][+][+]"
echo " "

python3 $pymeta -d $domain > pymeta_results 2>/dev/null

head --lines 30 pymeta_*
scrot -u -d 1 -F pymeta.png
echo " "
echo "${RED} Screenshot was taken of the top 30 lines and saved. **Verify Screenshot**${NC}"
echo " "

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

head --lines 20 Threat_Labs/Projects/$company/Crt/crt_results.out
scrot -u -d 1 -F crt.png

echo " "
echo "${RED} Screenshot was taken of the top 20 lines and saved. **Verify Screenshot**${NC}"
echo " "

mv crt* Threat_Labs/Projects/$comapny/Crt


##################
#                #
#   MX Records   #
#                #
##################


echo "${CYAN} [+][+][+]  MX Records with NSlookup ${CYAN}[+][+][+]"
echo " "
nslookup -type=mx $domain > "./$domain-mx_records.out" 2>/dev/null

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

head --lines 30 *-sublist3r.out
scrot -u -d 1 -F sublist3r.png

echo " "
echo "${RED} Screenshot was taken of the top 30 lines and saved. **Verify Screenshot**${NC}"
echo " "

mkdir Threat_Labs/Projects/$company/Sublist3r
mv *sublist3r.out Threat_Labs/Projects/$company/Sublist3r
mv sublist3r.png Threat_Labs/Projects/$company/Sublist3r

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

head --lines 20 dnsrecon*
scrot -u -d 1 -F dnsrecon.png

echo " "
echo "${RED} Screenshot was taken of the top 20 lines and saved. **Verify Screenshot**${NC}"
echo " "

mkdir Threat_Labs/Projects/$company/DNSrecon
mv dnsrecon_* Threat_Labs/Projects/$company/DNSrecon
mv dnsrecon.png Threat_Labs/Projects/$company/DNSrecon


##################
#                #
#   Metagoofil   #
#                #
##################

echo "${CYAN} [+][+][+]  Metagoofil ${CYAN}[+][+][+]"
echo " "
metagoofil -d $domain -t pdf,doc,xls,ppt,docx,xlsx,pptx,txt,bak -l 25 -e 15 -n 30 -o "$domain-meta"

head --lines 20 *-meta
scrot -u -d 1 -F metagoofil.png

echo " "
echo "${RED} Screenshot was taken of the top 20 lines and saved. **Verify Screenshot**${NC}"
echo " "

mkdir Threat_Labs/Projects/$company/Metagoofil
mv *meta* Threat_Labs/Projects/$company/Metagoofil
mv metagoofil.png Threat_Labs/Projects/$company/Metagoofil

##################
#                #
#    Recon-ng    #
#                #
##################

echo "${CYAN} [+][+][+]  Recon-ng ${CYAN}[+][+][+]"
echo " "
sleep 2

stamp=$(date +"%m_%d_%Y")
path=$(pwd)

pip3 install PyPDF3

#create rc file with workspace.timestamp and start enumerating hosts
echo "spool start $domain$stamp.log" >> $domain$stamp.resource

echo "Domain:" $domain
echo "Company:" $company
echo "workspaces create $domain$stamp"


echo "workspaces load $domain$stamp" >> $domain$stamp.resource
echo "workspaces create $domain$stamp" >> $domain$stamp.resource
echo "workspaces load $domain$stamp" >> $domain$stamp.resource

###########################################################################

# Install Modules

echo "marketplace install recon/domains-contacts/metacrawler" >> $domain$stamp.resource
echo "marketplace install recon/domains-hosts/hackertarget" >> $domain$stamp.resource
echo "marketplace install recon/domains-hosts/netcraft" >> $domain$stamp.resource
echo "marketplace install recon/domains-hosts/bing_domain_web" >> $domain$stamp.resource
echo "marketplace install recon/companies-multi/whois_miner" >> $domain$stamp.resource
echo "marketplace install recon/domains-hosts/brute_hosts" >> $domain$stamp.resource
echo "marketplace install recon/domains-hosts/certificate_transparency" >> $domain$stamp.resource
echo "marketplace install recon/hosts-hosts/resolve" >> $domain$stamp.resource
echo "marketplace install recon/hosts-hosts/reverse_resolve" >> $domain$stamp.resource
echo "marketplace install recon/hosts-hosts/ssltools" >> $domain$stamp.resource
echo "marketplace install recon/domains-vulnerabilities/xssed" >> $domain$stamp.resource
echo "marketplace install recon/domains-vulnerabilities/ghdb" >> $domain$stamp.resource
echo "marketplace install recon/domains-contacts/pgp_search" >> $domain$stamp.resource
echo "marketplace install recon/domains-contacts/whois_pocs" >> $domain$stamp.resource
echo "marketplace install recon/domains-hosts/mx_spf_ip" >> $domain$stamp.resource
echo "marketplace install recon/domains-hosts/ssl_san" >> $domain$stamp.resource
echo "marketplace install reporting/csv" >> $domain$stamp.resource
echo "marketplace install reporting/html" >> $domain$stamp.resource
#echo "marketplace install recon/domains-domains/brute_suffix" >> $domain$stamp.resource

# If you have API Keys, uncomment these for better results.

#echo "marketplace install recon/domains-hosts/builtwith" >> $domain$stamp.resource
#echo "marketplace install recon/companies-multi/github_miner" >> $domain$stamp.resource
#echo "marketplace install recon/profiles-contacts/github_modules_users" >> $domain$stamp.resource
#echo "marketplace install recon/profiles-contacts/github_modules" >> $domain$stamp.resource
#echo "marketplace install recon/profiles-repositories/github_repos" >> $domain$stamp.resource
#echo "marketplace install recon/repositories-profiles/github_commits" >> $domain$stamp.resource
#echo "marketplace install recon/repositories-vulnerabilities/github_dorks" >> $domain$stamp.resource
#echo "marketplace install recon/hosts-hosts/bing_ip" >> $domain$stamp.resource
#echo "marketplace install recon/hosts-hosts/freegeoip" >> $domain$stamp.resource
#echo "marketplace install recon/companies-contacts/bing_linkedin_cache" >> $domain$stamp.resource
#echo "marketplace install recon/domains-vulnerabilities/punkspider" >> $domain$stamp.resource
#echo "marketplace install recon/domains-vulnerabilities/ghdb" >> $domain$stamp.resource


###########################################################################

# Running the Modules

echo "modules load recon/domains-contacts/whois_pocs" >> $domain$stamp.resource
echo "options set SOURCE $domain" >> $domain$stamp.resource
echo "run" >> $domain$stamp.resource

echo "modules load recon/domains-contacts/pgp_search" >> $domain$stamp.resource
echo "options set SOURCE $domain" >> $domain$stamp.resource
echo "run" >> $domain$stamp.resource

echo "modules load recon/domains-hosts/mx_spf_ip" >> $domain$stamp.resource
echo "options set SOURCE $domain" >> $domain$stamp.resource
echo "run" >> $domain$stamp.resource

echo "modules load recon/domains-hosts/ssl_san" >> $domain$stamp.resource
echo "options set SOURCE $domain" >> $domain$stamp.resource
echo "run" >> $domain$stamp.resource 

echo "modules load recon/companies-multi/whois_miner" >> $domain$stamp.resource
echo "options set SOURCE $company" >> $domain$stamp.resource
echo "run" >> $domain$stamp.resource

echo "modules load recon/domains-hosts/bing_domain_web" >> $domain$stamp.resource
echo "options set SOURCE $domain" >> $domain$stamp.resource
echo "run" >> $domain$stamp.resource

echo "modules load recon/domains-vulnerabilities/ghdb" >> $domain$stamp.resource
echo "options set SOURCE $domain" >> $domain$stamp.resource
echo "run" >> $domain$stamp.resource 

echo "modules load recon/domains-hosts/netcraft" >> $domain$stamp.resource
echo "options set SOURCE $domain" >> $domain$stamp.resource
echo "run" >> $domain$stamp.resource

echo "modules load recon/domains-hosts/hackertarget" >> $domain$stamp.resource
echo "options set SOURCE $domain" >> $domain$stamp.resource
echo "run" >> $domain$stamp.resource

echo "modules load recon/domains-contacts/metacrawler" >> $domain$stamp.resource
echo "options set SOURCE $domain" >> $domain$stamp.resource
echo "run" >> $domain$stamp.resource

echo "modules load recon/domains-hosts/brute_hosts" >> $domain$stamp.resource
echo "options set SOURCE $domain" >> $domain$stamp.resource
echo "run" >> $domain$stamp.resource

echo "modules load recon/domains-hosts/certificate_transparency" >> $domain$stamp.resource
echo "options set SOURCE $domain" >> $domain$stamp.resource
echo "run" >> $domain$stamp.resource

echo "modules load recon/hosts-hosts/resolve" >> $domain$stamp.resource
echo "run" >> $domain$stamp.resource

echo "modules load recon/hosts-hosts/reverse_resolve" >> $domain$stamp.resource
echo "run" >> $domain$stamp.resource

echo "modules load recon/hosts-hosts/ssltools" >> $domain$stamp.resource
echo "run" >> $domain$stamp.resource

echo "modules load recon/domains-vulnerabilities/xssed" >> $domain$stamp.resource
echo "options set SOURCE $domain" >> $domain$stamp.resource
echo "run" >> $domain$stamp.resource 


echo "modules load reporting/csv" >> $domain$stamp.resource
echo "options set FILENAME $path/$domain.csv" >> $domain$stamp.resource
echo "run" >> $domain$stamp.resource

#echo "modules load recon/domains-domains/brute_suffix" >> $domain$stamp.resource
#echo "options set SOURCE $company" >> $domain$stamp.resource
#echo "run" >> $domain$stamp.resource

# Reporting 

echo "modules load reporting/html" >> $domain$stamp.resource
echo "options set CREATOR Code" >> $domain$stamp.resource
echo "options set CUSTOMER $domain" >> $domain$stamp.resource
echo "options set FILENAME $path/$domain.html" >> $domain$stamp.resource
echo "run" >> $domain$stamp.resource
echo "exit" >> $domain$stamp.resource

###########################################################################
##### NEEDS API KEY #####


			### +++++ BING API KEY +++++ ###

#echo "modules load recon/domains-hosts/bing_domain_api" >> $domain$stamp.resource
#echo "options set SOURCE $domain" >> $domain$stamp.resource
#echo "run" >> $domain$stamp.resource

#echo "modules load recon/hosts-hosts/bing_ip" >> $domain$stamp.resource
#echo "run" >> $domain$stamp.resource

#echo "modules load recon/companies-contacts/bing_linkedin_cache" >> $domain$stamp.resource
#echo "options set SOURCE $domain" >> $domain$stamp.resource
#echo "run" >> $domain$stamp.resource

#echo "modules load recon/domains-hosts/builtwith" >> $domain$stamp.resource
#echo "options set SOURCE $domain" >> $domain$stamp.resource
#echo "run" >> $domain$stamp.resource


			### +++++ GOOGLE API KEY +++++ ###

#echo "modules load recon/domains-hosts/google_site_api" >> $domain$stamp.resource
#echo "options set SOURCE $domain" >> $domain$stamp.resource
#echo "run" >> $domain$stamp.resource


			### +++++ SHODAN API KEY +++++ ###

#echo "modules load recon/domains-hosts/shodan_hostname" >> $domain$stamp.resource
#echo "options set SOURCE $domain" >> $domain$stamp.resource
#echo "run" >> $domain$stamp.resource


			### +++++ IPINFODB API KEY +++++ ###

#echo "modules load recon/hosts-hosts/ipinfodb" >> $domain$stamp.resource
#echo "run" >> $domain$stamp.resource


			### +++++ GITHUB API KEY +++++ ###


#echo "modules load recon/companies-multi/github_miner" >> $domain$stamp.resource
#echo "options set SOURCE $company" >> $domain$stamp.resource
#echo "run" >> $domain$stamp.resource

#echo "modules load recon/profiles-contacts/github_modules_users" >> $domain$stamp.resource
#echo "run" >> $domain$stamp.resource

#echo "modules load recon/profiles-contacts/github_modules" >> $domain$stamp.resource
#echo "options set SOURCE $company" >> $domain$stamp.resource
#echo "run" >> $domain$stamp.resource

#echo "modules load recon/profiles-repositories/github_repos" >> $domain$stamp.resource
#echo "run" >> $domain$stamp.resource

#echo "modules load recon/repositories-profiles/github_commits" >> $domain$stamp.resource
#echo "run" >> $domain$stamp.resource

#echo "modules load recon/repositories-vulnerabilities/github_dorks" >> $domain$stamp.resource
#echo "run" >> $domain$stamp.resource


			### +++++ UNKNOWN API KEY +++++ ###


###########################################################################
#### Cant find module ####

#echo "modules load recon/hosts-hosts/freegeoip" >> $domain$stamp.resource
#echo "run" >> $domain$stamp.resource

#echo "modules load recon/domains-vulnerabilities/punkspider" >> $domain$stamp.resource
#echo "options set SOURCE $domain" >> $domain$stamp.resource
#echo "run" >> $domain$stamp.resource 

recon-ng -r $path/$domain$stamp.resource

mkdir Threat_Labs/Projects/$company/Recon-ng
mv $domain* Threat_Labs/Projects/$company/Recon-ng


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
