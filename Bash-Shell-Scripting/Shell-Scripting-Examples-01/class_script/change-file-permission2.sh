#!/bin/bash

#Description: write a script that will go in the /var/log directory, and change all directories's permissions to 777 and all the files permissions to 666.


SECURE=`ls -l /var/log/ |awk -F" " '{print $9}'`

for i in $SECURE
do
	cd /var/log/
	if [ -f $i ]
	then
	chmod 666 $i 
	else
	chmod -R 777 $i
	fi
done

 
