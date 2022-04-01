#! /bin/bash 
# user data
yum update -y
amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
yum install -y httpd mariadb-server
systemctl start httpd
systemctl enable httpd

# php script
cd /var/www/html/
wget https://linux-devops-course.s3.amazonaws.com/AWS+Demo/web+content/index.php

# Download the key from s3 bucket
mkdir /key
cd key
wget https://s3.amazonaws.com/linuxtraining.tk/bastion-key.pem
chmod 600 bastion-key