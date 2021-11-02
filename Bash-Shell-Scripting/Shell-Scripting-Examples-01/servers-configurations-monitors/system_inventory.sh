#! /bin/bash

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

