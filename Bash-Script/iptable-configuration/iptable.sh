#!/bin/bash

#Author Tia M  November 2019
#Modify:       by:

#------------------------------------------------------------------------------------------------------#
#					 Description: Firewall configuration			       #
#------------------------------------------------------------------------------------------------------#

usage() {
echo
cat << END
	*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
	*                  >> Firewall configuration<<                                *
	* Enter the port number that you will like to configure: put your port number *    
	* Enter the protocol that you will like to configure: put your protocal       *
    *                                                                             *
	* Example:                                                                    *
	* Enter the port number that you will like to configure: 80                   *
	* Enter the protocol that you will like to configure: tcp or udp              *
	* NB: the protocol most be in lowercase.                                      *
	*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
END
echo
}	

usage

read -p "Enter the port number that you will like to configure: " PORT
read -p "Enter the protocol that you will like to configure: " PROTTOCOL


## Check if port number a digit
case $PORT in
	''|*[!0-9]*) 
	echo -e "\nPlease provide a valid port number\n"
	usage
	exit 2 
	;;
	*) echo " " 
	;;
esac

## Check if the protocol is a string and also check if the protocol is tcp or udp

if [[ $PROTTOCOL = *[!0-9]* ]] && [ "$PROTTOCOL" = "tcp" ] || [ "$PROTTOCOL" = "udp" ]
then
    echo " "
else
    echo "Please provide a valid protocol"
    #usage
fi

## Check if the port exit or not and configure the port if the port does not exit

cd /etc/sysconfig
file=iptables

if [[ $(grep "$PORT" $file) ]] ; then

    echo "Port $PORT exit already. Nothing do to"
else
    sed -i "/:OUTPUT ACCEPT/a \-A INPUT -m state --state NEW -m $PROTTOCOL -p $PROTTOCOL --dport $PORT -j ACCEPT" /etc/sysconfig/iptables
    
    # start the firewall
    echo "Restarting the firewall, please wait ......"
    sleep 5
    echo " "
    service iptables restart

fi 

