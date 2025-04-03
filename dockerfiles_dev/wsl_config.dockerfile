FROM ubuntu:latest

# Atualiza os pacotes
RUN sudo apt update && apt upgrade -y

# Definir variáveis do ambiente para evitar interatividade durante a instalação
ENV DEBIAN_FRONTEND=noninteractive

# Instala dependências
RUN apt install -y && \
    openjdk-21-jdk && \
    nodejs && \
    nginx && \
    git && \
    curl && \
    && apt clean

#Instalação do Nginx
# Atualizar pacotes e instalar dependências
RUN apt update && apt upgrade -y && \
    apt install -y wget gnupg2 lsb-release software-properties-common

# Adicionar repositório oficial do NGINX
RUN echo "deb http://nginx.org/packages/ubuntu $(lsb_release -cs) nginx" > /etc/apt/sources.list.d/nginx.list && \
    wget -qO - https://nginx.org/keys/nginx_signing.key | apt-key add -

# Atualizar pacotes novamente e instalar NGINX 1.27.0
RUN apt update && apt install -y nginx=1.27.0*

# Instalação do PostgreSQL
# Atualizar pacotes e instalar dependências
RUN apt update && apt upgrade -y && \
    apt install -y wget gnupg2 lsb-release software-properties-common

# Adicionar repositório oficial do PostgreSQL
RUN echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    wget -qO - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

# Atualizar pacotes novamente e instalar PostgreSQL 17 e postgresql-contrib
RUN apt update && apt install -y postgresql-17 postgresql-contrib

# Definir diretório de trabalho do PostgreSQL
USER postgres
WORKDIR /var/lib/postgresql

# Instala o TypeScript globalmente
RUN npm install -D typescript

# Instala o Vite globalmente
RUN npm i vite

# Instala o Bootstrap
RUN sudo apt install -y install  "git clone https://github.com/twbs/bootstrap.git" && \
    npm install bootstrap@v5.3.3

# Define variáveis de ambiente
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
ENV PATH="${JAVA_HOME}/bin:${PATH}"



# Cria diretório de trabalho
WORKDIR /app

# Copia os arquivos do projeto
COPY . .

# Expõe as portas do Spring Boot, Vite e PostgreSQL
EXPOSE 8080 5173 5432

# Comando padrão (pode ser sobrescrito)
CMD ["/bin/bash"]
