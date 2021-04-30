#!/bin/bash

#Description: This script is to do an inventory of our system and install some dependencies

#Autor:SS10

OS=$(lsb_release -a | grep Description | awk -F":" '{print $2}' | awk  '{print $1 " "  $3}')

VERS=$((uname -a | awk '{print $3}') | awk -F"-" '{print$1}' | awk -F"." '{print$1 "." $2}')

FM=$(free -m | grep Mem | awk '{print$4}')

TM=$(free -m | grep Mem | awk '{print$2}')

DS=$(fdisk -l | grep GB | grep sda | awk '{print$3}')






echo
echo "Now making the inventory of the system"
sleep 2
echo
echo "Checking the Os Version,please wait..."
sleep 4
echo

echo "The Os version of the system is ${OS}"
sleep 2
echo

echo "Checking the kernel version..."
sleep 4
echo

echo "The kernel version is ${VERS}"
sleep 4
echo
echo "Checking the hardwares components..."
sleep 3
echo
echo "The available memory space is ${FM}Mb out of ${TM}Mb for total space"
echo
sleep 2
echo "The disk size is ${DS}GB"
sleep 6
echo
echo "We are now installing some packages..."
sleep 3
echo
echo "Checking,downloading and installing packages, please wait and relax while drinking your coffee..."
echo
yum install samba -y
yum install httpd -y
yum install mysql -y
yum install gcc* -y
yum install finger -y
yum install git -y
echo

echo "All your packages are now installed. Thank you!"
echo

