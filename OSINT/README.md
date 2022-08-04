######

Instructions on how to run OSINT Script


######

1. As the script has the capability to install the required tools, it is recommended to change the tool variables (under section 'Tool Paths') so each tool will use those paths. The prime example here is 'theHarvester' API keys. Using the script installed version will not have your API keys configured. 

2. LinkedIn2Username requires you to be previously logged in and will require your password upon start. Main reason this runs first. 

3. Whereever you start this script will be the top level directory. This means sub folders and files will be created

4. If looking to run a more advanced scan with 'DNSenum' ensure the 'subdomains-top1million-5000.txt' (from seclist) is located in the following directory: '/usr/share/wordlists/seclists/Discovery/DNS/'. Otherwise change the wordlist file within the script to the directory of your chosing. 

5. DNSenum will take a pretty good amount of time to complete. Just FYI


######
