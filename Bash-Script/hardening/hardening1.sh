#!/bin/bash

## this function will update the system

function update(){
yum -y update

}

## This function will required root password for maintenance mode

function password_maintenance(){
echo 
read -p "Do you want to set a root password for maintenance mode? yes or no: " ANSWER

VAR1=`cat /etc/sysconfig/init |grep SINGLE |cut -d/ -f3`


if [[ "$ANSWER" = "yes" ]] && [[ "$VAR1" == "sulogin" ]]
then 
    echo
    echo "This system is already set to required a root password for maintenance mode"
    echo

elif [[ "$ANSWER" == "yes" ]] && [[ "$VAR1" == "sushell" ]]
then 
    echo
    echo "Not good. You need to required a root password for maintenance"
    echo
    exit 1

elif [[ "$ANSWER" == "no" ]]
then 
    exit 2

else
    echo "Ivalid choice"
fi
 
#sed -i "s/SINGLE=/sbin/sushell /SINGLE=/sbin/sulogin"

}
password_maintenance
