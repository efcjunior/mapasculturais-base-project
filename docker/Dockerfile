FROM hacklab/mapasculturais:latest

# Defina variáveis de ambiente (opcional, dependendo do seu código PHP)
#ENV BASE_URL=http://localhost:8080/

ENV APP_MODE=production
ENV LOG_LEVEL=DEBUG
ENV LOG_ENABLED=true

ENV CEP_TOKEN=

ENV MAILER_TRANSPORT=
ENV MAILER_FROM=

# Usado para redirecionar todos os e-mails da plataforma para um email fixo, 
# evitand envio de emails para os usuários
ENV MAILER_ALWAYSTO=

ENV DB_HOST=treina-triunfo-mapa-db
ENV DB_NAME=mapas
ENV DB_USER=mapas
ENV DB_PASS=mapas
ENV DB_VERSION=14

# as chaves abaixo são de desenvolvimento, precisam ser substituidas em ambiente de produção
ENV GOOGLE_RECAPTCHA_SITEKEY=6LeIxAcTAAAAAJcZVRqyHh71UMIEGNQ_MXjiZKhI
ENV GOOGLE_RECAPTCHA_SECRET=6LeIxAcTAAAAAGG-vFI1TnRWxMZNFuojJ4WifJWe

ENV AUTH_GOOGLE_CLIENT_ID=
ENV AUTH_GOOGLE_CLIENT_SECRET=
ENV AUTH_GOOGLE_SCOPE=
ENV AUTH_GOOGLE_REDIRECT_ID=

ENV PENDING_PCACHE_RECREATION_INTERVAL=1
ENV JOBS_INTERVAL=1

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

# Copie o script de entrada
COPY docker/production/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Use o script de entrada como ponto de entrada do container
CMD ["/entrypoint.sh"]
