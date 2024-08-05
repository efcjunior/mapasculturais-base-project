Aqui está o guia do desenvolvedor atualizado sem a necessidade do Docker Compose:

---

## Guia do Desenvolvedor

### Pré-requisitos
1. **Docker**: Certifique-se de que o Docker está instalado e funcionando corretamente na sua máquina.
2. **Rede Docker**: Todos os containers devem rodar na mesma rede Docker para se comunicarem entre si.

### Passos de Configuração

#### 1. Criar a Rede Docker

Para garantir que todos os containers possam se comunicar, crie uma rede Docker:

```bash
docker network create mcnet
```

#### 2. Executar os Containers na Ordem Correta

##### 2.1. PostGIS (Banco de Dados)

Inicie o container do PostGIS, que serve como o banco de dados:

```bash
docker run --rm --name=postgis \
--network=mcnet \
-e POSTGRES_PASSWORD=mapas \
-e POSTGRES_USER=mapas \
-e POSTGRES_DB=mapas \
-v $(pwd)/docker-data/db-data:/var/lib/postgresql/data \
efcjunior/mapasculturais-postgis:mapasculturais-postgis
```

##### 2.2. Redis (Cache)

Inicie o container Redis:

```bash
docker run --rm --name=redis \
--network=mcnet \
redis:6
```

##### 2.3. Sessions (Gerenciamento de Sessões Redis)

Inicie o container responsável pelo gerenciamento de sessões:

```bash
docker run --rm --name=sessions \
--network=mcnet \
-v $(pwd)/docker-data/sessions:/data \
redis:6
```

##### 2.4. MapasCulturais (Aplicação Principal)

Inicie o container da aplicação Mapas Culturais:

```bash
docker run --rm --name=mapasculturais \
--network=mcnet \
-v $(pwd)/docker-data/assets:/var/www/html/assets \
-v $(pwd)/docker-data/public-files:/var/www/html/files \
-v $(pwd)/docker-data/private-files:/var/www/var/private-files \
-v $(pwd)/docker-data/saas-files:/var/www/var/saas-files \
-v $(pwd)/docker-data/sessions:/var/www/var/sessions \
-v $(pwd)/docker-data/logs:/var/www/var/logs \
-e REDIS_CACHE=redis \
-e SESSIONS_SAVE_PATH=tcp://sessions:6379 \
--env-file=$(pwd)/.env \
efcjunior/mapasculturais:prefeitura-triunfo php-fpm
```

##### 2.5. Nginx (Servidor Web)

Por fim, inicie o container do Nginx, que atuará como proxy reverso para a aplicação Mapas Culturais:

```bash
docker run --rm --name=nginx -p 80:80 \
--network=mcnet \
-v $(pwd)/nginx.conf:/etc/nginx/conf.d/default.conf \
-v $(pwd)/docker-data/assets:/var/www/html/assets \
-v $(pwd)/docker-data/public-files:/var/www/html/files \
-v /dev/null:/var/www/html/index.php \
nginx:1.27-alpine3.19
```

### Configurações Necessárias

#### 3. Configurar as Variáveis de Ambiente

- Copie o arquivo `.env_sample` para `.env` na raiz do projeto.
- Configure as variáveis de ambiente no arquivo `.env` conforme necessário.

#### 4. Configurar o Nginx

- O arquivo `nginx.conf` deve conter as configurações necessárias para o servidor Nginx, incluindo a configuração de proxy reverso e outros parâmetros, como limites de requisições e configurações de segurança.

---

Seguindo estes passos, você terá a aplicação Mapas Culturais rodando em containers Docker, sem a necessidade de Docker Compose.