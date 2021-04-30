#!/bin/bash
 
# Author: Tia M
# Date: April 5, 2020
# Modified on:             by:

# This script will install apache on centos 7
 
function apache(){
echo "Installing apache packages,please wait"
sleep 5
yum install httpd -y

# To install the iptable 
systemctl stop firewalld
systemctl disable firewalld
systemctl mask --now firewalld
yum -y install iptables-services
systemctl start iptables
systemctl start ip6tables
systemctl enable iptables
systemctl enable ip6tables

# add the iptables rule for port 80 TCP
sed -i '/22/a\-A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT' /etc/sysconfig/iptables
 
# start the apache daemon start the apache daemon
systemctl restart httpd.service
 
#start the firewall
systemctl restart iptables
 
# check if the new port 80 is opened
sleep 10 
echo "Checking all the open ports on this server"
iptables -nL
 
echo " "
echo " Use this link to access your Apache server. http://$(hostname -I |awk '{print $1}'):80"
echo " "
}
apache