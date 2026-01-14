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

sudo systemctl stop apache2 || true
sudo systemctl stop mariadb || true

sudo apt purge -y apache2* mariadb-server mariadb-client php* phpmyadmin
sudo apt autoremove -y

sudo ufw delete allow 80 || true
sudo ufw delete allow 443 || true

sudo rm -f /var/www/html/phpinfo.php

echo "Uninstall completed."
