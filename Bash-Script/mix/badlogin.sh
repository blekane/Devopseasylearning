#! /usr/bin/bash

# root privilege to cat /var/log/secure
if [ "$(whoami)" != "root" ]
then
    sudo -s "$0"
    exit
fi

# cat the log, print column 9, remove duplicate with sort command and redirect the result to users.txt  
cat /var/log/secure | grep "input_userauth_request" | awk '{print $9}' | sort -u > ~/users.txt

# change to home directory
cd ~

# add execute permission
chmod +x users.txt

# for line
wc -l users.txt

# this append the text at the beginning of the line
sed  -i '1i # List of unathorize users:' users.txt

# sed  -i '3i List of unathorize users' users.txt # this append the text at the third line 
# echo  "List of unathorize users" >> users.txt # this append the text at the end of the line

# display the result on the screen
cat users.txt | less

# delete the file in the home directory 
rm -rf ~/users.txt

