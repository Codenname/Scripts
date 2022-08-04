#!/bin/bash


#whois lookup

echo 'Would you like to perform whois enumeartion? (Yes/No)  '
read whoisanswer

if [ "$whoisanswer" = 'Y' ]; then
   for host in $(cat IPs.txt); do
      echo "Creating the working directory for $(echo $host)"
      mkdir Data/$(echo $host)
      echo "Beginning whois enumeration on $(echo $host)"
      mkdir Data/$(echo $host)/whois
      whois $(echo $host) > Data/$(echo $host)/whois/whois.txt
      sleep 5
# This will create a running list from all in-scope IPs on 'OrgName' within the whois information
      cat Data/$(echo $host)/whois/whois.txt | echo "$host :  $(grep 'OrgName')" >> Data/IPs_whois.txt
      sleep 5
   done
else
   echo "Skipping whois enumeration"
fi