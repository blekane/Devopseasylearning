#! /bin/bash

#Description: This script is to do an inventory of our system
# Author: Tia M
# Date: October 30, 2019
# Modified on:             by:

platform=`uname -a | cut -d" " -f1`
hostname=`uname -a | cut -d" " -f2`
kernel_version=`uname -a | cut -d" " -f3 | cut -d. -f1-2`
system_arch=`getconf LONG_BIT`
number_of_cpu=`nproc`
users=`sed -n '/tcpdump/, /print still the end/p' /etc/passwd | awk -F":" '{print$1}' | sed '/tcpdump/d' | sort -u`
ip_address=`ifconfig |grep  broadcast| head -n1 |awk -F" " '{print $2}'`
FM=$(free -m | grep Mem | awk '{print$4}')
TM=$(free -m | grep Mem | awk '{print$2}')
DS=$(fdisk -l | grep GB | grep sda | awk '{print$3}')
OS=$(lsb_release -a | grep Description | awk -F":" '{print $2}' | awk  '{print $1 " "  $3 " " $4}')

echo
sleep 2
echo "The platform of this server is: $platform"
 
echo
sleep 2
echo "The hostname is: $hostname"

echo
sleep 2
echo "The Kernel version is: $kernel_version"

echo
sleep 2
echo "The system architecture is: $system_arch bit"

echo
sleep 2
echo "The number of CPU on this system is: $number_of_cpu"

echo
echo "Checking all the users on this server,please wait..."
sleep 4
echo -e "This is the list of all the users on this server:\n $users"

echo
sleep 2
echo "The address of this server is: $ip_address"

sleep 3
echo
echo "The available memory space is ${FM}Mb out of ${TM}Mb for total space"

echo
sleep 2
echo "The disk size is ${DS}GB"

echo
sleep 2
echo "The Os version of the system is ${OS}"
