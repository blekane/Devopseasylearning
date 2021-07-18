#!/bin/bash


#Script to setup Apache Tomcat on centOS/RHEL 7


# Author: Tia M
# Date: November 11, 2019
# Modified on:             by:

echo -e "\nInstalling tomcat ..\n"

sleep 4

cd /opt

wget http://mirrors.ocf.berkeley.edu/apache/tomcat/tomcat-8/v8.5.47/bin/apache-tomcat-8.5.47.tar.gz
tar -xzvf apache-tomcat-8.5.47.tar.gz

rm -rf apa*.gz
mv apache* tomcat

chmod +x /opt/tomcat/bin/startup.sh
chmod +x /opt/tomcat/bin/shutdown.sh

ln -s /opt/tomcat/bin/startup.sh /usr/local/bin/tomcatup
ln -s /opt/tomcat/bin/shutdown.sh /usr/local/bin/tomcatdown

echo -e "\nStarting tomcat\n"
sleep 4

tomcatdown
tomcatup

# Use the following commands to open the necessary port
echo "Configuring the port 8080 on the firewall for Tomcat server"
sleep 3
firewall-cmd --permanent --zone=public --add-port=8080/tcp
firewall-cmd --reload

echo
echo " Use this link to access your Jenkins server. http://$(hostname -I |awk '{print $1}'):8080"
echo

