FROM hacklab/mapasculturais:latest

# Instale o Nginx
RUN apt-get update && apt-get install -y nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copie a configuração do Nginx
COPY docker/production/nginx.conf /etc/nginx/conf.d/default.conf

# Copie o arquivo .env para dentro do container
COPY .env /var/www/.env

# Carregar as variáveis de ambiente
RUN echo "source /var/www/.env" >> /etc/profile

# Copie temas e plugins para a aplicação
COPY themes /var/www/src/themes
COPY plugins /var/www/src/plugins

# Execute as instalações do projeto
WORKDIR /var/www/src
RUN pnpm install --recursive && pnpm run build 

# Configure o ambiente de trabalho
WORKDIR /var/www

# Copie as configurações específicas do projeto
COPY docker/common/config.d /var/www/config/common.d
COPY docker/production/config.d /var/www/config/config.d

# Crie os diretórios necessários e defina as permissões corretas
RUN mkdir -p /var/www/public/assets/js /var/www/public/assets/css /var/www/public/assets/img /var/www/public/assets/svg \
    && chown -R www-data:www-data /var/www/html /var/www/public/assets \
    && chmod -R 775 /var/www/html /var/www/public/assets

# Exponha as portas para o Nginx
EXPOSE 80
EXPOSE 443

# Defina o comando de inicialização para rodar Nginx e PHP-FPM juntos
CMD ["sh", "-c", "source /var/www/.env && service nginx start && php-fpm"]
