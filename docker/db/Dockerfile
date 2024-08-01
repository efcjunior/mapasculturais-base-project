# Use a imagem base do PostGIS
FROM postgis/postgis:14-master

# Copie os scripts de inicialização para dentro do contêiner
# Estes scripts serão executados quando o contêiner for iniciado pela primeira vez
COPY ./*.sql /docker-entrypoint-initdb.d/

# Defina as variáveis de ambiente para o banco de dados
ENV POSTGRES_DB=mapas
ENV POSTGRES_USER=mapas
ENV POSTGRES_PASSWORD=mapas

# Exponha a porta padrão do PostgreSQL
EXPOSE 5432

# O CMD padrão é especificado pelo contêiner base do PostGIS