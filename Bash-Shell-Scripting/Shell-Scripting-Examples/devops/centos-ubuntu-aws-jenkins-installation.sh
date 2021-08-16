#!/bin/bash
# Author: Tia M
# Date: August 16, 2021
#This script can only run of Debain and Fedora base OS
echo
echo 'This script will take about 5 min to run and perform the following tasks:'
echo  $'\e[1;33m'Install Jenkins$'\e[0m'
echo  $'\e[1;33m'Start jenkins daemon$'\e[0m'
echo  $'\e[1;33m'Open port 8080 on the firwall$'\e[0m'
echo  $'\e[1;33m'Display Jenkins URL at the end$'\e[0m'
echo
sleep 5

AWS_IP=`curl ifconfig.co`
OS=$(cat /etc/os-release |grep PRETTY_NAME | awk -F= '{print$2}' | awk -F '"' '{print$2}' |awk '{print$1}')
IP=$(ip route get 1.2.3.4 | awk '{print $7}')

echo 'checking if jenkins is installed'
ls /var/lib |grep jenkins
if 
[[ ${?} -eq 0 ]]
then 
    echo "Jenkins is install"
    exit 1
    else

case $OS in
Ubuntu)
echo "This is Ubuntu server"
sleep 5
#sudo apt update
sudo apt install wget -y
sudo apt search openjdk
sudo apt install openjdk-11-jdk -y
java -version
ufw enable 2& > /dev/null 
ufw allow 8080/tcp   2& > /dev/null 
ufw reload
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update -y
sudo apt-get install jenkins -y
systemctl start jenkins 
systemctl enable jenkins

echo "Use the bellow URL to check your website on the browser:"
sleep 2
echo "http://$IP:8080/"
exit 1
;;

CentOS) 
echo "This is CentOs server"
sleep 5 

sudo yum install wget -y
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
#sudo yum upgrade -y
sudo java-11-openjdk-devel -y
sudo yum install jenkins -y 
sudo systemctl daemon-reload
systemctl start jenkins 
systemctl enable jenkins
firewall-cmd --permanent --add-port=8080/tcp   2& > /dev/null 
firewall-cmd --reload 2& > /dev/null

echo "Use the bellow URL to check your website on the browser:"
sleep 2
echo "http://$IP:8080/"
exit 1
;;


Amazon)
echo "This is Amazon server"
sleep 5
sudo yum install wget -y
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade -y
sudo java-1.8.0 -y
sudo yum install jenkins -y 
sudo yum install jenkins -y
sudo systemctl daemon-reload
systemctl start jenkins 
systemctl enable jenkins

echo "Use the bellow URL to check your website on the browser:"
sleep 2
echo "http://$AWS_IP:8080/"
exit 1
;;

*)
   echo "your operating system is UNKNOWN"
   exit 1
   ;;
esac 

fi



#! /bin/bash

# This script will install java and jenkins
 echo "Checking the operating system"
 OS=$(cat /etc/os-release |grep PRETTY_NAME | awk -F= '{print$2}' | awk -F '"' '{print$2}' |awk '{print$1}')

echo 'checking if jenkins is installed'
ls /var/lib |grep jenkins
if 
[[ ${?} -eq 0 ]]
then 
    echo "Jenkins is install"
    exit 1
    else

case $OS in
Ubuntu)
#sudo apt update
sudo apt search openjdk
sudo apt install openjdk-11-jdk -y
java -version
ufw allow 8080/tcp   2& > /dev/null 
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update -y
sudo apt-get install jenkins -y
systemctl start jenkins 
systemctl enable jenkins

;;

CentOS) 
  
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
#sudo yum upgrade -y
sudo yum install jenkins java-11-openjdk-devel -y
sudo systemctl daemon-reload
systemctl start jenkins 
systemctl enable jenkins
firewall-cmd --permanent --add-port=8080/tcp   2& > /dev/null 
firewall-cmd --reload 2& > /dev/null

;;


Amazon)
  
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade -y
sudo yum install jenkins java-1.8.0 -y
sudo systemctl daemon-reload
systemctl start jenkins 
systemctl enable jenkins
firewall-cmd --permanent --add-port=8080/tcp   2& > /dev/null   
firewall-cmd --reload 2& > /dev/null

;;

*)
   echo "your operating system is UNKNOWN"
   exit 1
   ;;
esac 

fi



