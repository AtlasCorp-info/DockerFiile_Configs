FROM fedora:41

RUN dnf update -y && dnf install -y \
    curl \
    gnupg \
    lsb-release \
    unzip \
    sudo \
    git \
    jq \
    wget \
    ca-certificates \
    dnf-plugins-core

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && sudo ./aws/install \
    && rm -rf awscliv2.zip aws

RUN curl -fsSL https://pkg.jenkins.io/war/2.319.1/jenkins.war -o /usr/share/jenkins/jenkins.war
RUN useradd -m -d /var/lib/jenkins jenkins
RUN chown jenkins:jenkins /usr/share/jenkins/jenkins.war

RUN dnf install -y ansible

RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN echo "hashicorp stable" | tee /etc/yum.repos.d/hashicorp.repo
RUN dnf install -y terraform

RUN dnf install -y https://packages.grafana.com/oss/rpm/grafana-8.4.3-1.x86_64.rpm

RUN curl -fsSL https://github.com/hostinger/cli/releases/download/v1.0.0/hostinger-cli-linux-x86_64.tar.gz -o hostinger-cli.tar.gz
RUN tar -xvzf hostinger-cli.tar.gz && mv hostinger-cli /usr/local/bin/hostinger
RUN rm -rf hostinger-cli.tar.gz

EXPOSE 8080 3000

WORKDIR /workspace

CMD ["java", "-jar", "/usr/share/jenkins/jenkins.war"]
