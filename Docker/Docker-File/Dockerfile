FROM jrei/systemd-ubuntu

# FROM ubuntu:latest

RUN mkdir /student_home
WORKDIR /student_home

RUN apt-get update -y
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ 'Europe/Tallinn'
RUN echo $TZ > /etc/timezone && \
    apt-get update && apt-get install -y tzdata && \
    rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get clean

RUN apt-get update -y

RUN apt-get install apt-utils -y \
    wget \
    curl \
    vim \
    unzip \
    tree \
    git \
    default-jre \
    default-jdk \
    firewalld \
    python3-pip \
    ansible \
    nodejs \
    make \
    build-essential \
    npm \
    ufw

RUN apt-get update -y

### AWS CLI INSTALLATIN
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && aws/install \
    # && aws/install -i /usr/local/aws-cli -b /usr/local/bin \
    && rm -rf awscliv2.zip \
    && rm -rf aws


### AZURE CLI INSTALLATIN
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash


### KUBECTL INSTALLATIN
RUN curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.9/2020-08-04/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv kubectl /usr/local/bin/


### INSTALL KUBECTX AND KUBENS
RUN wget https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx \
    && wget https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens \
    && chmod +x kubectx kubens \
    && mv kubens kubectx /usr/local/bin

### TERRAFORM INSTALLATIN
ENV TERRAFORM_VERSION 1.0.0
WORKDIR /tmp
RUN wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && mv terraform /usr/local/bin \
    && rm -f terraform terraform_${TERRAFORM_VERSION}_linux_amd64.zip


### TERRAGRUNT INSTALLATIN
ENV TERRAGRUNT_VERSION v0.26.7
RUN wget https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 \
    && mv terragrunt_linux_amd64 terragrunt \
    && chmod u+x terragrunt \
    && mv terragrunt /usr/local/bin/terragrunt


### HELM INSTALLATIN
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
    && chmod +x get_helm.sh && ./get_helm.sh


## DOCKER AND DOCKER-COMPOSE INSTALLATIN
COPY --from=library/docker:latest /usr/local/bin/docker /usr/bin/docker
COPY --from=docker/compose:latest /usr/local/bin/docker-compose /usr/bin/docker-compose


# ### Golang NSTALLATIN
# RUN wget https://golang.org/dl/go1.15.7.linux-amd64.tar.gz \
#     && tar -xvzf go1.15.7.linux-amd64.tar.gz -C /usr/local \
#     && cd /usr/local/go/bin/ \
#     && echo 'export PATH=$PATH:/usr/local/go/bin' >> /etc/profile \
#     && source /etc/profile \
#     rm -rf go1.15.7.linux-amd64.tar.gz



#https://docs.docker.com/develop/develop-images/multistage-build/

