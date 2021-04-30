#!/bin/bash

## this function will update the system

function tasks(){
cat << END

	1- Network configuration
	2- Update the system
	3- Update or upgrade the Kernel
	4- Enable ssh connection
	4- Change the default runlevel
	5- Rquired root password for maintenance
	6- Stop the server to boot into interactif mode
	7- set the grub password
	9- Enforce Selinux
	12- Disable root login through ssh
	13- Configure a port on the firewall
	13- allow or deny connection from specify host
	14- Enforce password policy
	15- Check if the shadow suite is present on this system
	16- Change password hash
	17- Use sudo to delegate admin access




END
}


function update(){
yum -y update

}

## This function will required root password for maintenance mode

function password_maintenance(){
echo 
read -p "Do you want to set a root password for maintenance mode? yes or no: " ANSWER

VAR1=`cat /etc/sysconfig/init |grep SINGLE |cut -d/ -f3`


if [[ "$ANSWER" = "yes" ]] && [[ "$VAR1" == "sulogin" ]]
then 
cat << END

    *********************************************************************************
    * This system is already set to required the root password for maintenance mode *
    *********************************************************************************

END

elif [[ "$ANSWER" == "yes" ]] && [[ "$VAR1" == "sushell" ]]
then 
	# If you have a slash / in the variable then use different separatori
    	#Switch to use | as separator
    	P="SINGLE=/sbin/sushell"
    	D="SINGLE=/sbin/sulogin"
    
    	sed -i "s|$P|$D|" /etc/sysconfig/init

cat << END

    ****************************************************************************
    * This system is will requiered the root password now for maintenance mode *
    ****************************************************************************

END
    	sleep 6
    	exit 1

elif [[ "$ANSWER" == "no" ]]
then 
    	exit 2

else
    	echo "Ivalid choice"
fi
 
}
password_maintenance
