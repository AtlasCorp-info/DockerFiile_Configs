FROM fedora:41

# Atualiza os pacotes
RUN sudo dnf -y update && dnf -y install \
    java-21-openjdk-devel \
    nodejs && \
    curl && \
    git && \
    dnf clean all

# Instalação do Nginx 
RUN sudo dnf -y install gcc pcre-devel zlib-devel make && \
    curl -O http://nginx.org/download/nginx-1.27.3.tar.gz && \
    tar -zxvf nginx-1.27.3.tar.gz && cd nginx-1.27.3 && \
    .configure && make && make install

# Instalação do PostgreSQL
RUN sudo dnf -y update && dnf -y install \
    https://download.postgresql.org/pub/repos/yum/reporpms/F-41-x86_64/pgdg-fedora-repo-latest.noarch.rpm &&  \
    dnf -y module disable postgresql && \
    dnf -y install postgresql17-server postgresql17-contrib && \
    dnf clean all

# Define o diretório de trabalho do PostgreSQL
USER postgres
WORKDIR /var/lib/pgsql

# Instalação do TypeScript 
RUN npm install -D typescript

# Instalação do Vite
RUN npm i vite

# Instala o Bootstrap
RUN sudo dnf -y install  "git clone https://github.com/twbs/bootstrap.git" && \
    npm install bootstrap@v5.3.3

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
