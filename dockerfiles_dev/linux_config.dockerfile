FROM fedora:41

# Atualiza os pacotes
RUN sudo dnf -y update && dnf -y install \
    java-21-openjdk-devel \
    nodejs \
    npm \
    nginx \
    curl \
    git \
    postgresql-server \
    postgresql-contrib \
    && dnf clean all

# Instala o TypeScript globalmente
RUN npm install -g typescript

# Instala o Vite globalmente
RUN npm install -g vite

# Instala o Bootstrap
RUN npm install bootstrap

# Define variáveis de ambiente
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Cria diretório de trabalho
WORKDIR /app

# Copia os arquivos do projeto
COPY . .

# Expõe as portas do Spring Boot e do Vite
EXPOSE 8080 5173

# Comando padrão (pode ser sobrescrito)
CMD ["/bin/bash"]
