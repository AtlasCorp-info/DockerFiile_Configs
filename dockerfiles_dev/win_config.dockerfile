FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Define o diretório de trabalho
WORKDIR /projeto_erp

# Instalação do Chocolatey para gerenciar pacotes
RUN powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; \ 
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \ 
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"


# Instalação do Java JDK 21, Node.js, Nginx, PostgreSQL
RUN choco install openjdk --version=21.0.1 -y && \
    choco install nodejs --version=22.11.0 -y && \
    choco install nginx --version=1.27.3 -y && \
    choco install postgresql --version=17.3.0 -y

# Atualiza o PATH para incluir o Java
ENV JAVA_HOME="C:\Program Files\OpenJDK\jdk-21"
ENV PATH="${JAVA_HOME}\bin;C:\Program Files\nodejs;C:\Program Files\Git\bin;${PATH}"

# Instalação do TypeScript 
RUN npm install -D typescript

# Instalação do Vite
RUN npm i vite

# Instalação do Bootstrap no diretório do projeto
RUN powershell -Command "git clone https://github.com/twbs/bootstrap.git"
RUN npm install bootstrap@v5.3.3

# Copia os arquivos do projeto
COPY . .

# Expõe as portas do Spring Boot e do Vite
EXPOSE 8080 5173

# Comando padrão para manter o contêiner rodando
CMD ["powershell"]
