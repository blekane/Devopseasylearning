#!/bin/bash

#------------------------------------------------------------------------------------------------------#
#					 Description: Firewall configuration			       #
#------------------------------------------------------------------------------------------------------#

usage() {
echo -e "\nThis script need two arguments, the port number and the protocol\n"
echo -e "Exampe: $0 <port> <protocol>\n $0 80 tcp \n"
exit 2
}

d=$1
#transforming string from uppercase to lowercase
x=$d | tr [:upper:] [:lower:]

## Check if port number a digit
case $x in
	''|*[!0-9]*) 
	echo -e "\nPlease provide a valid port number\n"
	exit 3 
	;;
	*) echo 
	;;
esac

## Check if the protocol is a string


## Chech number of arguments

if [[ $# -ne 2 ]]
then
usage
fi

