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

## PostgreSQL Tips: Installing the PostgreSQL Client
## https://www.how2shout.com/linux/install-postgresql-13-on-aws-ec2-amazon-linux-2/
## psql -h development-postgres-identifier.cv3uwkomseya.us-east-1.rds.amazonaws.com -p 5432 -U edu -W postgres

cd 
sudo tee /etc/yum.repos.d/pgdg.repo<<EOF
[pgdg13]
name=PostgreSQL 13 for RHEL/CentOS 7 - x86_64
baseurl=https://download.postgresql.org/pub/repos/yum/13/redhat/rhel-7-x86_64
enabled=1
gpgcheck=0
EOF

sudo yum update
sudo yum install postgresql13 postgresql13-server -y 
sudo /usr/pgsql-13/bin/postgresql-13-setup initdb
sudo systemctl start postgresql-13
sudo systemctl enable postgresql-13