# Use a imagem oficial do Nginx como base
FROM nginx:1.24

# Copie o arquivo de configuração personalizado do Nginx para o container
COPY docker/nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Crie os diretórios necessários e defina as permissões corretas
RUN mkdir -p /var/www/html/files /var/www/html/assets \
    && chown -R www-data:www-data /var/www/html/files /var/www/html/assets \
    && chmod -R 755 /var/www/html/files /var/www/html/assets

# Exponha a porta 80 para servir a aplicação
EXPOSE 8080

# Comando padrão para iniciar o Nginx
CMD ["nginx", "-g", "daemon off;"]
