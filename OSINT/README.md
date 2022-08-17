######

Instructions on how to run OSINT Script


######

++++ YOU MUST DO THIS ++++ 

1. Install on your system, theHarvester, GoWitness, PyMeta, Metagoofil, and Sublist3r. Also install all dependencies needed.

2. Change the tool variables (under section 'Tool Paths') so each tool will use your local paths.

3. LinkedIn2Username requires you to be previously logged in and will require your password upon start. Main reason this runs first. 

4. If looking to run the advanced 'theHarvester' scan, ensure that the .yaml file in your local 'theHarvester' directory has your API keys.

5. Recon-ng will use the modules that do not require API Keys. The ones that currently do are commented out so no errors get thrown. For best results, take some time and go get/enter the required API Keys. 

      (bing_api google_api shodan_api github_api builtwith_api twitter_api ipinfodb_api)
 
6. Ensure to have a 'scope.txt' file located within 'Projects/$comapny' directory. If you do not, GoWitness will not run. 

7. Where ever you start this script will be the top level directory. Sub folders and files will be created at this location

8. If looking to run a more advanced scan with 'DNSenum' ensure the 'subdomains-top1million-5000.txt' (from seclist) is located in the following directory: '/usr/share/wordlists/seclists/Discovery/DNS/'. Otherwise change the wordlist file within the script to the directory of your chosing. 

9. DNSenum will take a pretty good amount of time to complete. Just FYI

10. All output files will be stored in the 'Projects/$company' directory.  

11. Screenshots will only work on active window. If you click a different window, the scrot tool will take a picture of that and not the script running.
      Always verify the screenshots!!!


######


   ~Codenname
