!/bin/bash

# This script will stop, start, restart, and chech the sshd deamon

# Author: Tia M
# Date: October 21, 2019
# Modified on:             by:

# ;; means we done with the first condition
# * = else or anything els

echo -e "\nPlease make a choice below:   \n
	****************************
	* 1 = service sshd status  *
	* 2 = service sshd start   *
	* 3 = service sshd restart *
	* 4 = service sshd stop    *
	**************************** \n"

echo -n "Enter your choice here:  "

read ans
if [ ${ans} -eq 1 ]
then
  service sshd status

elif [ ${ans} -eq 2 ]
then
service sshd start

elif [ ${ans} -eq 3 ]
then
service sshd restart

elif [ ${ans} -eq 4 ]
then
service sshd stop

else
  echo "Invalid choice"
fi
