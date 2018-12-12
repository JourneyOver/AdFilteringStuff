#!/bin/bash
# This script will download and add domains from the repo and https://v.firebog.net/hosts/lists.php to the adlists.list file.
# Project homepage: https://github.com/JourneyOver/pihole
# Created by JourneyOver
#================================================================================
TICK="[\e[32m ✔ \e[0m]"


echo -e " \e[1m This script will download and add domains from the repo and https://v.firebog.net/hosts/lists.php to the adlists.list file. \e[0m"
sleep 1
echo -e "\n"

if [ "$(id -u)" != "0" ] ; then
	echo "This script requires root permissions. Please run this as root!"
	exit 2
fi

if ! (which gawk > /dev/null); then
  echo -e " [...] \e[32m Installing gawk... \e[0m"
  if (which apt-get > /dev/null); then
       apt-get install gawk -qq > /dev/null
  elif (which pacman > /dev/null); then
       pacman -Sqy gawk > /dev/null
  elif (which dnf > /dev/null); then
       dnf install gawk > /dev/null
  fi
  wait
  echo -e " ${TICK} \e[32m Finished \e[0m"
fi

curl -sS https://raw.githubusercontent.com/JourneyOver/pihole/master/lists-filters/adlists.list | sudo tee -a /etc/pihole/adlists.list >/dev/null
echo -e " ${TICK} \e[32m Adding JourneyOvers domains to adlists... \e[0m"
wait
curl -sS https://v.firebog.net/hosts/lists.php?type=tick | sudo tee -a /etc/pihole/adlists.list >/dev/null
echo -e " ${TICK} \e[32m Adding Wally3ks domains to adlists... \e[0m"
sleep 0.5
echo -e " ${TICK} \e[32m Removing duplicates... \e[0m"
sudo gawk -i inplace '!a[$0]++' /etc/pihole/adlists.list
wait
echo -e " [...] \e[32m Pi-hole gravity rebuilding lists. This may take a while... \e[0m"
pihole -g > /dev/null
wait
echo -e " ${TICK} \e[32m Pi-hole's gravity updated \e[0m"
echo -e " ${TICK} \e[32m Done! \e[0m"


echo -e " \e[1m  Star me on GitHub, https://github.com/JourneyOver/pihole \e[0m"
echo -e " \e[1m  Happy AdBlocking :)\e[0m"
echo -e "\n\n"
