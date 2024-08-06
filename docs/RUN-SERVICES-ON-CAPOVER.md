Aqui está um guia para preparar e subir o projeto Mapas Culturais no CapRover:

---

## Guia de Preparação e Deploy no CapRover

### 1. Clone do Projeto

Clone a branch específica do projeto:

```bash
git clone -b cliente-triunfo-v1 https://github.com/efcjunior/mapasculturais-base-project.git
```

### 2. Alteração dos Nomes dos Serviços e Volumes no Compose

Se você estiver fazendo a implantação usando a opção **TEMPLATE** do CapRover, siga as instruções abaixo:

- Abra o arquivo `docker-compose.yml` na raiz do projeto.
- Adicione o prefixo ao nome dos serviços e volumes conforme o nome do projeto no CapRover. Por exemplo:
  - Altere `nginx` para `treina-triunfo-mapa-nginx`.
  - Altere `mapasculturais` para `treina-triunfo-mapa-mapasculturais`.

**Exemplo:**

Antes:
```yaml
services:
  nginx:
    # configuração
  mapasculturais:
    # configuração
volumes:
  mapa-assets:
  mapa-db-data:
```

Depois:
```yaml
services:
  treina-triunfo-mapa-nginx:
    # configuração
  treina-triunfo-mapa-mapasculturais:
    # configuração
volumes:
  treina-triunfo-mapa-assets:
  treina-triunfo-mapa-db-data:
```

- Caso prefira usar outra opção que adiciona o prefixo automaticamente, remova os prefixos dos serviços e volumes para evitar duplicação.

### 3. Configuração das Variáveis de Ambiente

- Navegue até a pasta `docker` dentro da pasta raiz do projeto.
- Abra o arquivo correspondente às variáveis de ambiente e faça as seguintes alterações:
  - **`BASE_URL`**: Defina a URL base do serviço, que corresponde ao endereço do serviço Nginx implantado no CapRover.
  - **`DB_HOST`**: Defina o nome do host do banco de dados, que deve corresponder ao endereço do serviço DB no CapRover.

### 4. Configuração do Nginx

- Navegue até o arquivo `docker/nginx/nginx.conf`.
- Adicione o prefixo do serviço `mapasculturais` nos locais apropriados. Por exemplo:

Antes:
```
proxy_pass http://mapasculturais:9000;
```

Depois:
```
proxy_pass http://srv-captain--treina-triunfo-mapa-mapasculturais:9000;
```

### 5. Construção das Imagens Docker

Construa as imagens Docker do Nginx e do Mapas Culturais a partir da pasta raiz do projeto:

```bash
docker build -t efcjunior/mapasculturais:mapasculturais-nginx -f docker/nginx/Dockerfile .
docker build -t efcjunior/mapasculturais:prefeitura-triunfo -f docker/Dockerfile .
```

### 6. Publicação das Imagens no Docker Hub

Publique as imagens construídas no Docker Hub:

```bash
docker push efcjunior/mapasculturais:mapasculturais-nginx
docker push efcjunior/mapasculturais:prefeitura-triunfo
```

---

### Considerações Finais

Certifique-se de que todos os passos foram seguidos e que as variáveis de ambiente e URLs estão corretamente configuradas. O CapRover deve então ser capaz de implantar o projeto corretamente com base nas imagens Docker e configurações que você preparou.

Se precisar de assistência adicional, sinta-se à vontade para pedir!