#!/bin/bash

# Author: Tia M
# Date: November  11, 2019
# Modified on:             by:

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

elif
[[ ${OS_VERSION1} == Ubuntu ]]

then
 echo -e "\nDetected that you are running Ubuntu \n"
sleep 6

# add the repository key to the system and append the Debian package repository address to the server  
wget -q -O - http://pkg.jenkins-ci.org/debian-stable/jenkins-ci.org.key | apt-key add -
echo "deb http://pkg.jenkins-ci.org/debian-stable binary/" | tee -a /etc/apt/sources.list 

# to update and upgrade the system
apt-get update -Y
apt-get upgrade -y

# To install JAVA
apt-get -y install openjdk-8-jdk

# To install Jenkins 
apt-get -y install jenkins 

# To start to deamon
systemctl start jenkins
systemctl enable jenkins

# Jenkins runs on port 8080, so let’s open that port using ufw
ufw allow 8080

# The following commands will allow OpenSSH and enable the firewall
ufw allow OpenSSH
ufw enable

echo
echo " Use this link to access your jenkins server. http://$(ifconfig |grep Bcast |awk '{print $2}' |awk -F":" '{print $2}'):8080"
echo


else

echo -e "\nDetected that you are running Centos 6\n"
sleep 6 
echo "installing Java8..."
sleep 3
yum install java-1.8* -y

echo "checking the java version, please wait"
echo
sleep 2
java -version

echo "now downloading Jenkins..."
sleep 4
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo

echo "extracting the package..."
sleep 2
rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key

echo "installing Jenkins..."
sleep 2
yum install jenkins -y

echo "Start Jenkins services"
sleep 3 
service jenkins start
chkconfig jenkins on

echo "Configuring the port 8080 on the firewall for Jenkins server"
sleep 3
sed -i '/:OUTPUT ACCEPT/a \-A INPUT -m state --state NEW -m tcp -p tcp --dport 8080 -j ACCEPT' /etc/sysconfig/iptables

echo "Restart iptables services "
service iptables restart
sleep 2
echo "done"

echo
echo " Use this link to access your jenkins server. http://$(ifconfig |grep Bcast |awk '{print $2}' |awk -F":" '{print $2}'):8080"
echo

fi

exit 0 

