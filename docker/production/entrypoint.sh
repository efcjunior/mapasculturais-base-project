#!/bin/sh
chown -R www-data:www-data /var/www/html/assets /var/www/html/files /var/www/var/private-files /var/www/var/saas-files /var/www/var/sessions /var/www/var/logs
chmod -R 775 /var/www/html/assets /var/www/html/files /var/www/var/private-files /var/www/var/saas-files /var/www/var/sessions /var/www/var/logs
exec "$@"
