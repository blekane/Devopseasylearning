#!/bin/bash
read -p "Enter String Uppercase : " i
o=$(echo "$i" | tr '[:upper:]' '[:lower:]')
echo $o

read -p "Enter String Uppercase : " e
P=`echo "$e" | tr '[A-Z]' '[a-z]'`
echo $P
