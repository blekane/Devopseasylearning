#!/bin/bash

#Description: create a script that will display the content of the file. The script should prompt the use to enter the path of the file and display the content

# Author: Tia M
# Date: November 12, 2019
# Modified on:             by:

read -p "What is the path of the file you want to display? " FILE

cat $FILE
