#!/bin/bash

# Description: write the script that will check the first digit of the kernel version. if it is less that 5, update the kernel. else, display the system is up to date.

ker=`uname -r |cut -d. -f1`

if [[ $ker -lt 5 ]]
then

echo 'The kernel need to be update and put all the dependecies here'

else
echo 'The Kernel is up to date'

fi


