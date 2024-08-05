#!/bin/bash

# Crie os diretórios necessários e defina as permissões corretas
mkdir -p /var/www/public/assets/js /var/www/public/assets/css /var/www/public/assets/img /var/www/public/assets/svg /var/www/var/sessions
chown -R www-data:www-data /var/www/html /var/www/public/assets /var/www/var/sessions
chmod -R 755 /var/www/html /var/www/public/assets /var/www/var/sessions

# Inicie o PHP-FPM em segundo plano
php-fpm

# Inicie o Nginx
#nginx -g "daemon off;"