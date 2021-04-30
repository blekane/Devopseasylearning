#!/bin/bash

#Author Tia M  November 2019
#Modify:       by:

#---------------------------------------------------------------------#
#		 Description: Firewall configuration			              #
#---------------------------------------------------------------------#

usage() {
echo -e "\nThis script need two arguments, the port number and the protocol\nThe protocol most be lower case letters. It must be either tcp or udp\n"
echo -e "Exampe: $0 <port> <protocol>\n\n $0 80 tcp \n"
echo -e "OR\n"
echo -e "$0 8080 udp \n"
exit 1
}


## Check if port number a digit
case $1 in
	''|*[!0-9]*) 
	echo -e "\nPlease provide a valid port number\n"
	usage
	exit 2 
	;;
	*) echo " " 
	;;
esac

## Check if the protocol is a string and also check if the protocol is tcp or udp

if [[ $2 = *[!0-9]* ]] && [ "$2" = "tcp" ] || [ "$2" = "udp" ]
then
    echo " "
else
    echo "Please provide a valid protocol"
    usage
fi

## Chech number of arguments

if [[ $# -ne 2 ]]
then
usage
fi

## Check if the port exit or not and configure the port if the port does not exit

cd /etc/sysconfig
file=iptables

if [[ $(grep "$1" $file) ]] ; then

    echo "Port $1 exit already. Nothing do to"
else
    sed -i "/:OUTPUT ACCEPT/a \-A INPUT -m state --state NEW -m $2 -p $2 --dport $1 -j ACCEPT" /etc/sysconfig/iptables
    
    # start the firewall
    echo "Restarting the firewall, please wait ......"
    sleep 5
    echo " "
    service iptables restart
    
fi     
