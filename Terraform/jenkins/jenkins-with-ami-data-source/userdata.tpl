
#! /bin/bash
sudo yum update -y
sudo yum install -y httpd.x86_64
sudo service httpd start
sudo service httpd enable
echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html

echo "Install Maven"
sudo yum install -y maven 

echo "Install git"
sudo yum install -y git

echo "Install jenkins"
yum remove -y java
sudo yum install java-1.8.0-openjdk-devel -y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install jenkins -y
sudo systemctl start jenkins
sudo systemctl status jenkins
sudo systemctl enable jenkins

echo "Install Docker engine"
sudo yum install docker -y
sudo usermod -a -G docker jenkins
sudo systemctl start docker
sudo systemctl enable docker


