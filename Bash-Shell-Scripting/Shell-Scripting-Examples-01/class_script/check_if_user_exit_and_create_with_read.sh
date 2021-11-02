#!/bin/bash

#Description: This script will check if the user exist first. If the user does not exist, it will create the new user and if the user exit already, it should say the user exist already nothing to do

# Author: Tia M
# Date: November 12, 2019
# Modified on:             by:

read -p "Enter the first name: " FIRST_NAME 
read -p "Enter the last name: " LAST_NAME

passwd=`cat /etc/passwd |grep $FIRST_NAME |cut -d: -f1`


if [[ "$passwd" == "$FIRST_NAME" ]]
then
echo "The user $FIRST_NAME $LAST_NAME exist"
cat /etc/passwd |grep $FIRST_NAME
exit 2

else
useradd -c "$FIRST_NAME $LAST_NAME" $FIRST_NAME 2> /dev/null
echo "The user $FIRST_NAME $LAST_NAME was added successfully"
cat /etc/passwd |grep $FIRST_NAME
fi

