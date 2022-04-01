### Install terraform
```sh
wget https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_linux_amd64.zip
unzip terraform_0.13.5_linux_amd64.zip
# To check
./terraform
mv terraform /usr/local/bin

wget https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip
```


### AWS CLI
```sh
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
sudo ./aws/install -i /usr/local/aws-cli -b /usr/local/bin
aws --version
```

### JQ installation
* [How to install jq on RHEL6.5](https://serverfault.com/questions/768026/how-to-install-jq-on-rhel6-5)
```
wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
chmod +x ./jq
cp jq /usr/bin
jq --version
```

### Terragrunt installation
wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.26.7/terragrunt_linux_amd64
mv terragrunt_linux_amd64 terragrunt
chmod u+x terragrunt
mv terragrunt /usr/local/bin/terragrunt
terragrunt --version


### AWS RUNAS
* [aws-runas/docs/quick-start.md](https://github.com/mmmorris1975/aws-runas/blob/master/docs/quick-start.md)

* [aws-runas](https://mmmorris1975.github.io/aws-runas/quick-start.html)


wget https://github.com/mmmorris1975/aws-runas/releases/download/2.3.0/aws-runas-2.3.0-linux-amd64
mv aws-runas-2.3.0-linux-amd64 aws-runas
chmod +x aws-runas

//  add to path
cp -r aws-runas /usr/local/bin/aws-runas
aws-runas 

OR

cp -r aws-runas /
/.aws-runas

## USER DATA
```sh
#! /bin/bash
sudo yum update -y

### Install Jenkins
sudo yum install java-1.8.0-openjdk-devel -y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install jenkins -y
sudo systemctl start jenkins
sudo systemctl status jenkins
sudo systemctl enable jenkins


### Install terraform 0.12.26
wget https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip
unzip terraform_0.12.26_linux_amd64.zip
sudo mv terraform /usr/bin
terraform --version

### AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
sudo ./aws/install -i /usr/aws-cli -b /usr/bin

### JQ installation
wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
sudo chmod +x ./jq
sudo cp jq /usr/bin
jq --version
    
### Terragrunt installation
wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.26.7/terragrunt_linux_amd64
mv terragrunt_linux_amd64 terragrunt
sudo chmod u+x terragrunt
sudo mv terragrunt /usr/bin/terragrunt
terragrunt --version

### AWS RUNAS
wget https://github.com/mmmorris1975/aws-runas/releases/download/2.3.0/aws-runas-2.3.0-linux-amd64
mv aws-runas-2.3.0-linux-amd64 aws-runas
sudo chmod +x aws-runas
sudo cp -r aws-runas /usr/bin/aws-runas
```

### Setup in Jenkins
* To avoid permission denied
```sh
ll /bin/terragrunt
chgrp jenkins /bin/terragrunt
chown jenkins /bin/terragrunt
```

* Apply-all with auto approve
```sh
cd /var/lib/jenkins/workspace/terragrunt/live/dev
terragrunt apply-all --terragrunt-non-interactive
```

* Destroy-all with auto approve
```sh
cd /var/lib/jenkins/workspace/terragrunt/live/dev
terragrunt destroy-all --terragrunt-non-interactive
```

