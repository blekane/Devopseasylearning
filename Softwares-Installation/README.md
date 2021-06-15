### Jenkins Installation
```sh
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
```

### iptable installation on Centos7
```sh
systemctl stop firewalld
systemctl disable firewalld
systemctl mask --now firewalld
yum -y install iptables-services
systemctl start iptables
systemctl start ip6tables
systemctl enable iptables
systemctl enable ip6tables
#start the firewall (etc/sysconfig/iptables)
systemctl restart iptables
```

### Atom installation on Centons 7
```sh
#! /usr/bin/bash

# How to install Atom Text Editor on CentOS 7

# root privilege if the user is not root
echo "Please enter you password if your are not a root user."

if [ "$(whoami)" != "root" ]
then
    sudo -s "$0"
    exit
fi

echo "installing git."
yum install wget git -y
echo "Downloading atom packages from https://atom.io/"
wget https://github.com/atom/atom/releases/download/v1.18.0/atom.x86_64.rpm # to download atom
echo "Installing atom package"
yum localinstall atom.x86_64.rpm -y # to install atom

# atom will setup will be safe in the same directory with the script
rm -rf "atom.x86_64.rpm" # to remove atom from home directory

echo "Type Atom in your terminal to launch the Text Editor or go to application- programming and launch atom"
echo "Enjoy Atom!"
```

### VLC Installation
```sh
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm
yum -y install vlc

# google packages
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
yum -y install ./google-chrome-stable_current_*.rpm

# To remove google chrome setup
rm -rf "google-chrome-stable_current_x86_64.rpm"
echo "Installation of VLC and Google Chrome Copmpleted"
```

### Install terraform
```sh
wget https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_linux_amd64.zip
unzip terraform_0.13.5_linux_amd64.zip
# To check
./terraform
mv terraform /usr/local/bin

wget https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip
```


### Terragrunt installation
```sh
wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.26.7/terragrunt_linux_amd64
mv terragrunt_linux_amd64 terragrunt
chmod u+x terragrunt
mv terragrunt /usr/local/bin/terragrunt
terragrunt --version
```

### How to Install Visual Studio Code on CentOS 7
* [How to Install Visual Studio Code on CentOS 7](https://linuxize.com/post/how-to-install-visual-studio-code-on-centos-7/)
* Start by importing the Microsoft GPG key:
```sh
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

* Next, create the following repo file to enable the Visual Studio Code repository:
* vim /etc/yum.repos.d/vscode.repo and Paste the following content into the file:

[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc

* Once the repository is enabled, install the latest version of Visual Studio Code by typing

yum install code -y

* Starting Visual Studio Code 
Now that VS Code is installed on your CentOS system you can launch it either from the command line by typing `code` or by clicking on the VS Code icon (Applications -> Programming -> Visual Studio Code).
```

### Install kubectx on CentOs
* [link](https://centos.pkgs.org/7/harbottle-main-x86_64/kubectx-0.6.3-1.el7.harbottle.x86_64.rpm.html)
```sh
wget https://harbottle.gitlab.io/harbottle-main/7/x86_64/harbottle-main-release.rpm
rpm -Uvh harbottle-main-release.rpm
yum install kubectx -y
kubectx
```

### Install kubens on CentOs
* [links](https://github.com/ahmetb/kubectx/releases)
```sh
wget https://github.com/ahmetb/kubectx/releases/download/v0.9.1/kubens_v0.9.1_linux_x86_64.tar.gz
tar -zxvf kubens_v0.9.1_linux_x86_64.tar.gz
mv kubens /usr/local/bin/
kubens
```

### Installing kubectl
```sh
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.9/2020-08-04/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv kubectl /usr/local/bin/
kubectl
```

### AWS CLI
```sh
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
sudo ./aws/install -i /usr/local/aws-cli -b /usr/local/bin
aws --version
```

```sh
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

### Install kubectx and kubens
```sh
wget https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx
wget https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens
chmod +x kubectx kubens
sudo mv kubens kubectx /usr/local/bin

kubectx --help
kubens --help
```

### Install kubectl on CentOs
```sh
curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/v1.6.0/bin/linux/amd64/kubectl && chmod +x kubectl && sudo mv kubectl /usr/local/bin/
kubectl
```

```sh
mkdir kubectlbinary
cd kubectlbinary
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.9/2020-08-04/bin/linux/amd64/kubectl
chmod +x ./kubectl
kubectl version --short --client
```

```sh
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
```

### Install Helm 3
```sh
curl -LO https://get.helm.sh/helm-v3.5.0-linux-amd64.tar.gz
tar -zxvf helm-v3.5.0-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/helm
helm version --short
helm repo add stable https://charts.helm.sh/stable
```
* Install helm 2.17
```sh
cd /tmp 
wget https://get.helm.sh/helm-v2.17.0-linux-amd64.tar.gz -O /tmp/helm.tar.gz ; \
tar xf helm.tar.gz ; \
mv linux-amd64/helm /usr/local/bin/
helm version --short
```

### Helm installation in Windows through powershell
* [Installing Chocolatey](https://chocolatey.org/install)
```
Bypass
```
Run `Get-ExecutionPolicy`. If it returns `Restricted`, then run `Set-ExecutionPolicy AllSigned` or `Set-ExecutionPolicy Bypass -Scope` Process.
```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco install kubernetes-helm
helm version --short
```

### Docker installation on Centos 7
```sh
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
```
* install docker on Ubuntu
```sh
install docker
sudo apt-get update && \
    sudo apt-get install docker.io -y
```

* install docker on ubuntu
```sh
sudo apt-get update
apt-get remove docker docker-engine docker.io
apt install docker.io
systemctl start docker
systemctl enable docker
docker --version
```

### Google Installation
```sh
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
yum -y install ./google-chrome-stable_current_*.rpm
rm -rf "google-chrome-stable_current_x86_64.rpm"
echo "Installation of Google chrome Copmpleted"
```

### Golang tool installation
* [Download golang](https://golang.org/dl/)
```sh
wget https://golang.org/dl/go1.15.7.linux-amd64.tar.gz
tar -xvzf go1.15.7.linux-amd64.tar.gz -C /usr/local
cd /usr/local/go/bin/
echo 'export PATH=$PATH:/usr/local/go/bin' >> /etc/profile # or vim /etc/profile
source /etc/profile
go version
```

### Install Kind
* [Kind setup Github page](https://github.com/kubernetes-sigs/kind)
```sh
GO111MODULE="on" go get sigs.k8s.io/kind@v0.9.0
find / -name kind
cd /root/go/bin/
cp kind /usr/local/bin/kind
kind version
```

### Grafana Installation
* [How to install and configure Grafana on CentOS 7](https://www.fosslinux.com/8328/how-to-install-and-configure-grafana-on-centos-7.htm)