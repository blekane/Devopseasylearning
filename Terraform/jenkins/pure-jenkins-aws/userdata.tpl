#! /bin/bash
sudo yum update -y
sudo yum install -y httpd.x86_64
sudo service httpd start
sudo service httpd enable
echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html

# Install Jenkins
sudo yum install java-1.8.0-openjdk-devel -y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install jenkins -y
sudo systemctl start jenkins
sudo systemctl status jenkins
sudo systemctl enable jenkins


# Install terraform 0.12.26
wget https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip
unzip terraform_0.12.26_linux_amd64.zip
sudo mv terraform /usr/bin
terraform --version

# AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
sudo ./aws/install -i /usr/aws-cli -b /usr/bin

# JQ installation
wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
sudo chmod +x ./jq
sudo cp jq /usr/bin
jq --version
    
# Terragrunt installation
wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.26.7/terragrunt_linux_amd64
mv terragrunt_linux_amd64 terragrunt
sudo chmod u+x terragrunt
sudo mv terragrunt /usr/bin/terragrunt
terragrunt --version

# AWS RUNAS
wget https://github.com/mmmorris1975/aws-runas/releases/download/2.3.0/aws-runas-2.3.0-linux-amd64
mv aws-runas-2.3.0-linux-amd64 aws-runas
sudo chmod +x aws-runas
sudo cp -r aws-runas /usr/bin/aws-runas