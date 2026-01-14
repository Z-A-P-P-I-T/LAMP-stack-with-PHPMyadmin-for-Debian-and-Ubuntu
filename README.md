# LAMP Stack + phpMyAdmin (Debian/Ubuntu)

A simple setup script that installs Apache, MariaDB, PHP, and phpMyAdmin on Debian/Ubuntu.

## What It Installs

- Apache (`apache2`)
- PHP (default distro version + common extensions)
- MariaDB (`mariadb-server`, `mariadb-client`)
- phpMyAdmin
- UFW rules for ports 22, 80, 443

## Requirements

- Debian/Ubuntu
- `sudo` access

## Quick Start

```bash
chmod +x LAMP-stack.sh
sudo ./LAMP-stack.sh
```

The script will:
1. Update packages (optionally upgrade + autoremove)
2. Configure UFW
3. Install Apache, PHP, MariaDB, phpMyAdmin
4. Create `/var/www/html/phpinfo.php`

## Notes

- phpMyAdmin installation prompts may appear (web server selection and database config).
- `phpinfo.php` is created for testing; remove it on production systems.

## Uninstall

```bash
chmod +x uninstall.sh
sudo ./uninstall.sh
```

The uninstall script will ask before removing UFW rules for ports 80/443.
If apt reports dependency errors, run:

```bash
sudo apt-get -f install
```

## Author

Created by Kimi Autto (github.com/Z-A-P-P-I-T)
