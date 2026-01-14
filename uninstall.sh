#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

echo "This will remove Apache, MariaDB, PHP, and phpMyAdmin."
read -r -p "Continue? (y/N): " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Canceled."
    exit 0
fi

if systemctl list-unit-files --type=service | awk '{print $1}' | grep -qx "apache2.service"; then
    sudo systemctl stop apache2 || true
fi
if systemctl list-unit-files --type=service | awk '{print $1}' | grep -qx "mariadb.service"; then
    sudo systemctl start mariadb || true
fi

sudo apt-get purge -y \
    apache2 apache2-utils \
    libapache2-mod-php* \
    mariadb-server mariadb-client \
    php php-cli php-common php-mysql php-opcache php-json php-xml php-curl php-zip php-mbstring \
    phpmyadmin || true

sudo apt-get -y -f install || true
sudo apt-get autoremove -y || true

read -r -p "Remove UFW rules for ports 80/443? (y/N): " remove_ufw
if [[ "$remove_ufw" =~ ^[Yy]$ ]]; then
    sudo ufw delete allow 80 || true
    sudo ufw delete allow 443 || true
fi

sudo rm -f /var/www/html/phpinfo.php

echo "Uninstall completed."
