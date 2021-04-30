#!/bin/bash

# checking if an argument in bash script is a string of all digitschecking an argument to a bash script is a string of all digits

if [[ $1 = *[!0-9]* ]]
then 
    echo "'$1' is a string or a combinaison of string and digits"
    exit 1
else
    echo "'$1' is strictly numeric"
fi
