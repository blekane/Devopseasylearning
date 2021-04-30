#!/bin/bash

# Description: This script will check if the user running the script is root or not
# Author: Tia M
# Date: October 21, 2019
# Modified on:             by:

# -e to escape the \n
# if you do not put exit, the script will continue if not root or we want the script to exit if not root

if [ $UID -ne 0 ]
then
        echo -e "\nPlease, you need root access to run this script.....\n"
        exit 1
fi

