#!/bin/bash

command -v pihole >/dev/null 2>&1 || { whiptail --title "Install Failed" --msgbox  "No pihole install found. Aborting install"  8 78 >&2; exit;}

#if (( $EUID != 0 )); then
#    echo "Please run with sudo "
#    exit
#fi

whiptail --title "Pihole Speedtest Mod" --msgbox "Pihole Speedtest Mod updater." 8 78


if php -v | grep 'PHP 7' > /dev/null ; then 

	whiptail --title "Pihole Speedtest Mod" --msgbox "PHP 7.x found. Installing php7.0-sqlite " 8 78
	sudo apt install php7.0-sqlite -y
else
	whiptail --title "Pihole Speedtest Mod" --msgbox "PHP 5.x found. Installing php5-sqlite" 8 78
	sudo apt install php5-sqlite -y
fi

whiptail --title "Pihole Speedtest Mod" --msgbox "Reverting to official pi-hole" 8 78

whiptail --title "Pihole Speedtest Mod" --msgbox "Reverting admin" 8 78

cd /var/www/html/

sudo rm -rf admin

sudo git clone https://github.com/pi-hole/AdminLTE admin

whiptail --title "Pihole Speedtest Mod" --msgbox "Reverting pi-hole webpage" 8 78

cd /opt/pihole/

sudo rm webpage.sh

sudo wget https://github.com/pi-hole/pi-hole/raw/master/advanced/Scripts/webpage.sh

sudo chmod +x webpage.sh

whiptail --title "Pihole Speedtest Mod" --msgbox "Update Pihole" 8 78

sudo pihole -up

whiptail --title "Pihole Speedtest Mod" --msgbox "Get latest package from github" 8 78

cd /var/www/html

sudo rm -rf pihole_admin/admin

sudo mv admin pihole_admin

sudo git clone https://github.com/arevindh/AdminLTE admin

whiptail --title "Pihole Speedtest Mod" --msgbox "Updating webpage.sh" 8 78

cd /opt/pihole/

sudo mv webpage.sh webpage.sh.org

sudo wget https://github.com/arevindh/pi-hole/raw/master/advanced/Scripts/webpage.sh

sudo chmod +x webpage.sh

whiptail --title "Pihole Speedtest Mod" --msgbox "Update version info" 8 78

sudo pihole updatechecker local

whiptail --title "Pihole Speedtest Mod" --msgbox "Update complete" 8 78
