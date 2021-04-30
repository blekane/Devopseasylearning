#!/bin/bash

# Script to setup Jenkins on CentOS/RHEL 6.x and 7.x

OS_VERSION1=`cat /etc/*release |grep VERSION_ID |awk -F\" '{print $2}'`
OS_VERSION2=`cat /etc/*release|head -1|awk '{print $1}' |cut -d= -f2`
OS_TYPE=`cat /etc/*release|head -1|awk '{print $1}'`

echo -e "\n Checking if your server is connected to the network...."

sleep 4
ping google.com -c 4

if
  [[ ${?} -ne 0 ]]
 then
 echo -e "\nPlease verify that your server is connected!!\n"
 exit 2
 fi

echo -e "\nChecking if system is centOS 6 or 7\n"

if 
  [[ ${OS_VERSION1} -eq 7 ]] && [[ ${OS_TYPE} == CentOS ]]
 then
 echo -e "\nDetected that you are running CentOS 7 \n"
sleep 6

echo "installing Java8..."
sleep 3

# Jenkins is a Java application, so the first step is to install Java
yum -y install java-1.8.0-openjdk-devel

echo "checking the java version, please wait"
echo
sleep 2
java -version

echo "Enabling and adding the Jenkins repository..."
sleep 4
# enable the Jenkins repository
curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | tee /etc/yum.repos.d/jenkins.repo

# And add the repository to your system
rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key

echo "installing jenkins..."
Sleep 4
# Once the repository is enabled, install the latest stable version of Jenkins
yum -y install jenkins

# start the Jenkins service
systemctl start jenkins

# enable the Jenkins service to start on system boot
systemctl enable jenkins

# Use the following commands to open the necessary port
echo "Configuring the port 8080 on the firewall for Jenkins server"
sleep 3
firewall-cmd --permanent --zone=public --add-port=8080/tcp
firewall-cmd --reload

echo
echo " Use this link to access your Jenkins server. http://$(hostname -I |awk '{print $1}'):8080"
echo

fi


### Install kubectx on CentOs
wget https://harbottle.gitlab.io/harbottle-main/7/x86_64/harbottle-main-release.rpm
rpm -Uvh harbottle-main-release.rpm
yum install kubectx -y

### Install kubens on CentOs
wget https://github.com/ahmetb/kubectx/releases/download/v0.9.1/kubens_v0.9.1_linux_x86_64.tar.gz
tar -zxvf kubens_v0.9.1_linux_x86_64.tar.gz
mv kubens /usr/local/bin/

### AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
sudo ./aws/install -i /usr/local/aws-cli -b /usr/local/bin
aws --version

### Install kubectl on CentOs
curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/v1.6.0/bin/linux/amd64/kubectl && chmod +x kubectl && sudo mv kubectl /usr/local/bin/

### Install Helm
curl -LO https://get.helm.sh/helm-v3.5.0-linux-amd64.tar.gz
tar -zxvf helm-v3.5.0-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/helm
helm version --short
helm repo add stable https://charts.helm.sh/stable


### Docker installation
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

# this will download the script package to install docker
curl -fsSL https://get.docker.com -o get-docker.sh
# this will install the package
sudo sh get-docker.sh

sudo systemctl enable docker
sudo systemctl start docker
sudo docker run hello-world
sudo docker run docker/whalesay cowsay hello-world!


### Golang tool installation
wget https://golang.org/dl/go1.15.7.linux-amd64.tar.gz
tar -xvzf go1.15.7.linux-amd64.tar.gz -C /usr/local
cd /usr/local/go/bin/
echo 'export PATH=$PATH:/usr/local/go/bin' >> /etc/profile # or vim /etc/profile
source /etc/profile
go version

### Install Kind
GO111MODULE="on" go get sigs.k8s.io/kind@v0.9.0
find / -name kind
cd /root/go/bin/
cp kind /usr/local/bin/kind
kind version


