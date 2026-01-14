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
Author: 	rock-dotcom
Creation Date:  21/3-21
Description: 	Script that will install a Lampstack server 
		with phpmyadmin for Ubuntu and Debian Distros 
"

echo "
                                ''~``
                               ( o o )
       +------------------.oooO--(_)--Oooo.------------------+
       |     This Script will Install a LAMP Stack Server    |       
       |                  On Ubuntu 20.04                    |
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
       |                    Ubuntu 20.04                     |
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
       |                    Ubuntu 20.04                     |
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
       |                    Ubuntu 20.04                     |
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
       |                    Ubuntu 20.04                     |
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
       |                    Ubuntu 20.04                     |
       |                    .oooO                            |
       |                    (   )   Oooo.                    |
       +---------------------\ (----(   )--------------------+
                              \_)    ) /
                                    (_/
"
sleep 2
sudo systemctl stop apache2
sleep 4
sudo apt install -y apache2
 
#sudo xdg-open http://localhost/
 
sleep 2
clear
 
echo "
                                ''~``
                               ( o o )
       +------------------.oooO--(_)--Oooo.------------------+
       |           Installing and testing PHP 7.4            |
       |                    Ubuntu 20.04                     |
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
       |                    Ubuntu 20.04                     |
       |                    .oooO                            |
       |                    (   )   Oooo.                    |
       +---------------------\ (----(   )--------------------+
                              \_)    ) /
                                    (_/
"
php --version
echo '<?php phpinfo(); ?>' | sudo tee /var/www/html/phpinfo.php > /dev/null
 
sleep 2
clear
 
echo "
                                ''~``
                               ( o o )
       +------------------.oooO--(_)--Oooo.------------------+
       |           Restarting Apache Please Wait.            |       
       |                    Ubuntu 20.04                     |
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
       |                    Ubuntu 20.04                     |
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
       |                    Ubuntu 20.04                     |
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
       |  Please fallow the instructions and set a Password  |       
       |                    Ubuntu 20.04                     |
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
       |         Installing and Verifiying phpMyAdmin        |      
       |                    Ubuntu 20.04                     |
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
       |                   Congratulation!                   |
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
