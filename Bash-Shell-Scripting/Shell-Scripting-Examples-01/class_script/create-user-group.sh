#!/bin/bash

#Description: This script will create a user, group, shell and add the user to a group as primary and secondary group

# Author: Tia M
# Date: November 12, 2019
# Modified on:             by:

read -p "Enter the first name: " FIRST_NAME
read -p "Enter the last name: " LAST_NAME
read -p "Enter the group that you will like to create: " GROUP
read -p "Enter the user shell: " SHELL

groupadd $GROUP
useradd -c "$FIRST_NAME $LAST_NAME" -G $GROUP -g $GROUP -s $SHELL $FIRST_NAME  

echo 
cat /etc/passwd |grep $FIRST_NAME

echo
cat /etc/group |grep $GROUP
