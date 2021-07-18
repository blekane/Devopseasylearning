#!/bin/bash

# This script will install apache on centos 5

# Author: Tia M
# Date: October 21, 2019
# Modified on:             by:

function apache(){
echo "Installing apache packages,please wait"
sleep 5
yum install httpd -y

# add the iptables rule for port 80 TCP
sed -i '/22/a\-A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT' /etc/sysconfig/iptables

# start the apache daemonstart the apache daemon
service httpd start

#start the firewall
service iptables restart

# make the apache deamon permanent
chkconfig httpd on

# check if the new port 80 is opened
sleep 10 
echo "Checking all the open ports on this server"
iptables -nL

echo
echo " Use this link to access your Apache server. http://$(hostname -I |awk '{print $1}'):80"
echo

apache
