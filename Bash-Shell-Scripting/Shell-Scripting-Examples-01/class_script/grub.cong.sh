#!/bin/bash

# write a script that will check if  in the grub.conf, the default is set to 0. if it is set to 0, it should display "The default is already set to 0 nothing to do" and if it is not 0 , it should go ahead and set it to 0.


t=`cat /etc/grub.conf |grep default |awk -F"=" '{print $2}'`

if [[ $t == 0 ]]
then
echo "The default is already 0"
else
sed -i "s/default=$t/default=0" /etc/grub.conf
fi 


