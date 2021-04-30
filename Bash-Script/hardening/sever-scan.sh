#!/bin/bash
# Description: New server  scan
# Author Tia  03/15/2020

rm -rf log*
touch log.$(date +%F)
LOG=log*


function TITLE(){
rm -rf log*
touch log.$(date +%F)
LOG=log*

cat << END


***************************************************************************
*                  NEW SYSTEM SCAN (CENTOS 6 & 7)                         * 
***************************************************************************
   
END
}
TITLE >> $LOG

function tasks(){
rm -rf log*
touch log.$(date +%F)
LOG=log*
cat << END
    BELOW ARE ALL TASK TO BE CHECK ON NEW SERVERS AND CHANGE SOME AS NEED
 ___________________________________________________________________________	        
*  1- Check if the CPU is at least 4000                                     *
*  2- check if the user admin exists on the server, if not create a user    *
*     admin with the password=redhat and give him root privilege            *
*  3- Check if a group helpdesk exists on the server. If not,               *
*      create a group helpdesk, add paul, John, tom (password = "redhat")   *
*      and give them root privilege to reset other users' passwords only.
*      NB: make sure that you expire users account
*  4- Check if the memory is at least 8G                                    *
*  5- Check the first digit of the  Kernel version is at least 3 and above  *
*  6- check if the root file system is not more than 10%                    *
*  7- Check if selinux is set to enforcing, if not enforced it              *
*  8- Check if the OS version is CentOs 6 or 7                              *
*  9- Check if the default runlevel is 3. If not, set it to 3.              *
*  10- Check if cron.allow is present on the server. If not, create it.     *  
*  11- Check if sshd port 22 is open. if yes close                          *
*  12- Change the default ssh port to 29                                    *
*  13- Check if port 8080 is open. If not open port 8080                    *
*  14- check if port 80 is open on the server. If not, open port 80         *
*  15- Check if the password hash is SHA512. If not, change to SHA512       *
*  16- Check if password authentication is set to yes in ssh_config file.   *
*      If no, set it to yes                                                 *
*  17-  Check if the server will require a root for maintenance mode.       *
*       If not, set it to require root password for maintenance mode        *
*  18- Check if the password aging is enforced. If not, enforced            *
*      SET PASS_MAX_DAYS TO 90 DAYS                                         *
*      SET PASS_MIN_LEN TO 8                                                *
*      SET PASS_MIN_LEN TO 0                                                *
*      SET PASS_WARN_AGE TO 14 DAYS                                         *
*  19- Check if the grub password is set. If not, set the grub password.    *
*      The passowrd shoold be "redhat"                                      *
*___________________________________________________________________________*


BELOW IS THE RESULT OF WHAT WAS ON THE NEW AND WAS MODIFIED ON THAT NEW INSTALLED SERVER
END
}
tasks >> $LOG
 

#----------------------------------------------------------------------------------------------------------------------------------------------
function CPU() {
### 1- Check if the CPU is at least 4000

rm -rf log*
touch log.$(date +%F)
LOG=log*


CPU=`lscpu |grep "CPU MHz:" |awk '{print$3}'`
if [[ $CPU -lt 4000 ]] > /dev/null 2>&1 
then 
    echo -e "1- FAILED CPU CHECK, Size insufficient. The CPU size on this server is $CPU\n" >> $LOG
else
    echo -e "1- CPU CHECK PASSED. The CPU size on this server is $CPU\n" >> $LOG
fi
}
#CPU



#----------------------------------------------------------------------------------------------------------------------------------------------
function ADMIN() {
### 2- check if the user admin exists on the server, if not create a user
    # admin with the password=redhat and give him root privilege   

rm -rf log*
touch log.$(date +%F)
LOG=log*

id admin > /dev/null 2>&1 
if [[ $? -eq 0  ]]
then 
    echo -e "2- The Use admin exists already on this server \n" >> $LOG
    cat /etc/passwd | grep ^admin >> $LOG
    cat /etc/sudoers | grep ^admin >> $LOG
    cat /etc/shadow | grep ^admin >> $LOG
else
    useradd admin 
    password=admin@redhat
    echo $password | passwd --stdin admin > /dev/null 2>&1 
    sed -i '/%wheel/aadmin  ALL=(ALL)       ALL' /etc/sudoers

    echo -e "2- Ansadmin user was missing but it now created and added in the sudoers file\n" >> $LOG
    cat /etc/passwd | grep ^admin >> $LOG
    cat /etc/sudoers | grep ^admin >> $LOG
    cat /etc/shadow | grep ^admin >> $LOG
fi
}
ADMIN



#----------------------------------------------------------------------------------------------------------------------------------------------
function HELPDESK() {
## 3- Check if a group helpdesk exists on the server. If not,               
      # create a group helpdesk, add paul, John, tom (password = "redhat")   
      # and give them root privilege to reset other users' passwords only. 

rm -rf log*
touch log.$(date +%F)
LOG=log* 

GROUP_HELPDESK=`cat /etc/group |grep helpdesk |awk -F: '{print$1}'`
if [ "$GROUP_HELPDESK" = "helpdesk" ]
then
    echo -e "3- Group Helpdesk exists already\n" >> $LOG
    cat /etc/group |grep helpdesk >> $LOG
    cat /etc/sudoers |grep helpdesk >> $LOG
    cat /etc/shadow |egrep -i 'paul|tom|John' >> $LOG
else
    groupadd helpdesk 

    cd /tmp
    echo "paul" >> users.txt
    echo "john" >> users.txt
    echo "tom" >> users.txt

    username=$(cat /tmp/users.txt)
    password=$username@redhat

    for users in $username
    do
    useradd $users
    echo $password | passwd --stdin $users
    passwd --expire $users
    usermod -aG helpdesk $users
    done

    sed -i '/^%helpdesk/d' /etc/sudoers
    sed -i '/NOPASSWD: ALL/%helpdesk ALL=/usr/bin/passwd' /etc/sudoers
    rm -rf /tmp/users.txt

    echo -e "3- Group helpdesk was missing and it is know added on this server\n" >> $LOG
    cat /etc/group |grep helpdesk >> $LOG
    cat /etc/sudoers |grep helpdesk >> $LOG
    cat /etc/shadow |egrep -i 'paul|tom|John' >> $LOG
fi
}
HELPDESK



#----------------------------------------------------------------------------------------------------------------------------------------------
function MEMORY_CHECK() {
### 4- Check if the memory is at least 8G

rm -rf log*
touch log.$(date +%F)
LOG=log* 

MEMORY=`free -m |grep "Mem:" |awk '{print$2}'`
if [[ $MEMORY -le 8096 ]]
then
    echo -e "4- MEMORY CHECK FAILED. We have only $MEMORY instead of 8096\n" >> $LOG
else
    echo -e "4- MEMORY CHECK PASSED and the total Memory is $MEMORY on this server\n" >> $LOG
fi
}
MEMORY_CHECK



#----------------------------------------------------------------------------------------------------------------------------------------------
function KERNEL() {
### 5- Check the first digit of the  Kernel version is at least 3 and above

rm -rf log*
touch log.$(date +%F)
LOG=log*

KERNEL_VERSION=`uname -r |cut -d. -f1-2`
if [[ $KERNEL_VERSION -lt 3 ]] > /dev/null 2>&1 
then
    echo -e "5- KERNEL CHECK FAILED. The kernel version on the server is $KERNEL_VERSION\n" >> $LOG
else
    echo -e "5- KERNEL CHECK PASSED and The kernel version on the server is $KERNEL_VERSION\n" >> $LOG
fi
}
KERNEL



#----------------------------------------------------------------------------------------------------------------------------------------------
function FILE_SYSTEM() {
### 6- check if the root file system is not more than 10%

rm -rf log*
touch log.$(date +%F)
LOG=log*

ROOT_FILE=`df -mh |grep "/dev/" |head -1 |awk '{print$5}' |awk -F% '{print$1}'`
if [[ $ROOT_FILE -le 10 ]] 
then
    echo -e "6- THE ROOT FILE SYSTEM PASSED and the percentage of the root file system on the server is $ROOT_FILE%\n" >> $LOG
else
    echo -e "6- THE ROOT FILE SYSTEM FAILED and the percentage of the root file system on the server is $ROOT_FILE%\n" >> $LOG
fi
}
#FILE_SYSTEM



#----------------------------------------------------------------------------------------------------------------------------------------------
function SELINUX() {
### 7- Check if selinux is set to enforcing, if not enforced it

rm -rf log*
touch log.$(date +%F)
LOG=log*

SELINUX=`cat /etc/sysconfig/selinux |grep ^SELINUX |head -1 |awk -F= '{print$2}'`
if [[ $SELINUX == "enforcing" ]]
then
    echo -e "7- SELINUX CHECK PASSED\n" >> $LOG
else
    sed -i '/^SELINUX/d' /etc/sysconfig/selinux
    sed -i '/#     disabled - No SELinux policy is loaded./aSELINUX=enforcing' /etc/sysconfig/selinux
    echo -e "7- SELINUX CHECK FAILED. Selinux was set to $SELINUX mode and it now set to ENFORCING mode\n " >> $LOG
fi
}
#SELINUX



#----------------------------------------------------------------------------------------------------------------------------------------------
function OS {
OS_VERSION6=`cat /etc/*release |head -1 |awk '{print$3}'`
OS_VERSION7=`cat /etc/*release |grep "CentOS Linux release" |head -1 |awk '{print$4}' |cut -d. -f1-2`
if [[ $OS_VERSION6 -le 7 ]]
then
    echo -e "The OS Version is CentOs $OS_VERSION6\n" >> $LOG
elif [[ $OS_VERSION7 -le 7 ]]
then
    echo -e "The OS Version is CentOs $OS_VERSION7\n" >> $LOG
else
    echo -e "OS VERSION CHECK FAILED\n"
fi
}



#----------------------------------------------------------------------------------------------------------------------------------------------
function OS_VERSION() {
### 8- Check if the OS version is CentOs 6 or 7
# NB: This function will not works

rm -rf log*
touch log.$(date +%F)
LOG=log*

OS_VERSION=`rpm -qf /etc/redhat-release |awk -F- '{print$3}'`
if [[ $OS_VERSION -le 7 ]]
then
    echo -e "8- The OS Version is CentOs $OS_VERSION\n" >> $LOG
elif [[ $OS_VERSION -ge 7 ]]
then
    echo -e "8- The OS Version is CentOs $OS_VERSION\n" >> $LOG
else
    echo -e "8- OS VERSION CHECK FAILED\n" >> $LOG
fi
}
#OS_VERSION



#----------------------------------------------------------------------------------------------------------------------------------------------
function RUNLEVEL() {
### 9- Check if the default runlevel is 3. If not, set it to 3.

rm -rf log*
touch log.$(date +%F)
LOG=log*

OS_VERSION=`rpm -qf /etc/redhat-release |awk -F- '{print$3}'`
RUNLEVEL=`runlevel |awk '{print$2}'`
if [[ $RUNLEVEL -eq 3 ]]
then 
    echo -e "9- DEFAULT RUNLEVEL CHECK PASSED. The default runlevel is 3\n" >> $LOG
elif [[ $OS_VERSION -le 7 ]]
then
    sed -i '/id:5:initdefault:/d' /etc/inittab
    echo "id:3:initdefault:" >> /etc/inittab
    echo -e "8- The default Runlevel was $RUNLEVEL, and it was changed the runlevel 3.\nAlso, the OS version was Centos $OS_VERSION\n" >> $LOG
elif [[ $OS_VERSION -ge 7 ]]
then
    # systemctl set-default <name of target>.target
    # systemctl set-default graphical.target 
    systemctl set-default multi-user.target
    echo -e "9- The default Runlevel was $RUNLEVEL, and it was changed the runlevel 3\nAlso, the OS version was Centos $OS_VERSION\n" >> $LOG
else
    echo "9- Unable to change the default runlevel. Please check the OS version" >> $LOG
fi
}
#RUNLEVEL



#----------------------------------------------------------------------------------------------------------------------------------------------
function CRON.ALLOW() {
### 10- Check if cron.allow is present on the server. If not, create it.

rm -rf log*
touch log.$(date +%F)
LOG=log*

cat /etc/cron.allow > /dev/null 2>&1 
if [[ $? -eq 0  ]]
then 
    echo -e "10- CROW.ALLOW CHECK PASSED\n" >> $LOG
else
    cd /etc
    touch cron.allow
    echo -e "10- CROW.ALLOW file was missing and it now created\n" >> $LOG
fi
}
#CRON.ALLOW



#----------------------------------------------------------------------------------------------------------------------------------------------
function CHECK_PORT22() {
### 11-  Check if sshd port 22 is open. If yes, close port 22

OS_VERSION=`rpm -qf /etc/redhat-release |awk -F- '{print$3}'`
IPTABLES_PORT22=`cat /etc/sysconfig/iptables |grep 22 |awk '{print$12}'`
PORT_22=`netstat -ltnp |grep ssh |head -1 |awk '{print$4}' |awk -F. '{print$4}' |cut -d: -f2`
rm -rf log*
touch log.$(date +%F)
LOG=log*

if [ $OS_VERSION -lt 7 ] && [ $IPTABLES_PORT22 -eq 22 ] > /dev/null 2>&1 
then
    sed -i /'22'/d /etc/sysconfig/iptables
    service iptables restart
    echo -e "11- PORT 22 was opened on this server and it now closed\n" >> $LOG

elif [ $OS_VERSION -gt 7 ]  
then 
    sed -i /'22'/d /etc/sysconfig/iptables
    systemctl restart iptables.service
    echo -e "11- PORT 22 was opened on this server and it now closed\n" >> $LOG

elif [ $OS_VERSION -gt 7 ]  > /dev/null 2>&1 
then 
    # firewall-cmd --list-ports
    # firewall-cmd --zone=public --permanent --add-port=22/tcp (add port)
    # firewall-cmd --zone=public --permanent --remove-port=5555/tcp (remove port)
    # firewall-cmd --reload

    systemctl enable firewalld.service
    systemctl start firewalld.service
    systemctl stop firewalld
    systemctl disable firewalld
    systemctl mask --now firewalld
    yum -y install iptables-services
    systemctl start iptables
    systemctl start ip6tables
    systemctl enable iptables
    systemctl enable ip6tables

    sed -i /'22'/d /etc/sysconfig/iptables
    systemctl restart iptables.service
    echo -e "11- PORT 22 was opened on this server and it now closed\n" >> $LOG
else
    echo -e "11- PORT 22 was not opened on this server\n" >> $LOG
fi
}
CHECK_PORT22









#----------------------------------------------------------------------------------------------------------------------------------------------
### 12- Change the default ssh port to 29
# ssh -p 29 root@10.0.0.36
function CENTOS6() {

rm -rf log*
touch log.$(date +%F)
LOG=log*

# && = AND
# || = OR
OS_VERSION=`rpm -qf /etc/redhat-release |awk -F- '{print$3}'`
SSH_PORT=`cat /etc/ssh/sshd_config |grep -i "^port 29"`
IPTABLES_PORT29=`cat /etc/sysconfig/iptables |grep 29 |awk '{print$12}'`
if [ "$SSH_PORT" = "port 29" ] && [ $OS_VERSION -eq 6 ] && [ $IPTABLES_PORT29 -eq 29 ]
then
    echo -e "12- PORT 29 is already set as SSH default port in /etc/ssh/sshd_config and it open already in the iptables\n" >> $LOG
else
    sed -i '/#Port 22/a \port 29' /etc/ssh/sshd_config
    service sshd restart

    sed -i '/-A INPUT -i lo -j ACCEPT/a \-A INPUT -m state --state NEW -m tcp -p tcp --dport 29 -j ACCEPT' /etc/sysconfig/iptables
    service iptables restart
    echo -e "12- PORT is now the default SSH port , and it open on the firewall \n" >> $LOG
fi
}

function CENTOS7() {

rm -rf log*
touch log.$(date +%F)
LOG=log*

OS_VERSION=`rpm -qf /etc/redhat-release |awk -F- '{print$3}'`
SSH_PORT=`cat /etc/ssh/sshd_config |grep -i "^port 29"`
IPTABLES_PORT29=`cat /etc/sysconfig/iptables |grep 29 |awk '{print$12}'`
if [ "$SSH_PORT" = "port 29" ] && [ $OS_VERSION -eq 7 ] && [ $IPTABLES_PORT29 -eq 29 ]
then
    echo -e "12- PORT 29 is already set as SSH default port in /etc/ssh/sshd_config and it open already in the iptables\n" >> $LOG
else
    systemctl stop firewalld
    systemctl disable firewalld
    systemctl mask --now firewalld
    yum -y install iptables-services
    systemctl start iptables
    systemctl start ip6tables
    systemctl enable iptables
    systemctl enable ip6tables

    sed -i '/#Port 22/a \port 29' /etc/ssh/sshd_config
    systemctl restart sshd.service

    sed -i '/-A INPUT -i lo -j ACCEPT/a \-A INPUT -m state --state NEW -m tcp -p tcp --dport 29 -j ACCEPT' /etc/sysconfig/iptables
    systemctl restart iptables.service
    echo -e "12- PORT is now the default SSH port , and it open on the firewall \n" >> $LOG
fi
}

OS_VERSION=`rpm -qf /etc/redhat-release |awk -F- '{print$3}'`
if [ $OS_VERSION -eq 7 ]
then
    CENTOS7
elif [ $OS_VERSION -eq 6 ]
then
    CENTOS6
else
    echo -e "12- Please check your OS distribution and version.\n" >> $LOG
fi



#----------------------------------------------------------------------------------------------------------------------------------------------
### 13- Check if port 8080 is open. If not open port 8080 
### 14- check if port 80 is open on the server. If not, open port 80

function IPTABLES_PORT_6() {

rm -rf log*
touch log.$(date +%F)
LOG=log*

OS_VERSION=`rpm -qf /etc/redhat-release |awk -F- '{print$3}'`
IPTABLES_PORT8080=`cat /etc/sysconfig/iptables |grep 8080 |awk '{print$12}'`
IPTABLES_PORT80=`cat /etc/sysconfig/iptables |grep 80 |awk '{print$12}'`
if [ $IPTABLES_PORT8080 -eq 8080 ] && [ $IPTABLES_PORT80 -eq 80 ] > /dev/null 2>&1
then
    echo -e "13 & 14- PORT 8080 and PORT 80 is already in the iptables\n" >> $LOG
else
    sed -i '/-A INPUT -i lo -j ACCEPT/a \-A INPUT -m state --state NEW -m tcp -p tcp --dport 8080 -j ACCEPT' /etc/sysconfig/iptables
    sed -i '/-A INPUT -i lo -j ACCEPT/a \-A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT' /etc/sysconfig/iptables
    echo -e "13 & 14- PORT 8080 and PORT 80 was not opened on the firewall and it know open \n" >> $LOG
    service iptables restart
fi
}


function IPTABLES_PORT_7() {

rm -rf log*
touch log.$(date +%F)
LOG=log*

OS_VERSION=`rpm -qf /etc/redhat-release |awk -F- '{print$3}'`
IPTABLES_PORT8080=`cat /etc/sysconfig/iptables |grep 8080 |awk '{print$12}'`
IPTABLES_PORT80=`cat /etc/sysconfig/iptables |grep 80 |awk '{print$12}'`
if [ $IPTABLES_PORT8080 -eq 8080 ] && [ $IPTABLES_PORT80 -eq 80 ]
then
    echo -e "13 & 14- PORT 8080 and PORT 80 is already in the iptables\n" >> $LOG
else
    sed -i '/-A INPUT -i lo -j ACCEPT/a \-A INPUT -m state --state NEW -m tcp -p tcp --dport 8080 -j ACCEPT' /etc/sysconfig/iptables
    sed -i '/-A INPUT -i lo -j ACCEPT/a \-A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT' /etc/sysconfig/iptables
    echo -e "13 & 14- PORT 8080 and PORT 80 was not opened on the firewall and it know open \n" >> $LOG
    systemctl restart iptables.service
fi
}

OS_VERSION=`rpm -qf /etc/redhat-release |awk -F- '{print$3}'`
if [ $OS_VERSION -eq 7 ]
then
    IPTABLES_PORT_7
elif [ $OS_VERSION -eq 6 ]
then
    IPTABLES_PORT_6
else
    echo -e "13 & 14- Please check your OS distribution and version.\n" >> $LOG
fi




#----------------------------------------------------------------------------------------------------------------------------------------------
function PASSWORD_HASH() {
## 15- Check if the password hash is SHA512. If not, change to SHA512

# authconfig --passalgo=md5 --update
# authconfig --passalgo=sha256 --update
# authconfig --passalgo=sha512 --update
# cat /etc/login.defs

rm -rf log*
touch log.$(date +%F)
LOG=log*

useradd test > /dev/null 2>&1 
password=admin@test12345
echo $password | passwd --stdin test > /dev/null 2>&1

PASSED_HASH=`cat /etc/shadow |grep test |awk -F: '{print$2}' |awk -F$ '{print$2}'`
if [ $PASSED_HASH -eq 6 ]
then
    echo -e  "15- The password HASH was already set to SHA512\n" >> $LOG
    userdel -r test
else
    authconfig --passalgo=sha512 --update
    sed -n '/tcpdump/, /print still the end/p' /etc/passwd | awk -F":" '{print$1}' | sed '/tcpdump/d' >> /tmp/users.txt
    
    USERS_LIST=$(cat /tmp/users.txt)
    for USERS in $USERS_LIST
    do
    passwd --expire $USERS
    done
    echo -e "15- The password HASH was not SHA512 and it was changed to SHA512. Also all non root users will be forced to update their password because of passowrd HASH change.\n" >> $LOG
    userdel -r test
    cd /tmp
    rm -rf users.txt
fi
}
#PASSWORD_HASH



#----------------------------------------------------------------------------------------------------------------------------------------------
### 16- Check if password authentication is set to yes in ssh_config file. If no, set it to yes   

function PASSWORD_7() {

rm -rf log*
touch log.$(date +%F)
LOG=log*

PASSWORD_AUTH=`cat /etc/ssh/sshd_config |grep -i ^PasswordAuthentication |awk '{print$2}'`
if [ "$PASSWORD_AUTH" = "yes" ] 
then 
    echo -e "16- PasswordAuthentication is already set to yes\n" >> $LOG
elif [ "$PASSWORD_AUTH" = "no" ]
then 
    sed -i '/PasswordAuthentication no/d' /etc/ssh/sshd_config
    sed -i '/#PermitEmptyPasswords no/a PasswordAuthentication yes' /etc/ssh/sshd_config
    systemctl restart sshd.service
    echo -e "16- PasswordAuthentication was not set to yes and it is now set to yes\n" >> $LOG
else
    echo -e "16- They is a problem here\n" >> $LOG
fi
}

function PASSWORD_6() {

rm -rf log*
touch log.$(date +%F)
LOG=log*

PASSWORD_AUTH=`cat /etc/ssh/sshd_config |grep -i ^PasswordAuthentication |awk '{print$2}'`
if [ "$PASSWORD_AUTH" = "yes" ] 
then 
    echo -e "16- PasswordAuthentication is already set to yes\n" >> $LOG
elif [ "$PASSWORD_AUTH" = "no" ]
then 
    sed -i '/PasswordAuthentication no/d' /etc/ssh/sshd_config
    sed -i '/#PermitEmptyPasswords no/a PasswordAuthentication yes' /etc/ssh/sshd_config
    service sshd restart
    echo -e "16- PasswordAuthentication was not set to yes and it is now set to yes\n" >> $LOG
else
    echo -e "16- They is a problem here\n" >> $LOG
fi
}

OS_VERSION=`rpm -qf /etc/redhat-release |awk -F- '{print$3}'`
if [ $OS_VERSION -eq 7 ]
then
    PASSWORD_7
elif [ $OS_VERSION -eq 6 ]
then
    PASSWORD_6
else
    echo -e "16- Please check your OS distribution and version.\n" >> $LOG
fi



#----------------------------------------------------------------------------------------------------------------------------------------------
### 17- Check if the server will require a root for maintenance mode. 
     #If not, set it to require root password for maintenance mode.

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
	# If you have a slash / in the variable then use different separator
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





#----------------------------------------------------------------------------------------------------------------------------------------------
function PASSWORD_AGING() {
## 18- Check if the password aging is enforced. If not, enforced
        ##SET PASS_MAX_DAYS TO 90 DAYS
        ##SET PASS_MIN_LEN TO 8
        ##SET PASS_MIN_LEN TO 0
        ##SET PASS_WARN_AGE TO 14 DAYS    

PASS_MAX_DAYS=`cat /etc/login.defs |grep ^PASS_MAX_DAYS |awk '{print$2}'`
PASS_MIN_DAYS=`cat /etc/login.defs |grep ^PASS_MIN_DAYS |awk '{print$2}'`
PASS_MIN_LEN=`cat /etc/login.defs |grep ^PASS_MIN_LEN |awk '{print$2}'`
PASS_WARN_AGE=`cat /etc/login.defs |grep ^PASS_WARN_AGE |awk '{print$2}'`

if [ $PASS_MAX_DAYS -eq 90 ] && [ $PASS_MIN_DAYS -eq 0 ] && [ $PASS_MIN_LEN -eq 8 ] && [ $PASS_WARN_AGE -eq 14 ] > /dev/null 2>&1
then 
echo -e "18- Password aging is already set\n" >> $LOG
else
       
    sed -i '/^PASS_MAX_DAYS/d' /etc/login.defs
    sed -i '/^PASS_MIN_DAYS/d' /etc/login.defs
    sed -i '/^PASS_MIN_LEN/d' /etc/login.defs
    sed -i '/^PASS_WARN_AGE/d' /etc/login.defs

    sed -i $"/^# Password aging controls:/aPASS_MAX_DAYS   90\\nPASS_MIN_DAYS   0\\nPASS_MIN_LEN    8\\nPASS_WARN_AGE   14" /etc/login.defs
    echo -e "18- Password aging was not set and it now set\n" >> $LOG
fi
}
#PASSWORD_AGING





#----------------------------------------------------------------------------------------------------------------------------------------------
function GRUB_CENTOS6() {
ClassLinux!#
### 19- Check if the grub password is set. If not, set the grub password. The passowrd shoold be "redhat"     

# grub-crypt: to encrypt the grub password. make the that you encrypt with SHA512
# vim /etc/grub.conf 
# password --encrypted end put the encrypted password below hiddenmenu in this file

rm -rf log*
touch log.$(date +%F)
LOG=log*

GRUB_PASSWORD=`cat /etc/grub.conf |grep "^password --encrypted" |awk '{print$1}'`
if [ "$GRUB_PASSWORD" = "password" ]
then
    echo -e "19- The grub password is already set.\e"
else
    sed -i '/^hiddenmenu/apassword --encrypted $6$Jdv0vS3HBXAbvY.v$oa9rNZYIQSgQscQZjOeoPHQlIM49qb4Ge0bFCMeWqebMm0vAV9yyB5Rei.8Esyn.3xSXqp09ak1AQG.yTqiXG.' /etc/grub.conf
    echo -e "19- The grub password was not set and it is now set.\n"
fi
}
GRUB_CENTOS6

#----------------------------------------------------------------------------------------------------------------------------------------------