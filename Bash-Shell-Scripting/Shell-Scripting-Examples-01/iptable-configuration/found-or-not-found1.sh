#!/bin/bash

## this script will find a particular string or digit in iptables file

cd /etc/sysconfig
port=iptables

if [[ $(grep "$1" $port) ]] ; then
   echo "Found"
else
   echo "Not Found"
fi
