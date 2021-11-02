#!/bin/bash

# Author: Tia M
# Date: November 11 , 2019
# Modified on:             by:

#write a script that will check the default runlevel on your system centos 6. if it is equal 5, then the script should change it to 3 but if it is not equal to 5, the script should script should just display the default runlevel

default=`tail -n1 /etc/inittab |cut -d: -f2`

if [[ $default == 5 ]]
then 

echo 'The default runlevel is 5 and we change it to 3'
sed -i "s/id:5:initdefault:/id:3:initdefault:/" /etc/inittab
cat /etc/inittab | tail -n1

else
echo "The default runlevel is $default"

fi
