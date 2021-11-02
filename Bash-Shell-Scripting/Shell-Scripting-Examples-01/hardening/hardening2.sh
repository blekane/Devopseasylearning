#!/bin/bash

## this function will update the system

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
