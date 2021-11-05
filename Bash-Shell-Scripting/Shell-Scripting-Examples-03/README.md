

```sh
# Display the UID
echo "Your UID is ${UID}"

# Display the username
USER_NAME=$(id -u)
echo "Your username is ${USER_NAME}"

# Display if the user is the root user or not.
if [[ "${UID}" -eq 0 ]]
then
  echo 'You are root.'
else
  echo 'You are not root.'
fi

#------------------------------------------------------------

#!/bin/bash

read -p 'Enter the username to create: ' USER_NAME
read -p 'Enter the name of the person who this account is for: ' COMMENT
read -p 'Enter the password to use for the account: ' PASSWORD
useradd -c "${COMMENT}" -m ${USER_NAME}
#    echo "${USER_NAME}:${PASSWORD}" | chpasswd
if [[ "${?}" -ne 0 ]]
then
  echo 'The account could not be created.'
  exit 1
fi

echo ${PASSWORD} | passwd --stdin ${USER_NAME}
# Check to see if the passwd command succeeded.
if [[ "${?}" -ne 0 ]]
then
  echo 'The password for the account could not be set.'
  exit 1
fi

passwd -e ${USER_NAME}

#------------------------------------------------------------

#!/bin/bash

IPLIST="path_to_the_Ip_list_file"

for ip in $(cat $IPLIST)

do
   ping -c1 $ip &> /dev/null
   if [ $? -eq 0 ]
   then
   echo $ip ping passed
   else
   echo $ip ping failed
   fi
done

#------------------------------------------------------------
# Create files with older timestamp
touch -d "Thu, 1 March 2018 12:30:00" a
touch -d "Thu, 1 March 2018 12:30:00" b
touch -d "Thu, 1 March 2018 12:30:00" c

# Find and delete files older than 90 days
find /path-to-dir -mtime +90 -type f -exec ls -l {} \;
find /root -mtime +90 -type f -exec ls {} \;
find . -mtime +90 -exec ls {} \;

find /root -mtime +90 -type f -exec rm -rf {} \;
find . -mtime +90 -exec rm -rf {} \;

# Find and rename old files
find . -mtime +90 -exec mv {} {}.old \;
find /root -mtime +90 -type f -exec mv {} {}.old \;
find . -mtime +90 -exec ls {} \;

#------------------------------------------------------------

# Create backup (we want to backup /etc and /var dir)
tar cvf /tmp/backup.tar /etc /var

# Compress backup
gzip /tmp/backup.tar

#Backup /etc and /var filesystem
#!/bin/bash

tar cvf /tmp/backup.tar /etc /var
gzip /tmp/backup.tar
rm -rf /tmp/backup.tar
# `-1` means if it was created today or find all backup.tar.gz that was created today
find backup.tar.gz -mtime -1 -type f -print &> /dev/null
if [ $? -eq 0 ]
then
    echo Backup was created
    echo
    echo Archiving backup
    scp /tmp/backup.tar.gz root@192.168.1.x:/path
else
    echo Backup failed
fi
#------------------------------------------------------------

# Simple counting:
#!/bin/bash
for i in {1..25}
do
	sleep 
	echo $i
done
#------------------------------------------------------------

# Create multiple files with different names
#!/bin/bash
for i in {1..10}
do
    touch imran.$i
done
#------------------------------------------------------------

# Assign write permissions to files
#!/bin/bash
for i in imran*
do
	echo Assigning write permissions to $i
    chmod a+w $i
	sleep 1
done
#------------------------------------------------------------

# Rename all *.txt files extension to none
#!/bin/bash
for filename in *.txt
do
    mv $filename ${filename%.txt}.none
done
#------------------------------------------------------------

# Check to see if files exist
#!/bin/bash

# List of files you are curious about
FILES="
/etc/passwd
/etc/group
/etc/shadow
/etc/nsswitch.conf
/etc/sshd_ssh_config
/etc/fake"

echo
for file in $FILES
do
	if [[ ! -e $file ]]       # Check if file exists.
	then
	    echo "$file does not exist"
	    echo
	fi
done
#------------------------------------------------------------

# Copy Files to Remote Hosts
#!/bin/bash
for HOST in ubuntu01 fedora02 centos03 rhel06
do
	scp somefile $HOST:/var/tmp/
done
#------------------------------------------------------------

# Script for Central Logging
#!/bin/bash
# n0 = just incoming messages
tail -fn0 /var/log/messages | while read line
do
	echo $line | grep -E -i "refused|invalid|error|fail|lost|shut|down|offline"
    # echo $line | egrep -i "refused|invalid|error|fail|lost|shut|down|offline"
        if [ $? = 0 ] # This means if it find any of the below key words
        then
        echo $line >> /tmp/filtered-messages
        fi
done

# Run script in the background:
nohup /root/logtail &&
#------------------------------------------------------------


# Notification
vi 
/root/Log-Alert

#!/bin/bash
systems="imran_ny@hotmail.com,charles.gorden@email.com"
if [ -s /tmp/filtered-messages ] # -s = check if the file exist in /tmp/filtered-messages
then
    cat /tmp/filtered-messages | sort -u | mail -s "CHECK: Syslog Errors" $# cat /tmp/filtered-messages | sort -u | mail -s "CHECK: Syslog Errors" $systems
    rm /tmp/filtered-messages
else
fi

# Schedule the Notification to run every 15 minutes:
*/15 * * * * /root/Log-Alert

#------------------------------------------------------------

# Create User Account
#!/bin/bash

echo "Please provide a username?"
read u
echo

useradd $u
echo $u account has been created
#------------------------------------------------------------

# Error out if user exist
 #!/bin/bash

echo "Please provide a username?"
read u
echo

grep -q $u /etc/passwd
        if [ $? -eq 0 ]
        then
        echo ERROR -- User $u already exist
        echo Please choose another username
        echo
        exit 0
        fi

useradd $u
echo $u account has been created
#------------------------------------------------------------

# Add user description
#!/bin/bash

echo "Please provide a username?"
read u
echo

grep -q $u /etc/passwd
        if [ $? -eq 0 ]
        then
        echo ERROR -- User $u already exist
        echo Please choose another username
        echo
        exit 0
        fi


echo "Please provide user description?"
read d
echo

useradd $u -c "$d"
echo $u account has been created
#------------------------------------------------------------

# Add User ID
#!/bin/bash

echo "Please provide a username?"
read u
echo

grep -q $u /etc/passwd
        if [ $? -eq 0 ]
        then
        echo ERROR -- User $u already exist
        echo Please choose another username
        echo
        exit 0
        fi


echo "Please provide user description?"
read d
echo

echo "Do you want to specify user ID (y/n)?"
read ynu
echo
        if [ $ynu == y ]
        then
        echo "Please enter UID?"
        read uid

        useradd $u -c "$d" -u $uid
        echo
        echo $u account has been created

        elif [ $ynu == n ]
        then
        echo No worries we will assign a UID
        useradd $u -c "$d"
        echo
        echo $u account has been created
        fi
#------------------------------------------------------------

# Add User ID check
#!/bin/bash

echo "Please provide a username?"
read u
echo

grep -q $u /etc/passwd
        if [ $? -eq 0 ]
        then
        echo ERROR -- User $u already exist
        echo Please choose another username
        echo
        exit 0
        fi

echo "Please provide user description?"
read d
echo

echo "Do you want to specify user ID (y/n)?"
read ynu
echo
        if [ $ynu == y ]
        then
        echo "Please enter UID?"
        read uid
                grep -q $uid /etc/passwd
                if [ $? -eq 0 ]
                then
                echo ERROR -- UserID $uid already exist
                echo
                exit 0
                else
                useradd $u -c "$d" -u $uid
                echo
                echo $u account has been created
                fi
        elif [ $ynu == n ]
        then
        echo No worries we will assign a UID
        useradd $u -c "$d"
        echo
        echo $u account has been created
        fi
#------------------------------------------------------------

# Script to disable users accounts
# Test Commands
lastlog -b 90 # users who have not login for 90 days
useradd test1
useradd test2
lastlog -b 90 | tail -n+2 | grep 'test' | awk '{print $1}'
lastlog -b 90 | tail -n+2 | grep 'test' | awk '{print $1}'

# Disable account with For loop
#!/bin/bash

a=`lastlog | tail -n+2 | grep 'test' | awk '{print $1}'`

for i in $a
do
usermod -L $i
done

# Disable using xargs
lastlog | tail -n+2 | grep 'test' | awk '{print $1}' |
  xargs -I{} echo {}

lastlog | tail -n+2 | grep 'test' | awk '{print $1}' |
  xargs -I{} usermod -L {}


# Delete
#!/bin/bash
a=`lastlog | tail -n+2 | grep 'test' | awk '{print $1}'`

a=`lastlog | 
tail -n+2 | 
grep 'test' | 
awk '{print $1}'`

a=`lastlog | 
    tail -n+2 | 
    grep 'test' | 
    awk '{print $1}'`

for i in $a
do
userdel -r $i
done

lastlog | tail -n+2 | grep 'test' | awk '{print $1}' |
  xargs -I{} userdel {}

lastlog | tail -n+2 | grep 'test' | awk '{print $1}' | xargs -I{} userdel {}

lastlog | 
tail -n+2 | 
grep 'test' | 
awk '{print $1}' | 
xargs -I{} userdel {}

lastlog | 
    tail -n+2 | 
    grep 'test' | 
    awk '{print $1}' | 
    xargs -I{} userdel {}


lastlog | tail -n+2 | 
    grep 'test' | 
    awk '{print $1}' | 
    xargs -I{} userdel {}
#------------------------------------------------------------

find /home/aaronkilik/Documents/ -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.deb" -o -name ".pdf" \)
find . -type f \( -name "*.sh" -o -name "*.txt" \)
find . -type f \( -name "*.sh" \)
find . -type f \( -name "*.txt" \)

find /home/aaronkilik/Documents/ -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.deb" -o -name ".pdf" \) | xargs -I{} rm -rf {}

find /home/aaronkilik/Documents/ -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.deb" -o -name ".pdf" \) | 
xargs -I{} rm -rf {}


find . -type f \( -name "*.sh" -o -name "*.txt" \) | xargs -I{} rm -rf {}
find . -type f \( -name "*.sh" \) | xargs -I{} rm -rf {}
find . -type f \( -name "*.txt" \) | xargs -I{} rm -rf {}
#------------------------------------------------------------

# Check if a process is running and kill it
#!/bin/bash
sleep 600 &

# Run commands
ps -ef | grep "sleep 600"
ps -ef | grep "sleep 600" | grep -v grep 
ps -ef | grep "sleep 600" | grep -v grep | awk '{print $2}' 
ps -ef | grep "sleep 600" | grep -v grep | awk '{print $2}' | xargs -I{} echo {}
ps -ef | grep "sleep 600" | grep -v grep | awk '{print $2}' | xargs -I{} kill {}

ps -ef | 
    grep "sleep 600" | 
    grep -v grep | 
    awk '{print $2}' | 
    xargs -I{} kill {}

# Create a script
#!/bin/bash
ps -ef | grep "sleep 600" | grep -v grep | awk '{print $2}' | xargs -I{} kill {}
echo "All sleeping processes are killed"
#------------------------------------------------------------


# Disk Space Check
# Check the filesystem 
df -h

# Remove un-wanted rows
df -h | egrep -v "Filesystem|tmpfs"

# Get 5th and 6th column
df -h | egrep -v "Filesystem|tmpfs" | awk '{print $5, $6}'
df -h | egrep -v "tmpfs|devtmpfs" | tail -n+2 | awk '{print $5}' | cut -d'%' -f1


# First For loop script
# vi checkdisk
#!/bin/bash

a=`df -h | egrep -v "tmpfs|devtmpfs" | tail -n+2 | awk '{print $5}' | cut -d'%' -f1`

for i in $a
do
        if [ $i -ge 50 ]
        then
        echo Check disk space $i 
        fi
done

# Another way:
#!/bin/sh

df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{print $5,$1}' | while read output
do
        usep=$(echo $output | awk '{print $1}' | cut -d'%' -f1  )
        partition=$(echo $output | awk '{print $2}' )
        
	if [ $usep -ge 90 ]
	then
        echo "Running out of space \"$partition ($usep%)\" on $(hostname) as on $(date)"
        fi
done


# Or Simply
# Write a script to awk only those rows with the value
df -h | awk '0+$5 >= 10 {print}'
echo
echo Following is the disk space status
echo
df -h | awk '0+$5 >= 10 {print}' | awk '{print $5, $6}'
#------------------------------------------------------------

# Status on Total Number of Files (Send alert if files are less than 20)
# First create 20 files
touch file{1..20}.txt

# Now create a script:
#!/bin/bash

a=`ls -l file* | wc -l`

	if [ $a -eq 20 ]
	then
	echo Yes there are $a files
	else
	echo Files are less than 20
	fi
#------------------------------------------------------------

# Create System Inventory
# Create a file name database

touch "/home/iafzal/ps/"database

# Create 1st script to add record
vi add-record
#!/bin/bash

echo Please enter hostname?
read hostname
echo
        grep -q $hostname "/home/iafzal/ps/"database
        if [ $? -eq 0 ]
        then
        echo ERROR -- Hostname $hostname already exist
        echo
        exit 0
        fi

echo Please enter IP address?
read IP
echo

        grep -q $IP "/home/iafzal/ps/"database
        if [ $? -eq 0 ]
        then
        echo ERROR -- IP $IP already exist
        echo
        exit 0
        fi


echo Please enter Description?
read description
echo
echo $hostname $IP $description >> database


# Create 2nd script to delete record
vi del-record
#!/bin/bash

echo Please enter hostname or IP address?
read host
echo
        grep -q $host "/home/iafzal/ps/"database
        if [ $? -eq 0 ]
        then
        echo
        sed -i '/'$host'/d' "/home/iafzal/ps/"database
        echo $host has been deleted
        else
        echo Record does not exist
        fi

# Create a 3rd script to give option of adding or deleting a record
vi inv-management

#!/bin/bash
echo
echo Please select one of the following options:
echo
echo 'a = Add a record'
echo 'd = Delete a record'
echo
        read choice

                case $choice in
a) "/home/iafzal/ps/"add-record;;
d) "/home/iafzal/ps/"del-record;;
*) echo Invalid choice - Bye.

                esac

#------------------------------------------------------------
# Scripts with Pre-Defined Information
#!/bin/bash
read -r -p "Enter name of script: " script
read -r -p "Whats your fullname: " fname
read -r -p "Whats the description of this script: " description
echo "#!/bin/bash" > ${script}
echo
echo "###########################################" >> ${script}
echo
echo "#Author: " $fname >> ${script}
echo
echo "#Date: " $(date) >> ${script}
echo
echo "#Description: " $description >> ${script}
echo
echo "#Modified: " $(date) >> ${script}
echo
echo "###########################################" >> ${script}
echo
chmod a+x ${script}
vim ${script}



#!/bin/bash
read -r -p "Enter name of script: " script
read -r -p "Whats your fullname: " fname
read -r -p "Whats the description of this script: " description
echo "#!/bin/bash" > ${script}
cat << EOF >> ${script}
###########################################

#Author: " $fname 

#Date: " $(date) 

#Description: " $description 

#Modified: " $(date) 

###########################################
EOF
echo
chmod a+x ${script}
vim ${script}
#------------------------------------------------------------

# Write a script to check if directory exist
#!/bin/bash
directory="./Test"

# bash check if directory exists
if [ -d $directory ]; then
	echo "Directory exists"
else 
	echo "Directory does not exists"
fi
#------------------------------------------------------------

# List Files and Directories with Description
# If you want to list the files in /home directory, you can use the for loop like this:
#!/bin/bash
for obj in /home/yourname/*
do	
if [ -d $obj ]
	then
	echo $obj is a folder
	elif [ -f "$obj" ]
	then
 echo $obj is a file
	fi
done
#------------------------------------------------------------
# xargs
docker ps -q | xargs docker stop
find . -type f -name "*.txt" | xargs -I {} sh -c 'ls -l {}; du -h {}' 
find /tmp -name core -type f -print | xargs /bin/rm -f 
find /home/james  -name "*.txt" -type f -print0 | xargs rm -f
find Pictures/tecmint/ -name "*.png" -type f -print0 | xargs -0 tar -cvzf images.tar.gz
find Downloads -name "DomTerm" -type d -print0 | xargs -0 /bin/rm -v -rf "{}"
find . -name "net_stats" -type f -print0 | xargs -0 /bin/rm -v -rf "{}"
find Pictures/tecmint/ -name "*.png" -type f -print0 | xargs -0 tar -cvzf images.tar.gz