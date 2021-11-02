#!/bin/bash

#Description: This script is to be use update the linux kernel to the latest version. 
#CAUTION!!! Users should use the kernel version to be install as an argument when running this script on the command line. 

#Date created: 01/26/2019                                      Date Revised: --/--/---                          Revised By: 


CURRENT=$(uname -a | awk '{print $3}')

VERS=$1


echo -e "\n The current kernel version is $CURRENT\n"

echo -e "\n Searching and downloading the new kernel version.....\n"

sleep 3

wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-${VERS}.tar.xz

   if 
         [ $? -eq 0 ]
   then
   echo -e "\n                       Download ${GREEN}SUCCESFUL    ${NONE}          [${GREEN}OK${NONE}] \n"
   else 
   echo -e "\n Failed to download new kernel package   [${RED}${bold}FAILED${NONE}]\n"
   exit 99
   fi
echo -e "\n Extracting the package .....\n"

sleep 5

tar -xvf linux-${VERS}.tar.xz

cd linux-${VERS}

echo -e "\n Installing Dependencies, please wait......\n"

sleep 5

yum install "Development Tools" -y

yum install openssl* -y

yum install libncurses5-dev -y

yum install ncurses-devel -y

yum install gcc* -y

echo -e "\n Creating the configuration file....\n"

sleep 5

make defconfig

echo -e "\n Compiling the Kernel, this may be a little while.....\n"

sleep 5

make

make modules

make modules_install

make install

echo -e "\n Setting up the latest kernel as default....\n"

sleep 5

sed -i 's/default=1/default=0/1' /boot/grub/grub.conf


echo -e "\n kernel upgrade was successful!!!!\n"
