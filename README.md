# DockerFiile_Configs
Configurações para um ambiente mais controlado

# Manual de como fazer a instalação das dependências do projeto #

####################
# Ambiente Windows #
####################


## Pré-requisitos
Antes de executar o Dockerfile no Windows, certifique-se de que possui os seguintes componentes instalados:

1. **Docker Desktop**
   - Baixe e instale pelo site oficial: [Docker Desktop](https://www.docker.com/products/docker-desktop/)
   - Durante a instalação, habilite o suporte para **WSL 2** caso esteja usando o Windows 10/11.

2. **PowerShell**
   - O PowerShell vem instalado por padrão no Windows. Caso precise atualizar, utilize este comando no terminal:
     ```powershell
     winget install --id Microsoft.Powershell --source winget
     ```

3. **Habilitar Containers do Windows (se necessário)**
   - Caso esteja rodando um ambiente Windows puro (sem WSL), execute este comando no PowerShell como administrador:
     ```powershell
     dism.exe /online /enable-feature /featurename:Microsoft-Hyper-V /all
     ```

---

## Passos para Construção e Execução do Container

### 1. Criar ou Clonar o Diretório do Projeto
Abra o PowerShell e crie um diretório para o projeto:
```powershell
mkdir C:\meu_projeto; cd C:\meu_projeto
```
Caso esteja utilizando um repositório Git, clone-o:
```powershell
git clone <URL_DO_REPOSITORIO>
cd <NOME_DO_REPOSITORIO>
```

### 2. Criar o Arquivo `Dockerfile`
Se o `Dockerfile` ainda não existir, copie o conteúdo fornecido anteriormente e salve-o no diretório raiz do projeto como `Dockerfile`.

### 3. Construir a Imagem Docker
No PowerShell, execute:
```powershell
docker build -t meu_projeto .
```
- `-t meu_projeto`: Nomeia a imagem como **meu_projeto**.
- `.`: Indica que o `Dockerfile` está no diretório atual.

### 4. Executar o Container
```powershell
docker run -d -p 8080:8080 -p 5173:5173 -p 5432:5432 --name meu_container meu_projeto
```
- `-d`: Executa o container em **modo background**.
- `-p 8080:8080`: Mapeia a porta **8080** para o Spring Boot.
- `-p 5173:5173`: Mapeia a porta do **Vite/React**.
- `-p 5432:5432`: Mapeia a porta do **PostgreSQL**.
- `--name meu_container`: Nomeia o container.

### 5. Acessar o Container
Para acessar o terminal dentro do container:
```powershell
docker exec -it meu_container powershell
```

### 6. Verificar os Logs
Se precisar verificar o status do container:
```powershell
docker logs -f meu_container
```

### 7. Parar e Remover o Container
Para parar o container:
```powershell
docker stop meu_container
```
Para removê-lo:
```powershell
docker rm meu_container
```
Se precisar remover a imagem também:
```powershell
docker rmi meu_projeto
```

### 8. Configuração do Banco de Dados PostgreSQL
Dentro do container, acesse o PostgreSQL:
```powershell
docker exec -it meu_container psql -U postgres
```
Crie um banco de dados e um usuário:
```sql
CREATE DATABASE meu_banco;
CREATE USER meu_usuario WITH ENCRYPTED PASSWORD 'minha_senha';
GRANT ALL PRIVILEGES ON DATABASE meu_banco TO adim_usuario;
```
Saia do PostgreSQL digitando `\q`.

---

########################
# Ambiente Windows WSL #
########################


## Pré-requisitos
Antes de executar o Dockerfile no Windows com WSL (Windows Subsystem for Linux), certifique-se de que possui os seguintes componentes instalados:

1. **WSL 2 e Ubuntu**
   - Habilite o WSL 2 no Windows executando no PowerShell como administrador:
     ```powershell
     wsl --install -d Ubuntu
     ```
   - Reinicie o computador após a instalação.

2. **Docker Desktop**
   - Baixe e instale pelo site oficial: [Docker Desktop](https://www.docker.com/products/docker-desktop/)
   - Durante a instalação, habilite o suporte para **WSL 2**.

3. **Verificar se o Docker está rodando no WSL**
   - Abra o terminal do WSL (Ubuntu) e execute:
     ```bash
     docker --version
     ```
   - Se houver erro, verifique se o Docker Desktop está aberto no Windows.

---

## Passos para Construção e Execução do Container

### 1. Criar ou Clonar o Diretório do Projeto
Abra o terminal do WSL e crie um diretório para o projeto:
```bash
mkdir -p ~/meu_projeto && cd ~/meu_projeto
```
Caso esteja utilizando um repositório Git, clone-o:
```bash
git clone <URL_DO_REPOSITORIO>
cd <NOME_DO_REPOSITORIO>
```

### 2. Criar o Arquivo `Dockerfile`
Se o `Dockerfile` ainda não existir, copie o conteúdo fornecido anteriormente e salve-o no diretório raiz do projeto como `Dockerfile`.

### 3. Construir a Imagem Docker
No terminal do WSL, execute:
```bash
docker build -t meu_projeto .
```
- `-t meu_projeto`: Nomeia a imagem como **meu_projeto**.
- `.`: Indica que o `Dockerfile` está no diretório atual.

### 4. Executar o Container
```bash
docker run -d -p 8080:8080 -p 5173:5173 -p 5432:5432 --name meu_container meu_projeto
```
- `-d`: Executa o container em **modo background**.
- `-p 8080:8080`: Mapeia a porta **8080** para o Spring Boot.
- `-p 5173:5173`: Mapeia a porta do **Vite/React**.
- `-p 5432:5432`: Mapeia a porta do **PostgreSQL**.
- `--name meu_container`: Nomeia o container.

### 5. Acessar o Container
Para acessar o terminal dentro do container:
```bash
docker exec -it meu_container /bin/bash
```

### 6. Verificar os Logs
Se precisar verificar o status do container:
```bash
docker logs -f meu_container
```

### 7. Parar e Remover o Container
Para parar o container:
```bash
docker stop meu_container
```
Para removê-lo:
```bash
docker rm meu_container
```
Se precisar remover a imagem também:
```bash
docker rmi meu_projeto
```

### 8. Configuração do Banco de Dados PostgreSQL
Dentro do container, acesse o PostgreSQL:
```bash
docker exec -it meu_container psql -U postgres
```
Crie um banco de dados e um usuário:
```sql
CREATE DATABASE meu_banco;
CREATE USER meu_usuario WITH ENCRYPTED PASSWORD 'admin_senha';
GRANT ALL PRIVILEGES ON DATABASE meu_banco TO meu_usuario;
```
Saia do PostgreSQL digitando `\q`.

---

########################
# Ambiente Linux (RPM) #
########################

!Caso use outra distribição Linux por favor verificar qual o comando para instalar os pacotes do repositório da sua distro de uso!

# Manual de Execução do Dockerfile no Linux Fedora 41

## Pré-requisitos
Antes de executar o Dockerfile no Fedora 41, certifique-se de que possui os seguintes componentes instalados:

1. **Atualizar o sistema**
   - Execute o seguinte comando para garantir que todos os pacotes estejam atualizados:
     ```bash
     sudo dnf update -y
     ```

2. **Instalar o Docker**
   - Adicione o repositório do Docker:
     ```bash
     sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
     ```
   - Instale o Docker:
     ```bash
     sudo dnf install -y docker-ce docker-ce-cli containerd.io
     ```
   - Habilite e inicie o serviço do Docker:
     ```bash
     sudo systemctl enable --now docker
     ```
   - Adicione seu usuário ao grupo Docker para executar sem sudo:
     ```bash
     sudo usermod -aG docker $USER
     exec sudo su -l $USER
     ```

3. **Verificar se o Docker está rodando**
   - Execute o comando:
     ```bash
     docker --version
     ```
   - Se houver erro, verifique se o serviço está ativo:
     ```bash
     sudo systemctl status docker
     ```

---

## Passos para Construção e Execução do Container

### 1. Criar ou Clonar o Diretório do Projeto
Abra o terminal e crie um diretório para o projeto:
```bash
mkdir -p ~/meu_projeto && cd ~/meu_projeto
```
Caso esteja utilizando um repositório Git, clone-o:
```bash
git clone <URL_DO_REPOSITORIO>
cd <NOME_DO_REPOSITORIO>
```

### 2. Criar o Arquivo `Dockerfile`
Se o `Dockerfile` ainda não existir, copie o conteúdo fornecido anteriormente e salve-o no diretório raiz do projeto como `Dockerfile`.

### 3. Construir a Imagem Docker
No terminal, execute:
```bash
docker build -t meu_projeto .
```
- `-t meu_projeto`: Nomeia a imagem como **meu_projeto**.
- `.`: Indica que o `Dockerfile` está no diretório atual.

### 4. Executar o Container
```bash
docker run -d -p 8080:8080 -p 5173:5173 -p 5432:5432 --name meu_container meu_projeto
```
- `-d`: Executa o container em **modo background**.
- `-p 8080:8080`: Mapeia a porta **8080** para o Spring Boot.
- `-p 5173:5173`: Mapeia a porta do **Vite/React**.
- `-p 5432:5432`: Mapeia a porta do **PostgreSQL**.
- `--name meu_container`: Nomeia o container.

### 5. Acessar o Container
Para acessar o terminal dentro do container:
```bash
docker exec -it meu_container /bin/bash
```

### 6. Verificar os Logs
Se precisar verificar o status do container:
```bash
docker logs -f meu_container
```

### 7. Parar e Remover o Container
Para parar o container:
```bash
docker stop meu_container
```
Para removê-lo:
```bash
docker rm meu_container
```
Se precisar remover a imagem também:
```bash
docker rmi meu_projeto
```

### 8. Configuração do Banco de Dados PostgreSQL
Dentro do container, acesse o PostgreSQL:
```bash
docker exec -it meu_container psql -U postgres
```
Crie um banco de dados e um usuário:
```sql
CREATE DATABASE meu_banco;
CREATE USER meu_usuario WITH ENCRYPTED PASSWORD 'admin_senha';
GRANT ALL PRIVILEGES ON DATABASE meu_banco TO meu_usuario;
```
Saia do PostgreSQL digitando `\q`.

---