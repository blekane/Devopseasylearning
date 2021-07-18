#!/bin/bash

# SERVER CONFIGURATION
# author: Tia, date 10/14/2019


echo "This script is going to create users, create file and install some packages. Please give us a few minute" 
sleep 5

echo "Creating user ansible"
sleep 3
useradd ansible

echo "copy the variable into the user ansible home directory"

sleep 3
echo "TMP=/var/log" >> /home/ansible/.bashrc

echo "TMPDIR=/tmp" >> /home/ansible/.bashrc

echo "Creating the deploy group"
sleep 3
groupadd deploy

echo "Adding user ansible to the deploy group"
sleep 3
usermod -G deploy ansible

echo "Creating the directory http_log"
sleep 3
mkdir /var/log/http_log

echo "Creating logs files ...."
sleep 3
touch /var/log/http_log/error.log
touch /var/log/http_log/access.log

echo "updating files permission..."
chmod 640 /var/log/http_log/error.log
chmod 640 /var/log/http_log/access.log

echo "Installing some packages"
sleep 3

yum -y install git
yum -y install finger
yum -y install tree

echo "Server configuration is completed successfully."
