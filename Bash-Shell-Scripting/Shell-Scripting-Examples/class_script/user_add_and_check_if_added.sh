#!/bin/bash

# Description: create a user ansible and chech if the user was created successfully with the exit code.

useradd ansible

if [[ $? == 0 ]] 
then 
echo "User added successfully"
cat /etc/passwd |grep ansible
else
echo 'Something went wrong'
fi
