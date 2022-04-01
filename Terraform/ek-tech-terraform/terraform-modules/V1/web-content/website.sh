#! /bin/bash

sudo yum update -y
sudo yum install -y wget
sudo yum install -y unzip
sudo yum install -y httpd
sudo systemctl enable httpd
sudo service httpd start  
cd /var/www/html/
sudo wget https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/covid19.zip 
sudo unzip covid19.zip 
sudo cp -R covid19/* . 
sudo rm -rf covid19.zip 
sudo rm -rf covid19
