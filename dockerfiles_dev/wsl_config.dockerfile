FROM ubuntu:latest

# Atualiza os pacotes
RUN sudo apt update && apt upgrade -y

# Instala dependências
RUN apt install -y \
    openjdk-21-jdk \
    nodejs \
    npm \
    nginx \
    git \
    curl \
    postgresql \
    postgresql-contrib \
    && apt clean

# Instala o TypeScript globalmente
RUN npm install -g typescript

# Instala o Vite globalmente
RUN npm install -g vite

# Instala o Bootstrap
RUN npm install bootstrap

# Define variáveis de ambiente
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Inicializa o banco de dados PostgreSQL
RUN service postgresql start && \
    sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'postgres';"

# Cria diretório de trabalho
WORKDIR /app

# Copia os arquivos do projeto
COPY . .

# Expõe as portas do Spring Boot, Vite e PostgreSQL
EXPOSE 8080 5173 5432

# Comando padrão (pode ser sobrescrito)
CMD ["/bin/bash"]
