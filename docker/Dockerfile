FROM hacklab/mapasculturais:latest

COPY themes /var/www/src/themes
COPY plugins /var/www/src/plugins

WORKDIR /var/www/src
RUN pnpm install --recursive && pnpm run build 
WORKDIR /var/www

COPY docker/common/config.d /var/www/config/common.d
COPY docker/production/config.d /var/www/config/config.d

COPY docker/production/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh