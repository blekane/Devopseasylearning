#! /usr/bin/bash

# This script will pull all non authorize users from /var/log/secure who are trying to login on the Server
# root privilege to cat /var/log/secure
if [ "$(whoami)" != "root" ]
then
    sudo -s "$0"
    exit
fi

# cat the log, print column 9, remove duplicate with sort command and redirect the result to users.txt
cat /var/log/secure | grep "input_userauth_request" | awk '{print $1,$2,$3,$9}' > ~/users.txt

# change to home directory
cd ~

# add execute permission
chmod +x users.txt

# for line
wc -l users.txt

# this append the text at the beginning of the line
sed  -i '1i # List of unathorize users with date and time:' users.txt

# display the result on the screen
cat users.txt | less -MN

# delete the file in the home directory
rm -rf ~/users.txt

exit 0
