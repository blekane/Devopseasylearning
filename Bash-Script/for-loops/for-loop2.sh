#!/bin/bash

# Description: This script will pull all the username in /etc/passwd and display the output
# Author: Tia M
# Date: November 5, 2019
# Modified on:             by:


for items in $(sed -n '/tcpdump/, /print still the end/p' /etc/passwd | awk -F":" '{print$1}' | sed '/tcpdump/d'| sort -u);
do
echo "The username is $items"
sleep 3
done
