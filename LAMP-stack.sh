#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail
clear
echo "

██╗      █████╗ ███╗   ███╗██████╗     ███████╗████████╗ █████╗  ██████╗██╗  ██╗
██║     ██╔══██╗████╗ ████║██╔══██╗    ██╔════╝╚══██╔══╝██╔══██╗██╔════╝██║ ██╔╝
██║     ███████║██╔████╔██║██████╔╝    ███████╗   ██║   ███████║██║     █████╔╝ 
██║     ██╔══██║██║╚██╔╝██║██╔═══╝     ╚════██║   ██║   ██╔══██║██║     ██╔═██╗ 
███████╗██║  ██║██║ ╚═╝ ██║██║         ███████║   ██║   ██║  ██║╚██████╗██║  ██╗
╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝         ╚══════╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝
                                                                                
"
sleep 0.5
echo "                                                        
Author: 	Kimi Autto (github.com/Z-A-P-P-I-T)
Creation Date:  21/3-21
Description: 	Script that will install a LAMP stack server 
		with phpMyAdmin for Debian and Ubuntu distros 
"

echo "
                                ''~``
                               ( o o )
       +------------------.oooO--(_)--Oooo.------------------+
       |     This Script will Install a LAMP Stack Server    |       
       |                 On Debian/Ubuntu                    |
       |                    .oooO                            |
       |                    (   )   Oooo.                    |
       +---------------------\ (----(   )--------------------+
                              \_)    ) /
                                    (_/
"
sleep 2
 
clear
echo " 
                                ''~``
                               ( o o )
       +------------------.oooO--(_)--Oooo.------------------+
       |      Lest start By Running Update and Upgrade       |
       |            Please provide your Password             |       
       |                 Debian/Ubuntu                       |
       |                    .oooO                            |
       |                    (   )   Oooo.                    |
       +---------------------\ (----(   )--------------------+
                              \_)    ) /
                                    (_/
"
sudo apt update
read -r -p "Run full system upgrade? (y/N): " do_upgrade
if [[ "$do_upgrade" =~ ^[Yy]$ ]]; then
    sudo apt upgrade -y
fi
read -r -p "Remove unneeded packages (autoremove)? (y/N): " do_autoremove
if [[ "$do_autoremove" =~ ^[Yy]$ ]]; then
    sudo apt autoremove -y
fi
sleep 2
clear
 
echo "
                                ''~``
                               ( o o )
       +------------------.oooO--(_)--Oooo.------------------+
       |              Update and Upgrade Done                |
       |                 Debian/Ubuntu                       |
       |                    .oooO                            |
       |                    (   )   Oooo.                    |
       +---------------------\ (----(   )--------------------+
                              \_)    ) /
                                    (_/
"
sleep 2
clear
echo "
                                ''~``
                               ( o o )
       +------------------.oooO--(_)--Oooo.------------------+
       |     Now we open ports 22 (for SSH), 80 and 443      |
       |          and enable Ubuntu Firewall (ufw)           |       
       |                 Debian/Ubuntu                       |
       |                    .oooO                            |
       |                    (   )   Oooo.                    |
       +---------------------\ (----(   )--------------------+
                              \_)    ) /
                                    (_/
"                   
 
sudo ufw allow ssh
sudo ufw allow 80
sudo ufw allow 443
sudo ufw --force enable
 
sleep 2
clear
 
echo "
                                ''~``
                               ( o o )
       +------------------.oooO--(_)--Oooo.------------------+
       |   Ports have been opened and the Firewall enabled   |
       |                 Debian/Ubuntu                       |
       |                    .oooO                            |
       |                    (   )   Oooo.                    |
       +---------------------\ (----(   )--------------------+
                              \_)    ) /
                                    (_/
"
sleep 2
clear
 
echo "
                                ''~``
                               ( o o )
       +------------------.oooO--(_)--Oooo.------------------+
       |       Installing and Testing Apache Webserver       |
       |                 Debian/Ubuntu                       |
       |                    .oooO                            |
       |                    (   )   Oooo.                    |
       +---------------------\ (----(   )--------------------+
                              \_)    ) /
                                    (_/
"
sleep 2
if systemctl list-unit-files --type=service | awk '{print $1}' | grep -qx "apache2.service"; then
    sudo systemctl stop apache2
else
    echo "Apache service not loaded yet; skipping stop."
fi
sleep 4
sudo apt install -y apache2
 
#sudo xdg-open http://localhost/
 
sleep 2
clear
 
echo "
                                ''~``
                               ( o o )
       +------------------.oooO--(_)--Oooo.------------------+
       |           Installing and testing PHP                |
       |                 Debian/Ubuntu                       |
       |                    .oooO                            |
       |                    (   )   Oooo.                    |
       +---------------------\ (----(   )--------------------+
                              \_)    ) /
                                    (_/
"
sleep 2
sudo apt install -y php php-mysql php-cli php-json php-common php-opcache libapache2-mod-php

sleep 2
clear
echo "
                                ''~``
                               ( o o )
       +------------------.oooO--(_)--Oooo.------------------+
       |           Checking Installed PHP Version.           |
       |                 Debian/Ubuntu                       |
       |                    .oooO                            |
       |                    (   )   Oooo.                    |
       +---------------------\ (----(   )--------------------+
                              \_)    ) /
                                    (_/
"
php --version
echo '<?php phpinfo(); ?>' | sudo tee /var/www/html/phpinfo.php > /dev/null
sudo chmod 644 /var/www/html/phpinfo.php

# Ensure Apache loads PHP module
php_version=$(php -r 'echo PHP_MAJOR_VERSION . "." . PHP_MINOR_VERSION;' 2>/dev/null || echo "")
if [[ -n "$php_version" ]]; then
    php_module="php${php_version}"
    if [[ -f "/etc/apache2/mods-available/${php_module}.load" ]]; then
        sudo a2enmod "$php_module" >/dev/null 2>&1 || true
    else
        echo "PHP Apache module not found (${php_module})."
        echo "If phpinfo.php fails, install libapache2-mod-php and re-run."
    fi
fi
sudo a2dismod mpm_event >/dev/null 2>&1 || true
sudo a2enmod mpm_prefork >/dev/null 2>&1 || true

sleep 2
clear
 
echo "
                                ''~``
                               ( o o )
       +------------------.oooO--(_)--Oooo.------------------+
       |           Restarting Apache Please Wait.            |       
       |                 Debian/Ubuntu                       |
       |                    .oooO                            |
       |                    (   )   Oooo.                    |
       +---------------------\ (----(   )--------------------+
                              \_)    ) /
                                    (_/
"
sudo systemctl restart apache2
sleep 5
 
clear
#echo "
#                                ''~``
#                               ( o o )
#       +------------------.oooO--(_)--Oooo.------------------+
#       |                       Ohh Noo!                      |
#       | Please run the LAMP Stack Installation-script again.|
#       |             Installer will now exit.                |
#       |                    Ubuntu 20.04                     |
#       |                    .oooO                            |
#       |                    (   )   Oooo.                    |
#       +---------------------\ (----(   )--------------------+
#                              \_)    ) /
#                                    (_/
#
#"
 
echo "
                                ''~``
                               ( o o )
       +------------------.oooO--(_)--Oooo.------------------+
       |                 Installing MariaDB                  |       
       |                 Debian/Ubuntu                       |
       |                    .oooO                            |
       |                    (   )   Oooo.                    |
       +---------------------\ (----(   )--------------------+
                              \_)    ) /
                                    (_/
"
sleep 2
 
sudo apt install -y mariadb-server mariadb-client
sleep 2
clear
echo "
                                ''~``
                               ( o o )
       +------------------.oooO--(_)--Oooo.------------------+
       |         Checking Installed MariaDB Version.         |       
       |                 Debian/Ubuntu                       |
       |                    .oooO                            |
       |                    (   )   Oooo.                    |
       +---------------------\ (----(   )--------------------+
                              \_)    ) /
                                    (_/
"
 
dpkg -l | grep mariadb-server
sleep 3
clear
 
echo "
                                ''~``
                               ( o o )
       +------------------.oooO--(_)--Oooo.------------------+
       |             Securing MariaDB Installation           |
       |  Please follow the instructions and set a Password  |       
       |                 Debian/Ubuntu                       |
       |                    .oooO                            |
       |                    (   )   Oooo.                    |
       +---------------------\ (----(   )--------------------+
                              \_)    ) /
                                    (_/
"
 
sudo mysql_secure_installation
sleep 2
clear
 
echo "
                                ''~``
                               ( o o )
       +------------------.oooO--(_)--Oooo.------------------+
       |         Installing and Verifying phpMyAdmin         |      
       |                 Debian/Ubuntu                       |
       |                    .oooO                            |
       |                    (   )   Oooo.                    |
       +---------------------\ (----(   )--------------------+
                              \_)    ) /
                                    (_/
"
 
sudo apt install -y phpmyadmin
sleep 2
clear
 
echo "
                                ''~``
                               ( o o )
       +------------------.oooO--(_)--Oooo.------------------+
       |                   Congratulations!                  |
       |   You should now have a LAMP stack webserver with   |
       |  Linux, Apache, MariaDB and PHP set up and running! | 
       |  You are now ready to start building your website.  |
       |                    Ubuntu 20.04                     |
       |                    .oooO                            |
       |                    (   )   Oooo.                    |
       +---------------------\ (----(   )--------------------+
                              \_)    ) /
                                    (_/
"
 
sleep 5
clear
 
 
echo "
                                ''~``
                               ( o o )
       +------------------.oooO--(_)--Oooo.------------------+
       |                                                     |
       |       * Test That Your Apache is Working:           | 
       |         http://localhost/                           |
       |                                                     |
       |           * Test That Your PHP is Working:          |
       |             http://localhost/phpinfo.php            |
       |                                                     |
       |               Enjoy N Have A GoodDay                |
       |                    .oooO                            |
       |                    (   )   Oooo.                    |
       +---------------------\ (----(   )--------------------+
                              \_)    ) /
                                    (_/
    "
sleep 3
