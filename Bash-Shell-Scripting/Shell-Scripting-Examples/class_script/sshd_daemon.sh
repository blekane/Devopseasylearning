#!/bin/bash

# This script will stop, start, restart, and chech the sshd deamon

# Author: Tia M
# Date: October 21, 2019
# Modified on:             by:

# ;; means we done with the first condition
# * = else or anything else

cat << EOF

	****************************
	* 1 = service sshd status  *
	* 2 = service sshd start   *
	* 3 = service sshd restart *
	* 4 = service sshd stop    *
	****************************
EOF
echo -n "Enter your choice here:  "

read ans 
case ${ans} in 
	1) service sshd status 
	;;
	2) service sshd start
	;;
	3) service sshd restart
	;;
	4) service sshd stop
	;;
	*) echo "invalid choice, please choose between 1, 2, 3 and 4"

esac
