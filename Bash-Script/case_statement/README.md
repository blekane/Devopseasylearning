### Example 1
```sh
#!/bin/bash

printf 'Which Linux distribution do you know? '
read DISTR

case $DISTR in
     ubuntu)
          echo "I know it! It is an operating system based on Debian."
          ;;
     centos|Contos|rhel|RHEL)
          echo "Hey! It is my favorite Server OS!"
          ;;
     windows)
          echo "Very funny..."
          ;; 
     *)
          echo "Hmm, seems i've never used it."
          ;;
esac
```

### Example 2
```sh
#!/bin/bash

echo -n "Enter the Linux distro name: "
read DISTRO

case $DISTRO in

  Ubuntu)
    echo -n "Yes, it is based on Debian."
    ;;

  "Linux Mint" | "Elementory OS")
    echo -n "Yes, it is based on Debian."
    ;;

  CentOS | Fedora | RHEL)
    echo -n "No, its not based on Debian"
    ;;

  *)
    echo -n "Can find distro information"
    ;;
esac
```

### Example 3
* This script will stop, start, restart, and chech the sshd deamon
```sh
#!/bin/bash
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
```

### Example 4
```sh
#!/bin/bash
read -p "Enter your choice [yes/no]:" choice
 
case $choice in
     yes|y)
          echo "Thank you"
          echo "Your type: Yes"
          ;;
     no|n)
          echo "Ooops"
          echo "You type: No"
          ;;
     *)
          echo "Sorry, invalid input"
          ;;
esac
```

### Example 5
```sh
#!/bin/bash
read -p "Enter your choice [yes/no]:" choice

case $choice in
     Y|y|Yes|YES|yes)
          echo "Thank you"
          echo "Your type: Yes"
          ;;
     N|n|No|NO|no)
          echo "Ooops"
          echo "You type: No"
          ;;
     *)
          echo "Sorry, invalid input"
          ;;
esac
```