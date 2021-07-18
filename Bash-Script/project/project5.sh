#!/bin/bash
groupadd sysadmin; groupadd manager; groupadd shipping; groupadd hr
useradd john
passwd john
usermod -s /sbin/nologin john
usermod -g hr john
usermod -aG shipping,manager,sysadmin john
usermod -u 1500 john


touch /tmp/project5.txt

USERS=`sed -n '/tcpdump/, /print still the end/p' /etc/passwd | awk -F":" '{print$1}' | sed '/tcpdump/d'`
KERNEL=`uname -r |awk -F. '{print $1}'`
MEMORY=`free -mh / |grep Mem: |awk '{print$2}'`
DISKUSAGE=`df -mh /  |tail -1 |awk '{print$2}'`
IP=`ifconfig |grep inet |head -1 |awk '{print$2}'`
NIC=`ifconfig |head -1 |awk -F: '{print$1}'`
SSH=`netstat -ltnp |grep  0.0.0.0:22 | awk '{print$4}' |awk -F: '{print$2}'`

echo -e "Bellow are all the users on this server \n$USERS" >> /tmp/project5.txt
echo "The digit first of the kernel version is: $KERNEL" >> /tmp/project5.txt
echo "The total size of the memory on this server is: $MEMORY" >> /tmp/project5.txt
echo "The total size oof the disk available on this server: $DISKUSAGE" >> /tmp/project5.txt
echo "The IP address of this server is: $IP" >> /tmp/project5.txt
echo "The server NIC is: $NIC" >> /tmp/project5.txt
echo "The SSH port on this server is: $SSH" >> /tmp/project5.txt




# system inventory
platform=`uname -a | cut -d" " -f1`
hostname=`uname -a | cut -d" " -f2`
kernel_version=`uname -a | cut -d" " -f3 | cut -d. -f1-2`
system_arch=`getconf LONG_BIT`
number_of_cpu=`nproc`


echo "The platform of this server is: $platform"
echo "The hostname is: $hostname"
echo "The Kernel version is: $kernel_version"
echo "The system architecture is: $system_arch bit"
echo "The number of CPU on this system is: $number_of_cpu"



