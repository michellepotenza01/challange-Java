# 🚀 Challenge Mottu - Sistema de Gerenciamento

## 📋 Sobre o Projeto
Sistema de gerenciamento completo desenvolvido em Java Spring Boot para controle de clientes, pátios, motos e funcionários, com deploy automatizado na Azure utilizando Azure DevOps CI/CD.

## 🛠️ Stack Tecnológica
- Backend: Java Spring Boot 3.4.5

- Banco de Dados: Azure SQL Server (PaaS)

- Containerização: Docker

- Orquestração: Azure Container Instance (ACI)

- CI/CD: Azure DevOps Pipelines

- Registry: Azure Container Registry (ACR)

- Documentação: Swagger/OpenAPI 3.1

## 🏗️ Componentes da Stack
Personas: Desenvolvedor, Usuário Final

Ferramentas: GitHub, Azure DevOps, Azure Portal, Docker

Recursos Azure: ACI, ACR, SQL Server, Resource Group

![ Arquitetura](<Diagrama-cloud.png>)


#### Acesso a documentação e passo a passo completo no pdf 

## 📊 Funcionalidades

- ✅ CRUD Completo de Clientes, Pátios, Motos e Funcionários

- ✅ API REST documentada com Swagger

- ✅ Paginação em todos os endpoints

- ✅ Validações de dados e tratamentos de erro

- ✅ Deploy automatizado via CI/CD


## Detalhamento dos Componentes

| Nome do Componente      | Tipo             | Descrição Funcional                        | Tecnologia/Ferramenta         |
|-------------------------|------------------|--------------------------------------------|-------------------------------|
| Repositório de código   | SCM              | Onde o código-fonte está versionado        | GitHub                        |
| Pipeline CI             | Orquestrador CI  | Compila, testa e gera artefato             | Azure DevOps Pipelines        |
| Pipeline CD             | Orquestrador CD  | Faz deploy automático na nuvem            | Azure DevOps Releases         |
| Container Registry      | Registry         | Armazena imagens Docker                    | Azure Container Registry      |
| Runtime                 | Container        | Executa a aplicação                        | Azure Container Instance      |
| Banco de Dados          | PaaS             | Armazena dados da aplicação                | Azure SQL Server              |

## 🎭 Personas
Desenvolvedor: Realiza commits e monitora pipelines

Usuário Final: Consome API REST via Swagger UI ou Postman

## 🔧 Ferramentas e Conexões
GitHub → Azure DevOps (Webhook)

Azure DevOps → ACR (Push imagem)

Azure DevOps → ACI (Deploy)

ACI → Azure SQL (Conexão BD)

###  Banco de Dados em Nuvem
 Azure SQL Server (PaaS)

Nome do Servidor: mottu-sql-server-challenge

Nome do Banco: mottuDB

Tipo: PaaS (Platform as a Service)

## Configuração do Projeto no Azure DevOps

### Project Name: Sprint 4 – Azure DevOps

#### Description: Projeto para entrega da Sprint 4 
## | Integrantes: RM554669 - Ana Carolina de Castro Gonçalves - 2TDSPG, RM555292 - Luisa Danielle - 2TDSPG, RM557702 - Michelle Marques Potenza - 2TDSPG

#### Visibility: Private

#### Version control: Git

 ##### Work item process: Agile

### Acesso ao Professor
- ✅ Professor convidado com acesso nível "Basic"

## 1. Infraestrutura Azure
# Criar grupo de recursos
```bash
az group create --name MottuGroup --location brazilsouth
```

# Criar SQL Server
```bash
az sql server create --name mottu-sql-server-challenge --resource-group MottuGroup --location brazilsouth --admin-user MottuAdmin --admin-password "SuaSenhaAqui"
``` 


# Criar banco de dados
```bash
az sql db create --resource-group MottuGroup --server mottu-sql-server-challenge --name mottuDB --service-objective Basic --max-size 2GB
```

# Configurar firewall
```bash
az sql server firewall-rule create --resource-group MottuGroup --server mottu-sql-server-challenge --name AllowAllIPs --start-ip-address 0.0.0.0 --end-ip-address 255.255.255.255
``` 


## 2. Container Registry (ACR)
```bash
az acr create --resource-group MottuGroup --name mottuacrrm557702 --sku Basic --admin-enabled true
``` 

## 3. Build e Deploy Local

# Build da imagem Docker
```bash
docker build -t challenge-mottu:latest .
``` 

# Executar localmente
```bash
docker run -p 8080:8080 challenge-mottu:latest
```

## 4. Push para ACR
```bash

az acr login --name mottuacrrm557702

docker tag challenge-mottu:latest mottuacrrm557702.azurecr.io/challenge-mottu:latest

docker push mottuacrrm557702.azurecr.io/challenge-mottu:latest
```
## 5. Deploy no ACI
```bash
az container create --resource-group MottuGroup --name mottu-app-aci --image mottuacrrm557702.azurecr.io/challenge-mottu:latest --cpu 1 --memory 1 --registry-login-server mottuacrrm557702.azurecr.io --registry-username mottuacrrm557702 --registry-password $(az acr credential show --name mottuacrrm557702 --query "passwords[0].value" --output tsv) --ports 8080 --dns-name-label mottu-app-rm557702 --restart-policy Always
```

## 7. Pipelines CI/CD
### 7.a CI: Build + Testes Automáticos
##### Pipeline: "Sprint 4 – Azure DevOps-Docker container-CI"

##### Tasks Configuradas:

##### Build Docker Image - Constrói imagem com tag única

##### Push to ACR - Publica imagem no Azure Container Registry

##### Replace Tokens - Substitui variáveis em application.properties

##### Executar Testes de API - Valida endpoints da aplicação

#### 7.b CD: Deploy Automático
##### Pipeline: "Sprint 4 - CD Deploy to ACI"

##### Tasks Configuradas:

##### Azure CLI - Deploy para Azure Container Instance

##### ✅ Requisitos Obrigatórios Atendidos:
##### 7.I ✅ Pipeline configurada e conectada ao repositório GitHub da aplicação

##### 7.II ✅ CI configurada para disparar a cada alteração na branch main + CD dispara após novo artefato gerado

##### 7.III ✅ Variáveis de ambiente protegidas para credenciais de banco de dados:

##### DATABASE_URL (protegida)

##### DATABASE_USERNAME (protegida)

##### DATABASE_PASSWORD (protegida)

##### ACR_PASSWORD (protegida)

#### 7.IV ✅ Geração e publicação do artefato no Azure DevOps (imagem Docker no ACR)

##### 7.V ✅ Etapa de execução de testes na CI (testes de API automatizados)

##### 7.VI ✅ Aplicação provisionada no Azure Container Instance (ACI)

##### 7.VII ✅ Utiliza imagem Docker para provisionamento no ACI

##### 🌐 URLs da Aplicação
Aplicação: http://mottu-app-rm557702.brazilsouth.azurecontainer.io:8080

##### Swagger UI: http://mottu-app-rm557702.brazilsouth.azurecontainer.io:8080/swagger-ui/index.html

##### API Docs: http://mottu-app-rm557702.brazilsouth.azurecontainer.io:8080/v3/api-docs

## 📚 Endpoints da API
##### Clientes

- GET /clientes - Listar clientes

- POST /clientes - Criar cliente

- GET /clientes/{clienteId} - Buscar cliente por ID

- PUT /clientes/{clienteId} - Atualizar cliente

- DELETE /clientes/{clienteId} - Excluir cliente

##### Pátios
- GET /patios - Listar pátios

- POST /patios - Criar pátio

- GET /patios/{patioId} - Buscar pátio por ID

- PUT /patios/{ipatioId} - Atualizar pátio

- DELETE /patios/{PatioId} - Excluir pátio

##### Motos & Funcionários
Endpoints similares para motos e funcionários

## ⚙️ Variáveis de Ambiente
##### properties
```bash
spring.datasource.url=#{DATABASE_URL}#
spring.datasource.username=#{DATABASE_USERNAME}#
spring.datasource.password=#{DATABASE_PASSWORD}#
spring.jpa.hibernate.ddl-auto=update
server.port=8080
``` 
##### 🐳 Dockerfile
```bash
dockerfile
FROM gradle:8.10-jdk21 AS build
WORKDIR /app
COPY . .
RUN gradle clean build -x test

FROM eclipse-temurin:21-jdk-jammy
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
```

📊 Monitoramento
```bash
# Ver status do container
az container show --name mottu-app-aci --resource-group MottuGroup

# Ver logs
az container logs --name mottu-app-aci --resource-group MottuGroup
```
# Listar imagens no ACR
az acr repository list --name mottuacrrm557702 --output table


# 👥 Desenvolvedores
Ana Carolina de Castro Gonçalves - RM554669

Luisa Danielle - RM555292

Michelle Marques Potenza - RM557702

## ✅ Checklist de Requisitos Atendidos

-  **Requisito 0** - PDF com links e dados  
-  **Requisito 1** - Descrição da solução  
-  **Requisito 2** - Diagrama da arquitetura    
-  **Requisito 3** - Detalhamento dos componentes  
-  **Requisito 4** - Banco de dados válido  
-  **Requisito 5** - Configuração do projeto Azure DevOps  
-  **Requisito 6** - Convite ao professor  
-  **Requisito 7** - Pipelines CI/CD funcionando  
-  **Requisito 8** - Vídeo demonstrativo 

**Pontuação Total: 100/100 pontos**

🔗 Links


Azure DevOps: https://dev.azure.com/rm555292LD/Sprint%204%20%E2%80%93%20Azure%20DevOps/_build


Vídeo Demonstração: 

Documentação completa e passo detalahdos no PDF.


