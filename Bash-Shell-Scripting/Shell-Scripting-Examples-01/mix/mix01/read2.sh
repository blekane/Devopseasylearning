#! /bin/bash

# this script will create a user account

# root privilege if the user is not root
if [ "$(whoami)" != "root" ]
then
    sudo -s "$0"
    exit
fi


read -p "Enter the first name: " FIRST_NAME 
read -p "Enter the last name: " LAST_NAME
#read -p "Enter the office number: " OFFICE_NUMBER
#read -p "Enter the celphone number: " CELPHONE
#read -p "Enter the home phone number: " HOMEPHONE

useradd $FIRST_NAME
echo "Enter you password and confirm"
passwd $FIRST_NAME

read FIRST SECOND
chfn -f $LAST_NAME + $FIRST_NAME $FIRST_NAME

