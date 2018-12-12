#!/bin/bash
while true; do
    read -p "Create a backup of the current files? (Y/n): " yn
    case $yn in
        [Yy]* ) 
            sudo cp -f /var/www/html/admin/style/vendor/skin-blue.min.css /var/www/html/admin/style/vendor/skin-blue.min.bkp.css
            echo "Backup completed!"
			break ;;
        [Nn]* ) break;;
        * ) echo "Please answer Yes (y) or No (n).";;
    esac
done
while true; do
    read -p "Install Dark Theme now? (Y/n): " yn
    case $yn in
        [Yy]* ) 
	    sudo git clone https://github.com/jacobbates/pi-hole-midnight.git temp
            sudo rm -f /var/www/html/admin/style/vendor/skin-blue.min.css
            sudo cp temp/skin-blue.min.css /var/www/html/admin/style/vendor/skin-blue.min.css
	    sudo rm -rf temp/
			break;;
        [Nn]* ) break;;
        * ) echo "Please answer Yes (y) or No (n).";;
    esac
done
echo "All done!"