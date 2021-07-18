#!/bin/bash

# add user tom and check if the user tom was added successfully

user=tom

passwd=`cat /etc/passwd |grep tom |cut -d: -f1`


if [[ $passwd == 'tom' ]]
then
echo "The user tom exist"
cat /etc/passwd |grep tom
exit 2

else
useradd $user 2> /dev/null
echo 'The user tom was added successfully'
cat /etc/passwd |grep tom
fi

