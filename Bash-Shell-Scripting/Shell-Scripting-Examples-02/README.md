## Steps to create any user on Ubuntu server:
```
useradd automation
passwd automation
Check UserHome: ls -lrt /home/automation
if user home is not created then run below two commands:
mkdir -p /home/automation
chown -R automation:automation /home/automation

How to change a shell for the user?
simply run below command and provide the password and path of the required shell as /bin/bash.
Command is: chsh
```


## Configure mail on Ubuntu

1. step1: Get Gmail Id and Password
2. Step2: login into ubuntu and switch to root using: sudo su -
3. Step3:  Run below commands:
```
apt-get update -y
apt-get install sendmail mailutils -y
```
4. Step4: Create authentication file
```sh
cd /etc/mail
mkdir -m 700 authinfo
cd authinfo/
vi gmail

#add the below conntent 
AuthInfo: "U:root" "I:your-mail@gmail.com-here" "P:your-password-here"
#make sure to change your mail id and password
```
5. Step5: create hash map of the file by running the below command:
```
makemap hash gmail < gmail
```
6. Step6: Got to `/etc/mail` and open `sendmail.mc` then Add the following lines to sendmail.mc file right above MAILER_DEFINITIONS:
```sh
#GMail settings:
define(`SMART_HOST',`[smtp.gmail.com]')dnl
define(`RELAY_MAILER_ARGS', `TCP $h 587')dnl
define(`ESMTP_MAILER_ARGS', `TCP $h 587')dnl
define(`confAUTH_OPTIONS', `A p')dnl
TRUST_AUTH_MECH(`EXTERNAL DIGEST-MD5 CRAM-MD5 LOGIN PLAIN')dnl
define(`confAUTH_MECHANISMS', `EXTERNAL GSSAPI DIGEST-MD5 CRAM-MD5 LOGIN PLAIN')dnl
FEATURE(`authinfo',`hash -o /etc/mail/authinfo/gmail.db')dnl
```
7. Step7: Now run below two command from `/etc/mail`
```
make
/etc/init.d/sendmail reload
```
8. Step8: Now open https://www.google.com/settings/security/lesssecureapps
Select your mail and Allow less secure apps: ON
it desable by default

9. Step9: Verify the test mail using
```
echo "Demo" | mail -s "Status of Httpd" dowithscripting@gmail.com
echo "Demo" | mail -s "Status of Httpd" dowithscripting@gmail.com -A demo.txt
```

## Script to send mail when mail is configure
```sh
#!/bin/bash

KERNEL=`uname -r |awk -F. '{print $1}'`
MEMORY=`free -mh / |grep Mem: |awk '{print$2}'`
DISKUSAGE=`df -mh /  |tail -1 |awk '{print$2}'`
IP=`ifconfig |grep inet |head -1 |awk '{print$2}'`
NIC=`ifconfig |head -1 |awk -F: '{print$1}'`
SSH=`netstat -ltnp |grep  0.0.0.0:22 | awk '{print$4}' |awk -F: '{print$2}'`

cat <<EOF | mail -s "$(date '+%d_%m_%y'): report on $(hostname)" "tiajearad@gmail.com"
echo -e "Bellow is the system inventory of server01 \n"
echo "The digit first of the kernel version is: $KERNEL"
echo "The total size of the memory on this server is: $MEMORY"
echo "The total size oof the disk available on this server: $DISKUSAGE"
echo "The IP address of this server is: $IP"
echo "The server NIC is: $NIC"
echo "The SSH port on this server is: $SSH"

Thanks,
DevOps Team
EOF
```

## Color code with echo
We should allways reset the color at the end of echo to turn off the color
```sh
# Reset
Color_Off='\033[0m'       # Text Reset
echo -e "[color][message][reset the color]
```
```sh
# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White
```

## Example with color code
```sh
#!/bin/bash
KERNEL=`uname -r |awk -F. '{print $1}'`
MEMORY=`free -mh / |grep Mem: |awk '{print$2}'`
DISKUSAGE=`df -mh /  |tail -1 |awk '{print$2}'`
IP=`ifconfig |grep inet |head -1 |awk '{print$2}'`
NIC=`ifconfig |head -1 |awk -F: '{print$1}'`
SSH=`netstat -ltnp |grep  0.0.0.0:22 | awk '{print$4}' |awk -F: '{print$2}'`

echo -e "Bellow is the system inventory of server $IP \n"
echo "The digit first of the kernel version is: $KERNEL"
echo "The total size of the memory on this server is: $MEMORY"
echo "The total size oof the disk available on this server: $DISKUSAGE"
echo "The IP address of this server is: $IP"
echo "The server NIC is: $NIC"
echo "The SSH port on this server is: $SSH"

Thanks,
DevOps Team
EOF
```
```sh
#!/bin/bash
KERNEL=`uname -r |awk -F. '{print $1}'`
MEMORY=`free -mh / |grep Mem: |awk '{print$2}'`
DISKUSAGE=`df -mh /  |tail -1 |awk '{print$2}'`
IP=`ifconfig |grep inet |head -1 |awk '{print$2}'`
NIC=`ifconfig |head -1 |awk -F: '{print$1}'`
SSH=`netstat -ltnp |grep  0.0.0.0:22 | awk '{print$4}' |awk -F: '{print$2}'`

echo -e "\033[1;31mBellow is the system inventory of server $IP\033[0m"
echo -e "\033[0;32mThe digit first of the kernel version is: $KERNEL\033[0m"
echo -e "\033[1;32mThe total size of the memory on this server is: $MEMORY\033[0m"
echo -e "\033[1;33mThe total size oof the disk available on this server: $DISKUSAGE\033[0m"
echo -e "\033[1;34mThe IP address of this server is: $IP\033[0m"
echo -e "\033[1;35mThe server NIC is: $NIC\033[0m"
echo -e "\033[1;36mThe SSH port on this server is: $SSH\033[0m"

echo -e "\033[1;95mThanks,\033[0m"
echo -e "\033[45mDevOps Team\033[0m"
```

## EOF or end of file with echo
EOF can be anything and it will still display the content
```sh
#!/bin/bash
KERNEL=`uname -r |awk -F. '{print $1}'`
MEMORY=`free -mh / |grep Mem: |awk '{print$2}'`
DISKUSAGE=`df -mh /  |tail -1 |awk '{print$2}'`
IP=`ifconfig |grep inet |head -1 |awk '{print$2}'`
NIC=`ifconfig |head -1 |awk -F: '{print$1}'`
SSH=`netstat -ltnp |grep  0.0.0.0:22 | awk '{print$4}' |awk -F: '{print$2}'`

cat << EOF
Bellow is the system inventory of server $IP
The digit first of the kernel version is: $KERNEL
The total size of the memory on this server is: $MEMORY
The total size oof the disk available on this server: $DISKUSAGE
The IP address of this server is: $IP
The server NIC is: $NIC
The SSH port on this server is: $SSH
EOF
```

```sh
#!/bin/bash
KERNEL=`uname -r |awk -F. '{print $1}'`
MEMORY=`free -mh / |grep Mem: |awk '{print$2}'`
DISKUSAGE=`df -mh /  |tail -1 |awk '{print$2}'`
IP=`ifconfig |grep inet |head -1 |awk '{print$2}'`
NIC=`ifconfig |head -1 |awk -F: '{print$1}'`
SSH=`netstat -ltnp |grep  0.0.0.0:22 | awk '{print$4}' |awk -F: '{print$2}'`

cat << TIALEO
Bellow is the system inventory of server $IP
The digit first of the kernel version is: $KERNEL
The total size of the memory on this server is: $MEMORY
The total size oof the disk available on this server: $DISKUSAGE
The IP address of this server is: $IP
The server NIC is: $NIC
The SSH port on this server is: $SSH
TIALEO
```

## Redirect EOF output into a file
```sh
#!/bin/bash

KERNEL=`uname -r |awk -F. '{print $1}'`
MEMORY=`free -mh / |grep Mem: |awk '{print$2}'`
DISKUSAGE=`df -mh /  |tail -1 |awk '{print$2}'`
IP=`ifconfig |grep inet |head -1 |awk '{print$2}'`
NIC=`ifconfig |head -1 |awk -F: '{print$1}'`
SSH=`netstat -ltnp |grep  0.0.0.0:22 | awk '{print$4}' |awk -F: '{print$2}'`

cat << TIALEO
Bellow is the system inventory of server $IP
The digit first of the kernel version is: $KERNEL
The total size of the memory on this server is: $MEMORY
The total size oof the disk available on this server: $DISKUSAGE
The IP address of this server is: $IP
The server NIC is: $NIC
The SSH port on this server is: $SSH
TIALEO

cat /tmp/result.txt
```

```sh
#!/bin/bash

cat << EOF > /tmp/index.html
This is HTTPD test with script
With ubuntu
EOF

cat << EOF > /tmp/Dockerfile
FROM centos:latest
LABEL maintainer="Tia M"
RUN yum -y install httpd
COPY index.html /var/www/html/
USER root
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80
EOF

cd /tmp/
docker build -t httpd:2.1 .
docker run -d -p 8081:80 httpd:2.1
docker images
docker ps
```

## Comment 
```sh
<< MYCOM
Author: Smith
Date: August 16, 2021
Version: 1.02
This script can only run of Debain and Fedora base OS
MYCOM

OR 

: '
Author: Smith
Date: August 16, 2021
Version: 1.02
This script can only run of Debain and Fedora base OS
'
```

**EXAMPLE:**
```sh
#!/bin/bash

<< MYCOM
Author: Smith
Date: August 16, 2021
Version: 1.02
This script can only run of Debain and Fedora base OS
MYCOM

KERNEL=`uname -r |awk -F. '{print $1}'`
MEMORY=`free -mh / |grep Mem: |awk '{print$2}'`
DISKUSAGE=`df -mh /  |tail -1 |awk '{print$2}'`
IP=`ifconfig |grep inet |head -1 |awk '{print$2}'`
NIC=`ifconfig |head -1 |awk -F: '{print$1}'`
SSH=`netstat -ltnp |grep  0.0.0.0:22 | awk '{print$4}' |awk -F: '{print$2}'`

cat << TIALEO
Bellow is the system inventory of server $IP
The digit first of the kernel version is: $KERNEL
The total size of the memory on this server is: $MEMORY
The total size oof the disk available on this server: $DISKUSAGE
The IP address of this server is: $IP
The server NIC is: $NIC
The SSH port on this server is: $SSH
TIALEO
```

## Sherbang
the bash path migth change base of Linux distro. The env remain the same on all Linux distro.
To avoid having errors with the interpreter, use the path of `env` then `bash` on your sherbang
```sh
#ON UBUNTU
which bash
/bin/bash

which env
/usr/bin/env

#REDHAT
which bash
/usr/bin/bash

which env
/usr/bin/env
```

```sh
#!/usr/bin/env bash
```

## Debugging Bash Scripts
We have 2 types of errors:
- Syntax errors 
- Run time errors
The systax errors stop script exexution while run time error do not stop the script execution.

```sh
#!/usr/bin/env bash
pwd
date 
xmdjhbjhx #Syntax errors 
user=$(whoami #Syntax errors
echo "this is about debugging shell script"
echo "The user is: ${user}"
```
The entire script did not failed to execute because there is no logic to check the script first
```
/root/script
Sun 31 Oct 2021 08:08:10 AM PDT
./test.sh: line 4: xmdjhbjhx: command not found
./test.sh: line 5: unexpected EOF while looking for matching `)'
./test.sh: line 8: syntax error: unexpected end of file
```

We can go with set command and We have different options with set command.
Syntax:
- set [options]
- set with No Options: To list system defined variables with the script and `env` To list system defined variables without a script
- set `-n` No Execution, Purely for syntax check. It will check the entire script for any syntax before it get execute. if there is any synta error, the script will not execute and display the error so that you can fix it.
- set `-x` or `-v` Prints the command before executing it in script or print the command before execution
- set `-e` Exit Script if any command fails

## set -n
```sh
#!/usr/bin/env bash
set -n
pwd
date 
xmdjhbjhx #Syntax errors 
user=$(whoami #Syntax errors
echo "this is about debugging shell script"
echo "The user is: ${user}"
```
The entire script failed to execute because there is a logic to check the script first for syntax errors
```
./test.sh: line 6: unexpected EOF while looking for matching `)'
./test.sh: line 9: syntax error: unexpected end of file
```

## set -n
```sh
#!/usr/bin/env bash
set -x
pwd
date  
user=$(whoami) 
echo "this is about debugging shell script"
echo "The user is: ${user}"
```
The entire script failed to execute because there is a logic to check the script first for syntax errors
```
+ pwd
/root/script
+ date
Sun 31 Oct 2021 08:13:23 AM PDT
++ whoami
+ user=root
+ echo 'this is about debugging shell script'
this is about debugging shell script
+ echo 'The user is: root'
The user is: root
```

```sh
#!/usr/bin/env bash
set -x
pwd
date 
xmdjhbjhx #Syntax errors 
user=$(whoami #Syntax errors
echo "this is about debugging shell script"
echo "The user is: ${user}"

#result
+ pwd
/root/script
+ date
Sun 31 Oct 2021 08:14:17 AM PDT
+ xmdjhbjhx
./test.sh: line 5: xmdjhbjhx: command not found
./test.sh: line 6: unexpected EOF while looking for matching `)'
./test.sh: line 9: syntax error: unexpected end of file
```

## set -e
```sh
#!/usr/bin/env bash
set -e
pwd
date 
xmdjhbjhx #Syntax errors 
user=$(whoami #Syntax errors
echo "this is about debugging shell script"
echo "The user is: ${user}"

# Result
/root/script
Sun 31 Oct 2021 08:17:20 AM PDT
./test.sh: line 5: xmdjhbjhx: command not found
```

## Debug while executing the script through cli
```
bash -x script.sh
bash -e script.sh
bash -n script.sh
bash -v script.sh

./script.sh -x
./script.sh -e
./script.sh -n
./script.sh -v
```

## Leng of the string
```sh
#!/usr/bin/env bash
y="shell scripting is good"

echo $y
echo ${y}
echo ${#y}

#result
shell scripting is good
shell scripting is good
23
```
```sh
#!/usr/bin/env bash
KERNEL=`uname -r |awk -F. '{print $1}'`

x="hello"

echo $KERNEL
echo ${KERNEL}
echo ${#KERNEL}

if [ ${#KERNEL} -ge 0 ] 
then
   echo "The digit first of the kernel version is: $KERNEL"
else
    echo "Unable to find the Kernel version"
fi
```

## Real path
```sh
root@ubuntu:~/script# realpath test.sh 
/root/script/test.sh
root@ubuntu:~/script# ls
test.sh
root@ubuntu:~/script# pwd
/root/script
root@ubuntu:~/script# 
```

## Basename
```sh
#!/usr/bin/env bash
tomcat_url="https://apachemirror.wuchna.com/tomcat/tomcat-8/v8.5.65/bin/apache-tomcat-8.5.65.tar.gz"

echo ${tomcat_url}
basename ${tomcat_url}
basename ${tomcat_url} .tar.gz
basename ${tomcat_url} -8.5.65.tar.gz
basename ${tomcat_url} -tomcat-8.5.65.tar.gz

script=`realpath ${0}`
echo ${script}
basename ${script}
basename ${script} .sh

#RESULT
https://apachemirror.wuchna.com/tomcat/tomcat-8/v8.5.65/bin/apache-tomcat-8.5.65.tar.gz
apache-tomcat-8.5.65.tar.gz
apache-tomcat-8.5.65
apache-tomcat
apache
/root/script/test.sh
test.sh
test
```

## dirname
```sh
#!/usr/bin/env bash
tomcat_url="https://apachemirror.wuchna.com/tomcat/tomcat-8/v8.5.65/bin/apache-tomcat-8.5.65.tar.gz"

echo ${tomcat_url}
dirname ${tomcat_url}

script=`realpath ${0}`
echo ${script}
dirname ${script}


#RESULT
https://apachemirror.wuchna.com/tomcat/tomcat-8/v8.5.65/bin/apache-tomcat-8.5.65.tar.gz
https://apachemirror.wuchna.com/tomcat/tomcat-8/v8.5.65/bin
/root/script/test.sh
/root/script
```

## tee command
It will take the output of the script or command and store it in the file
```sh
#redirect
./script.sh | tee log.txt
bash script.sh | tee log.txt
ls -l | tee /tmp/log.txt

#append with -a
./script.sh | tee -a log.txt
bash script.sh | -a tee log.txt
ls -l | tee -a /tmp/log.txt
```
# Upper and lower
```sh
#!/usr/bin/bash
x="this Is A test"
echo ${x^^}

y="THIS IS a TeSt"
echo ${y,,}

#RESULT
THIS IS A TEST
this is a test
```
```sh
#!/usr/bin/bash

read -p "Enter your name: " my_name
my_name_up=${my_name^^}
echo "Your name in upper-case is: $my_name_up"

read -p "Enter your name: " 
echo "${REPLY,,}"

#RESULT
root@ubuntu:~/script# ./test.sh 
Enter your name: Tia
Your name in upper-case is: TIA
Enter your name: TIA
tia
root@ubuntu:~/script# 
```

# Command line argument
use `{ }` if your command line argument is `=>10` or 2 digits or just user `{ }` for all command argument 
```sh
set -x
echo "$0"
echo "$1"
echo "$2"
echo "$3"
echo "${10}"

echo "The number command line arguments: $#"
echo "All command line arguments are: $*"
echo "All command line arguments are: $@"

#RESULT
./test.sh
tom
paul
john

The number command line arguments: 3
All command line arguments are: tom paul john
All command line arguments are: tom paul john
```

```sh
set -x
echo "{$0}"
echo "{$1}"
echo "{$2}"
echo "{$3}"
echo "${10}"

echo "The number command line arguments: $#"
echo "All command line arguments are: $*"
echo "All command line arguments are: $@"

#RESULT
./test.sh
tom
paul
john

The number command line arguments: 3
All command line arguments are: tom paul john
All command line arguments are: tom paul john
```

# String test
- [[ -z "str" ]] return true if the length of the string is zero else, retun false
- [[ -n str ]] return true if the length of the string is not zero else, retun false

```sh
#!/usr/bin/bash

var1=" "
var2="hello"


if [[ -z "${var1}" ]] 
then
   echo "The string var1 is emty or the length of the string is zero or the string var1 is not set"
else
    echo "Hummmm var1"
fi

if [[ -n "${var2}" ]] 
then
   echo "The string var2 not emty or the length of the string is not zero or the string var2 is set"
else
    echo "Hummmm var2"
fi

#RESULT
Hummmm var1
The string var2 not emty or the length of the string is not zero or the string var2 is set
```


```sh
#!/usr/bin/bash

KERNEL=`uname -r |awk -F. '{print $1}'`
MEMORY=`free -mh / |grep Mem: |awk '{print$2}'`
DISKUSAGE=`df -mh /  |tail -1 |awk '{print$2}'`
IP=`ifconfig |grep inet |head -1 |awk '{print$2}'`
NIC=`ifconfig |head -1 |awk -F: '{print$1}'`
SSH=`netstat -ltnp |grep  0.0.0.0:22 | awk '{print$4}' |awk -F: '{print$2}'`

if [[ -n "${KERNEL}" ]] 
then
   echo "The digit first of the kernel version is: $KERNEL"
else
    echo "NOT FOUND"
fi

if [[ -n "${MEMORY}" ]] 
then
   echo "The total size of the memory on this server is: $MEMOR"
else
    echo "NOT FOUND"
fi

if [[ -n "${DISKUSAGE}" ]] 
then
   echo  "The total size oof the disk available on this server: $DISKUSAGE"
else
    echo "NOT FOUND"
fi

if [[ -n "${IP}" ]] 
then
   echo  "The IP address of this server is: $IP"
else
    echo "NOT FOUND"
fi

if [[ -n "${NIC}" ]] 
then
   echo  "The server NIC is: $NIC"
else
    echo "NOT FOUND"
fi

if [[ -n "${SSH}" ]] 
then
   echo "The SSH port on this server is: $SSH"
else
    echo "NOT FOUND"
fi




if [[ -n "${KERNEL}" ]]; then
   echo "The digit first of the kernel version is: $KERNEL"
else
    echo "NOT FOUND"
fi

if [[ -n "${MEMORY}" ]]; then
   echo "The total size of the memory on this server is: $MEMOR"
else
    echo "NOT FOUND"
fi

if [[ -n "${DISKUSAGE}" ]]; then
   echo  "The total size oof the disk available on this server: $DISKUSAGE"
else
    echo "NOT FOUND"
fi

if [[ -n "${IP}" ]]; then
   echo  "The IP address of this server is: $IP"
else
    echo "NOT FOUND"
fi

if [[ -n "${NIC}" ]]; then
   echo  "The server NIC is: $NIC"
else
    echo "NOT FOUND"
fi

if [[ -n "${SSH}" ]]; then
   echo "The SSH port on this server is: $SSH"
else
    echo "NOT FOUND"
fi
#RESULT
The digit first of the kernel version is: 5
The total size of the memory on this server is: 
The total size oof the disk available on this server: 20G
The IP address of this server is: 172.17.0.1
The server NIC is: docker0
NOT FOUND
```

# Command Chaining Operators
- This concept is useful to write simple and short shell scripts.
- Chaining of Linux commands means, combining several commands and make them execute based upon the behavior of operator used in between them.

**The different Command Chaining Operators are:**
- Semi-colon Operator `;`
- Logical AND Operators `&&`
- Logical OR Operator `||`
- Logical `AND` – `OR` Operators && `||`

**Note:**
- cmd1 ; cmd2 : Run cmd1 and then cmd2, regardless of the success or failure of cmd1
- cmd1 && cmd2 : Run cmd2 only if cmd1 succeeded
- cmd1 || cmd2 : Run cmd2 only if cmd1 failed
- cm1 && cmd2 || cmd3 : Run cmd2 if cm1 is success else run cmd3 
`cd "$(git rev-parse --show-toplevel)" || exit 2`: exit if you are not able the move into `"$(git rev-parse --show-toplevel)"`

```sh
#!/bin/bash

DOCKER=`which docker`
TREE=`which tree`

if [ -n "${DOCKER}" ]; then
    echo "docker is install"
else
    echo "docker is not install"
    sleep 5
    apt install docker.io -y
fi

if [ -n "${TREE}" ]; then
    echo "tree is install"
else
    echo "tree is not install"
    sleep 5
    apt install tree -y
fi
```

```sh
#!/usr/bin/bash
KERNEL=`uname -r |awk -F. '{print $1}'`
MEMORY=`free -mh / |grep Mem: |awk '{print$2}'`
DISKUSAGE=`df -mh /  |tail -1 |awk '{print$2}'`
IP=`ifconfig |grep inet |head -1 |awk '{print$2}'`
NIC=`ifconfig |head -1 |awk -F: '{print$1}'`
SSH=`netstat -ltnp |grep  0.0.0.0:22 | awk '{print$4}' |awk -F: '{print$2}'`

[[ -n "${KERNEL}" ]] && echo "The digit first of the kernel version is: $KERNEL" || echo "NOT FOUND"

[[ -n "${MEMORY}" ]] && echo "The total size of the memory on this server is: $MEMOR" || echo "NOT FOUND"

[[ -n "${DISKUSAGE}" ]] && echo "The total size oof the disk available on this server: $DISKUSAGE" || echo "NOT FOUND"

[[ -n "${IP}" ]] && echo "The IP address of this server is: $IP" || echo "NOT FOUND"

[[ -n "${NIC}" ]] && echo "The server NIC is: $NIC" || echo "NOT FOUND"

[[ -n "${SSH}" ]] && echo "The SSH port on this server is: $SSH" || echo "NOT FOUND"

#RESULT
The digit first of the kernel version is: 5
The total size of the memory on this server is: 
The total size oof the disk available on this server: 20G
The IP address of this server is: 172.17.0.1
The server NIC is: docker0
NOT FOUND
```


```sh
#!/usr/bin/env bash
KERNEL=`uname -r |awk -F. '{print $1}'`
MEMORY=`free -mh / |grep Mem: |awk '{print$2}'`
DISKUSAGE=`df -mh /  |tail -1 |awk '{print$2}'`
IP=`ifconfig |grep inet |head -1 |awk '{print$2}'`
NIC=`ifconfig |head -1 |awk -F: '{print$1}'`
SSH=`netstat -ltnp |grep  0.0.0.0:22 | awk '{print$4}' |awk -F: '{print$2}'`

[[ -z "${KERNEL}" ]] && echo "Variable MEMORY is not set" 

[[ -z "${MEMORY}" ]] && echo "Variable MEMORY is not set" 

[[ -z "${DISKUSAGE}" ]] && echo "Variable DISKUSAGE is not set"

[[ -z "${IP}" ]] && echo "Variable IP is not set"

[[ -z "${NIC}" ]] && echo "Variable NIC is not set"

[[ -z "${SSH}" ]] && echo "Variable SSH is not set"

#RESULT
Variable SSH is not set
```

```sh
#!/usr/bin/env bash

KERNEL=""
MEMORY=""
DISKUSAGE=""
IP=""
NIC=""
SSH="" 

[[ -z "${KERNEL}" ]] && echo "Variable KERNEL is not set" 

[[ -z "${MEMORY}" ]] && echo "Variable MEMORY is not set" 

[[ -z "${DISKUSAGE}" ]] && echo "Variable DISKUSAGE is not set"

[[ -z "${IP}" ]] && echo "Variable IP is not set"

[[ -z "${NIC}" ]] && echo "Variable NIC is not set"

[[ -z "${SSH}" ]] && echo "Variable SSH is not set"

#RESULT
Variable KERNEL is not set
Variable MEMORY is not set
Variable DISKUSAGE is not set
Variable IP is not set
Variable NIC is not set
Variable SSH is not set
```

```sh
#!/usr/bin/env bash

KERNEL=""
MEMORY=""
DISKUSAGE=""
IP=""
NIC=""
SSH="" 

[[ -z "${KERNEL}" ]] && echo "Variable KERNEL is not set" && exit 2

[[ -z "${MEMORY}" ]] && echo "Variable MEMORY is not set" && exit 2

[[ -z "${DISKUSAGE}" ]] && echo "Variable DISKUSAGE is not set" && exit 2 

[[ -z "${IP}" ]] && echo "Variable IP is not set" && exit 2

[[ -z "${NIC}" ]] && echo "Variable NIC is not set" && exit 2

[[ -z "${SSH}" ]] && echo "Variable SSH is not set" && exit 2

#RESULT
Variable KERNEL is not set
```

```sh
#!/usr/bin/env bash

KERNEL="1"
MEMORY="5"
DISKUSAGE="7"
IP="7"
NIC="8"
SSH="8" 

[[ -z "${KERNEL}" ]] && echo "Variable KERNEL is not set" && exit 2

[[ -z "${MEMORY}" ]] && echo "Variable MEMORY is not set" && exit 2

[[ -z "${DISKUSAGE}" ]] && echo "Variable DISKUSAGE is not set" && exit 2 

[[ -z "${IP}" ]] && echo "Variable IP is not set" && exit 2

[[ -z "${NIC}" ]] && echo "Variable NIC is not set" && exit 2

[[ -z "${SSH}" ]] && echo "Variable SSH is not set" && exit 2


[[ -n "${KERNEL}" ]] && [[ -n "${MEMORY}" ]] && [[ -n "${DISKUSAGE}" ]] && [[ -n "${IP}" ]] && [[ -n "${NIC}" ]] && [[ -n "${SSH}" ]] && [[ -n "${SSH}" ]] && echo "All variables are must set and the length is not 0"


if [[ -n "${KERNEL}" ]] && [[ -n "${MEMORY}" ]] && [[ -n "${DISKUSAGE}" ]] && [[ -n "${IP}" ]] && [[ -n "${NIC}" ]] && [[ -n "${SSH}" ]] && [[ -n "${SSH}" ]]; then
    echo "All variables are must set and the length is not 0"
fi

#RESULT
All variables are must set and the length is not 0
All variables are must set and the length is not 0
```

```sh 
#!/usr/bin/env bash

KERNEL=""
MEMORY=""
DISKUSAGE=""
IP=""
NIC=""
SSH="" 

[[ -z "${KERNEL}" ]] && [[ -z "${MEMORY}" ]] && [[ -z "${DISKUSAGE}" ]] && [[ -z "${IP}" ]] && [[ -z "${NIC}" ]] && [[ -z "${SSH}" ]] && [[ -z "${SSH}" ]] && echo "All variables are must set before this script can run"

if [[ -z "${KERNEL}" ]] && [[ -z "${MEMORY}" ]] && [[ -z "${DISKUSAGE}" ]] && [[ -z "${IP}" ]] && [[ -z "${NIC}" ]] && [[ -z "${SSH}" ]] && [[ -z "${SSH}" ]]; then
    echo "All variables are must set before this script can run"
fi

echo "Hello"

#RESULT
All variables are must set before this script can run
All variables are must set before this script can run
Hello
```

```sh
#!/usr/bin/env bash

KERNEL=""
MEMORY=""
DISKUSAGE=""
IP=""
NIC=""
SSH="" 

# [[ -z "${KERNEL}" ]] && [[ -z "${MEMORY}" ]] && [[ -z "${DISKUSAGE}" ]] && [[ -z "${IP}" ]] && [[ -z "${NIC}" ]] && [[ -z "${SSH}" ]] && [[ -z "${SSH}" ]] && echo "All variables are must set before this script can run" && exit 2

if [[ -z "${KERNEL}" ]] && [[ -z "${MEMORY}" ]] && [[ -z "${DISKUSAGE}" ]] && [[ -z "${IP}" ]] && [[ -z "${NIC}" ]] && [[ -z "${SSH}" ]] && [[ -z "${SSH}" ]]; then
    echo "All variables are must set before this script can run"
    exit 2
fi

echo "Hello"

#RESULT
All variables are must set before this script can run
```


```sh
#!/bin/bash

die() {
echo "$@" >&2
  exit 2
}

[ -z "${KERNEL}" ] && die "Variable KERNEL is not set" 

[ -z "${MEMORY}" ] && die "Variable MEMORY is not set" 

[ -z "${DISKUSAGE}" ] && die "Variable DISKUSAGE is not set" 

[ -z "${IP}" ] && die "Variable IP is not set" 

[ -z "${NIC}" ] && die "Variable NIC is not set" 

[ -z "${SSH}" ] && die "Variable SSH is not set" 

#RESULT
root@ubuntu:~/script# ./test.sh 
Variable KERNEL is not set
```

**NB:** The name of the script to be execute should be at the end
```sh
#!/bin/bash

die() {
echo "$@" >&2
  exit 2
}

[ -z "${KERNEL}" ] && die "Variable KERNEL is not set" 

[ -z "${MEMORY}" ] && die "Variable MEMORY is not set" 

[ -z "${DISKUSAGE}" ] && die "Variable DISKUSAGE is not set" 

[ -z "${IP}" ] && die "Variable IP is not set" 

[ -z "${NIC}" ] && die "Variable NIC is not set" 

[ -z "${SSH}" ] && die "Variable SSH is not set" 

echo "All is good"

#RESULT
root@ubuntu:~/script# KERNEL=yes MEMORY=no DISKUSAGE=no IP=yes NIC=no SSH=yes bash test.sh 
All is good
root@ubuntu:~/script# 
```


**NB:** The name of the script to be execute should be at the end
```sh
#!/bin/bash

die() {
echo "$@" >&2
  exit 2
}

[ -z "${KERNEL}" ] && die "Variable KERNEL is not set" 

[ -z "${MEMORY}" ] && die "Variable MEMORY is not set" 

[ -z "${DISKUSAGE}" ] && die "Variable DISKUSAGE is not set" 

[ -z "${IP}" ] && die "Variable IP is not set" 

[ -z "${NIC}" ] && die "Variable NIC is not set" 

[ -z "${SSH}" ] && die "Variable SSH is not set" 

if [[ -n "${KERNEL}" ]] && [[ -n "${MEMORY}" ]] && [[ -n "${DISKUSAGE}" ]] && [[ -n "${IP}" ]] && [[ -n "${NIC}" ]] && [[ -n "${SSH}" ]] && [[ -n "${SSH}" ]]; then
    echo "All variables are must set and the length is not 0 before this script can run"
fi

#RESULT
root@ubuntu:~/script# KERNEL=yes MEMORY=no DISKUSAGE=no IP=yes NIC=no SSH=yes bash test.sh 
All variables are must set and the length is not 0 before this script can run
```

**NB:** The name of the script to be execute should be at the end
```sh
#!/bin/bash

die() {
echo "$@" >&2
  exit 2
}

[ -z "${KERNEL}" ] && die "Variable KERNEL is not set" 

[ -z "${MEMORY}" ] && die "Variable MEMORY is not set" 

[ -z "${DISKUSAGE}" ] && die "Variable DISKUSAGE is not set" 

[ -z "${IP}" ] && die "Variable IP is not set" 

[ -z "${NIC}" ] && die "Variable NIC is not set" 

[ -z "${SSH}" ] && die "Variable SSH is not set" 

if [[ -n "${KERNEL}" ]] && [[ -n "${MEMORY}" ]] && [[ -n "${DISKUSAGE}" ]] && [[ -n "${IP}" ]] && [[ -n "${NIC}" ]] && [[ -n "${SSH}" ]] && [[ -n "${SSH}" ]]; then
    echo "All variables are must set and the length is not 0 before this script can run"
fi

#RESULT
root@ubuntu:~/script# KERNEL=yes MEMORY=no DISKUSAGE=no IP=yes NIC=no bash test.sh 
Variable SSH is not set
```

## Executing block of code using {}
```sh
#!/bin/bash

set -e

ls 
pwd
date

echo 

# Block of code. All these command are execting independently
{
ls 
pwd
date
}

echo 

# Block of code. All these command are execting independently
{
ls; pwd; date
}

echo 

# Block of code. All these command are execting independently
{ ls; pwd; date; }
```

```sh
#!/bin/bash

# Execute the first commands independenty only if first the command was successful
which docker && { echo "Docker is install on this host" ; echo "The docker version is: $(docker -v)" ; }
echo

# Execute the first commands independenty only if the first command was successful
which docker | { echo "Docker is install on this host" ; echo "The docker version is: $(docker -v)" ; }
echo 

# Execute the second commands independenty only if the first command was not successful
which docker || { echo "Docker is install on this host" ; echo "The docker version is: $(docker -v)" ; }

#RESULT
/usr/bin/docker
Docker is install on this host
The docker version is: Docker version 20.10.7, build 20.10.7-0ubuntu1~20.04.2

Docker is install on this host
The docker version is: Docker version 20.10.7, build 20.10.7-0ubuntu1~20.04.2

/usr/bin/docker
```

```sh
#!/bin/bash

# Execute the first commands independenty only if first the command was successful
which dockggggfffsfer && { echo "Docker is install on this host" ; echo "The docker version is: $(docker -v)" ; }
echo

# Execute the second commands independenty only if the first command was not successful
which docrrrddhatewethrrrgker || { echo "Docker is install on this host" ; echo "The docker version is: $(docker -v)" ; }

#RESULT
root@ubuntu:~/script# ./test.sh 

Docker is install on this host
The docker version is: Docker version 20.10.7, build 20.10.7-0ubuntu1~20.04.2
root@ubuntu:~/script# 
```

```sh
#!/bin/bash

# Execute the first commands independenty only if first the command was successful
which docker && { echo "Docker is install on this host" ; echo "The docker version is: $(docker -v)" ; }
echo

which apache2 && { echo "Docker is apache2 on this host" ; echo "The apache2 version is: $(apache2 -v)" ; } 

#RESULT
root@ubuntu:~/script# ./test.sh 
/usr/bin/docker
Docker is install on this host
The docker version is: Docker version 20.10.7, build 20.10.7-0ubuntu1~20.04.2

root@ubuntu:~/script#
```

```sh
#!/bin/bash

# Execute the first commands independenty only if first the command was successful
which docker 2>&1 1>/dev/nul && { echo "Docker is install on this host" ; echo "The docker version is: $(docker -v)" ; }
echo

which apache2 2>&1 1>/dev/nul || { apt update; apt install apache2 -y; }
which apache2 2>&1 1>/dev/nul && { echo "Apache2  is install on this host" ; echo "The apache2 version is: $(apache2 -v)" ; } 

#RESULT
Docker is install on this host
The docker version is: Docker version 20.10.7, build 20.10.7-0ubuntu1~20.04.2

Apache2  is install on this host
The apache2 version is: Server version: Apache/2.4.41 (Ubuntu)
Server built:   2021-10-14T16:24:43
```


```sh
#!/bin/bash

# Execute the first commands independenty only if first the command was successful
which docker && { echo "Docker is install on this host" ; echo "The docker version is: $(docker -v)" ; }
echo

which apache2 || { apt update; apt install apache2 -y; }
which apache2 && { echo "Apache2  is install on this host" ; echo "The apache2 version is: $(apache2 -v)" ; } 

#RESULT
/usr/bin/docker
Docker is install on this host
The docker version is: Docker version 20.10.7, build 20.10.7-0ubuntu1~20.04.2

/usr/sbin/apache2
/usr/sbin/apache2
Apache2  is install on this host
The apache2 version is: Server version: Apache/2.4.41 (Ubuntu)
Server built:   2021-10-14T16:24:43
```


```sh
#!/bin/bash

which docker 2>&1 1>/dev/nul || { apt update; apt install docker.io; } 
which apache2 2>&1 1>/dev/nul || apt install apache2 -y
which git 2>&1 1>/dev/nul || apt install git -y 
which tree 2>&1 1>/dev/nul || apt install tree -y 
which unzip 2>&1 1>/dev/nul || apt install unzip -y 

echo "All Done"
```

```sh
#!/bin/bash

which docker 2>&1 1>/dev/nul || { apt update; apt install docker.io; echo; echo "docker was not installed and it is install on this host"; sleep 5; } 
which apache2 2>&1 1>/dev/nul || { apt install apache2 -y; echo; echo "Apache2 was not installed and it is install on this host"; sleep 5; } 
which git 2>&1 1>/dev/nul || { apt install git -y; echo; echo "Git was not installed and it is install on this host"; sleep 5; }
which tree 2>&1 1>/dev/nul || { apt install tree -y; echo; echo "Tree was not installed and it is install on this host"; sleep 5; }
which unzip 2>&1 1>/dev/nul || { apt install unzip  -y; echo; echo "Unzip was not installed and it is install on this host"; sleep 5; } 

echo "All Done"
```

```sh
#!/bin/bash

which docker 2>&1 1>/dev/nul && { echo; echo "Docker is installed on this host"; echo "The Docker version is: $(docker -v)"; } || { apt update; apt install docker.io -y; }

which apache2 2>&1 1>/dev/nul && { echo; echo "Apache2 is installed on this host"; echo "The Apache2 version is: $(apache2 -v)"; } || { apt install apche2 -y; }

which git 2>&1 1>/dev/nul && { echo; echo "Git is installed on this host"; echo "The Git version is: $(git --version)"; } || { apt install git -y; }

which tree 2>&1 1>/dev/nul && { echo; echo "Tree is installed on this host"; echo "The tree version is: $(tree --version)"; } || { apt install tree -y; }

echo "All Done"
```


## Redirection Operators and STDIN, STDOUT & STDERR
- Output redirection `>`(overwrite) and `>>` (append)
- Input redirection `<`
- Combinning redirection
    - `|` to send the standard output of one command to another command as standard input `ls -l |grep -i root`
- STDIN (standard input), STDOUT (standard output) & STDERR (standard error)
    - 0: STDIN
    - 1: STDOUT `ls -l 1>demo.txt`or `ls -l >demo.txt`: store only the output in demo.txt and display the error
    - 2: STDERR ---> `ls -l 2>demo.txt`: store only the error output in demo.txt if there is any and display the output
- `ls -l 1>demo.txt 2>error.txt`, `sdffgfgfhrtg 1>demo.txt 2>error.txt` store the error in error.txt and the outup in demo.txt
- `java --version 1>jva_ver.txt 2>jva_ver.txt` store both in the same file
- `java --version  &> jva_ver.txt` or `java --version  &>jva_ver.txt`store both in the same file
- `java --version  1>jva_ver.txt 2>&1` store both in the same file
- `java --version  2>&1 1>/dev/nul` or `java --version  &>/dev/nul` redirct everything to dev null(trash)

```sh 
#!/bin/bash

which docker 2>&1 1>/dev/nul && { echo; echo "Docker is installed on this host"; echo "The Docker version is: $(docker -v)"; } || { apt update; apt install docker.io -y; }

which apache2 &>/dev/nul && { echo; echo "Apache2 is installed on this host"; echo "The Apache2 version is: $(apache2 -v)"; } || { apt install apche2 -y; }

which git 2>/dev/nul 1>/dev/nul && { echo; echo "Git is installed on this host"; echo "The Git version is: $(git --version)"; } || { apt install git -y; }

which tree &>/dev/nul && { echo; echo "Tree is installed on this host"; echo "The tree version is: $(tree --version)"; } || { apt install tree -y; }

echo "All Done"
```

```sh
#!/bin/bash

which docker 2>&1 1>/dev/nul && { echo; echo "Docker is installed on this host" >>text.txt; echo "The Docker version is: $(docker -v)" >>text.txt; } || { apt update; apt install docker.io -y; }

which apache2 &>/dev/nul && { echo; echo "Apache2 is installed on this host" >>text.txt; echo "The Apache2 version is: $(apache2 -v)" >>text.txt; } || { apt install apche2 -y; }

which git 2>/dev/nul 1>/dev/nul && { echo; echo "Git is installed on this host" >>text.txt; echo "The Git version is: $(git --version)" >>text.txt; } || { apt install git -y; }

which tree &>/dev/nul && { echo; echo "Tree is installed on this host" >>text.txt; echo "The tree version is: $(tree --version)" >>text.txt; } || { apt install tree -y; }

echo "All Done"
```

```sh
#!/bin/bash

which docker 2>&1 1>/dev/nul && { echo; echo "Docker is installed on this host" &>>text.txt; echo "The Docker version is: $(docker -v)" &>>text.txt; } || { apt update; apt install docker.io -y; }

which apache2 &>/dev/nul && { echo; echo "Apache2 is installed on this host" &>>text.txt; echo "The Apache2 version is: $(apache2 -v)" &>>text.txt; } || { apt install apche2 -y; }

which git 2>/dev/nul 1>/dev/nul && { echo; echo "Git is installed on this host" &>>text.txt; echo "The Git version is: $(git --version)" &>>text.txt; } || { apt install git -y; }

which tree &>/dev/nul && { echo; echo "Tree is installed on this host" &>>text.txt; echo "The tree version is: $(tree --version)" &>>text.txt; } || { apt install tree -y; }

echo "All Done"
```

## Usage of grep command
- Basic options: -i -w -v -o -n -c -A -B -C -r -l -h
    - `-i` To ignore case for matching/searching
    - `-w` To match a whole word
    - `-v` To display the lines which are not having given string or text
    - `-o` To print/display only matched parts from matched lines
    - `-n` To display the matched line numbers
    - `-c` To display matched number of lines
    - `-A` To display N lines after match (grep –A 3 “string” file)
    - `-B` To display N lines before match
    - `-C` To display N lines around match (before and after)
    - `-r` To search under current directory and its sub-directory
    - `-l` To display only file names
    - `-h` To hide file names

- `grep "bash" one.sh two.sh  .... n.sh`: to grep `bash` in multiple files
- `grep "bash" *`: to grep `bash` in all files in the curent location
- `grep -r -i "bash" *`: to grep `bash` in all files in the curent location and sub directories or recursive
- `grep -r "bash" *`: to grep `bash` recursive in all directories
- `grep -i "bash" *`: to grep `bash` and `Bash` in all files in the curent location 
- `grep -w "line" test.txt`: this will grep only `line` in test.txt and it will not grep `lines` or `lineaction` for instance
- `grep -ino "bash" *`: line number, exat match and ignore case case sentitive
- `grep -lr "bash" *`: display only files name and recursive


- Advanced Options: -f -e and –E
    - `-f` Takes search string/pattern from a file, one per line
    - `-e` To search multiple strings/patterns. Pattern is a string and it represents more than one string.
    - `-E` To work with patterns
    - grep -E[options] [patterns] file/files
- `cat /etc/passwd |grep -e "root" -e "bash" -e "sbin" -e "systemd" -e "nologin"` or `cat /etc/passwd |grep -E "root|bash|sbin|systemd|nologin"`
- `cat > test.txt`
    bash
    root
    systemd
    bash
    nologin
    `ctrl+d`
- `cat /etc/passwd |grep -f test.txt`: grep from a file


- Rules to create patterns:
    - `xy|pq` Matches for xy or pq ----> `cat /etc/sudoers |grep -E -i "^%|all$"`, `cat /etc/sudoers |grep -E -i "Defaults|all"`
    - `^xyz` Matches for the lines which are starting with `xyz` ----> `cat /etc/sudoers |grep -E "^%"`, `ls -lrt |grep -E "^-"`, `ls -lrt |grep -E "^d"`
    - `xyz$` Matches for the lines which are ending with `xyz` ----> `cat /etc/sudoers |grep -E -i "all$"`
    - `^$` Matches for the lines which are empty ---->`cat /etc/sudoers |grep "^$" |wc -l`

```sh
root@ubuntu:~# cat /etc/passwd |grep root
root:x:0:0:root:/root:/bin/bash
nm-openvpn:x:118:124:NetworkManager OpenVPN,,,:/var/lib/openvpn/chroot:/usr/sbin/nologin
root@ubuntu:~# cat /etc/passwd |grep -w root
root:x:0:0:root:/root:/bin/bash
root@ubuntu:~# cat /etc/passwd |grep -n root
1:root:x:0:0:root:/root:/bin/bash
37:nm-openvpn:x:118:124:NetworkManager OpenVPN,,,:/var/lib/openvpn/chroot:/usr/sbin/nologin
root@ubuntu:~# cat /etc/passwd |grep -nw root
1:root:x:0:0:root:/root:/bin/bash
root@ubuntu:~# cat /etc/passwd |grep -c root
2
root@ubuntu:~# cat /etc/passwd |grep -cw root
1
root@ubuntu:~# cat /etc/passwd |grep -A 1 root
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
--
nm-openvpn:x:118:124:NetworkManager OpenVPN,,,:/var/lib/openvpn/chroot:/usr/sbin/nologin
hplip:x:119:7:HPLIP system user,,,:/run/hplip:/bin/false
root@ubuntu:~# cat /etc/passwd |grep -B 1 root
root:x:0:0:root:/root:/bin/bash
--
saned:x:117:123::/var/lib/saned:/usr/sbin/nologin
nm-openvpn:x:118:124:NetworkManager OpenVPN,,,:/var/lib/openvpn/chroot:/usr/sbin/nologin
root@ubuntu:~# cat /etc/passwd |grep -C 1 root
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
--
saned:x:117:123::/var/lib/saned:/usr/sbin/nologin
nm-openvpn:x:118:124:NetworkManager OpenVPN,,,:/var/lib/openvpn/chroot:/usr/sbin/nologin
hplip:x:119:7:HPLIP system user,,,:/run/hplip:/bin/false
```

## Comparison Operators with test command

**Numbers:**
- `[[ int1 -eq int2 ]]`     -- It return true if they are equal else false
- `[[ int1 -ne int2 ]]`     -- It return false if they are not equal else true
- `[[ int1 -lt int2 ]]`     -- It return true if int1 is less than int2 else false
- `[[ int1 –le int2 ]]`     -- It return true if int1 is less than or equal to int2 else false
- `[[ int1 -gt int2 ]]`     -- It return true if int1 is greater than int2 else false
- `[[ int1 -ge int2 ]]`     -- It return true if int1 is greater than or equal to int2 else false
- `[[ ! int1 -eq int2 ]]`   -- It reverse the resul- 

**Strings:**
- `[[ -z str ]]` -- It return true if the length of the str is zero else false
- `[[ -n str ]]` -- It return true if the length of the str is no-zero else false
- `[[ str1 == str2 ]]` -- It return true if both the strings are equal else false
- `[[ str1 != str2 ]]` -- It return true if both the strings are equal else false

## File test Operators with test command
- `[[ -d file ]]` -- It return true if the file/path is directory else false
- `[[ -f file ]]` -- It return true if the file/path is a file else false
- `[[ -e file ]]` -- It return true if the file/path is exists else false
- `[[ -r file ]]` -- It return true if the file/path is readable else false
- `[[ -w file ]]` -- It return true if the file/path is writable else false
- `[[ -x file ]]` -- It return true if the file/path is executable else false


## Advanced file test operators are listed below
- `a` : True if the file exists.
- `b` : True if the file exists and is a block special file.
- `c` : True if the file exists and is a character special file.
- `d` : True if the file exists and is a directory.
- `e` : True if the file exists.
- `f` : True if the file exists and is a regular file.
- `g` : True if the file exists and its SGID bit is set.
- `h` : True if the file exists and is a symbolic link.
- `k` : True if the file exists and its sticky bit is set.
- `p` : True if the file exists and is a named pipe (FIFO).
- `r` : True if the file exists and is readable.
- `s` : True if the file exists and has a size greater than zero.
- `t` : True if file descriptor is open and refers to a terminal.
- `u` : True if the file exists and its SUID (set user ID) bit is set.
- `w` : True if the file exists and is writable.
- `x` : True if the file exists and is executable.
- `O` : True if the file exists and is owned by the effective user ID.
- `G` : True if the file exists and is owned by the effective group ID.
- `L` : True if the file exists and is a symbolic link.
- `N` : True if the file exists and has been modified since it was last read.
- `S` : True if the file exists and is a socket.

## Command Chaining Operators
- This concept is useful to write simple and short shell scripts.
- Chaining of Linux commands means, combining several commands and make them execute based upon the behavior of operator used in between them.
- The different Command Chaining Operators are:
    - Semi-colon Operator ;
    - Logical AND Operators &&
    - Logical OR Operator ||
    - Logical AND – OR Operators && ||
- Note:
    - cmd1 ; cmd2 – Run cmd1 and then cmd2, regardless of the success or failure of cmd1
    - cmd1 && cmd2 – Run cmd2 only if cmd1 succeeded
    - cmd1 || cmd2 – Run cmd2 only if cmd1 failed
    - cm1 && cmd2 || cmd3 – Run cmd2 if cm1 is success else run


# if elif elif else conditional statement

**Syntax:**
```sh
Cmd1 && Cmd2
if Cmd1
then
    Cmd2
fi
#------------------------------------------------------------------------------
Cmd1 && { Cmd2 ; Cmd3 ; }
if Cmd1
then
    Cmd2
    Cmd3
fi

#------------------------------------------------------------------------------
Cmd1 && Cmd2 || Cmd3
if Cmd1
then
    Cmd2
else
    Cmd3
fi
#------------------------------------------------------------------------------
Cmd1 && { Cmd2 ; Cmd3 ; } || Cmd4
if Cmd1
then
    Cmd2
    Cmd3
else
    Cmd4
fi
```

```sh
#!/bin/bash

which docker 2>&1 1>/dev/nul && { echo; echo "Docker is installed on this host"; echo "The Docker version is: $(docker -v)"; } || { apt update; apt install docker.io -y; }

which apache2 &>/dev/nul && { echo; echo "Apache2 is installed on this host"; echo "The Apache2 version is: $(apache2 -v)"; } || { apt install apche2 -y; }

which git 2>/dev/nul 1>/dev/nul && { echo; echo "Git is installed on this host"; echo "The Git version is: $(git --version)"; } || { apt install git -y; }

which tree &>/dev/nul && { echo; echo "Tree is installed on this host"; echo "The tree version is: $(tree --version)"; } || { apt install tree -y; }

echo "All Done"

#------------------------------------------------------------------------------

#!/bin/bash

if [ -n "$(which docker)" &>/dev/nul ]; then
    echo
    echo "Docker is installed on this host"
    echo "The Docker version is: $(docker -v)"
else
   apt update
   apt install docker.io -y
fi

if [ -n "$(which apache2)" &>/dev/nul ]; then
    echo
    echo "Apache2 is installed on this host"
    echo "The Apache2 version is: $(apache2 -v)"
else
   apt install apche2 -y
fi

if [ -n "$(which git)" &>/dev/nul ]; then
    echo
    echo "Git is installed on this host"
    echo "The Git version is: $(git --version)"
else
   apt install git -y
fi

if [ -n "$(which tree)" &>/dev/nul ]; then
    echo
    echo "Tree is installed on this host"
    echo "The tree version is: $(tree --version)"
else
   apt install tree -y
fi

echo "All Done"

#------------------------------------------------------------------------------

#!/bin/bash
if which docker &>/dev/nul
then
    echo
    echo "Docker is installed on this host"
    echo "The Docker version is: $(docker -v)"
else
   apt update
   apt install docker.io -y
fi

if which apache2 &>/dev/nul 
then
    echo
    echo "Apache2 is installed on this host"
    echo "The Apache2 version is: $(apache2 -v)"
else
   apt install apche2 -y
fi

if which git &>/dev/nul 
then
    echo
    echo "Git is installed on this host"
    echo "The Git version is: $(git --version)"
else
   apt install git -y
fi

if which tree &>/dev/nul 
then
    echo
    echo "Tree is installed on this host"
    echo "The tree version is: $(tree --version)"
else
   apt install tree -y
fi

echo "All Done"
``` 

```sh
#!/bin/bash

die() {
echo "$@" >&2
  exit 2
}

[ -z "${KERNEL}" ] && die "Variable KERNEL is not set" 

[ -z "${MEMORY}" ] && die "Variable MEMORY is not set" 

[ -z "${DISKUSAGE}" ] && die "Variable DISKUSAGE is not set" 

[ -z "${IP}" ] && die "Variable IP is not set" 

[ -z "${NIC}" ] && die "Variable NIC is not set" 

[ -z "${SSH}" ] && die "Variable SSH is not set" 

if [[ -n "${KERNEL}" ]] && [[ -n "${MEMORY}" ]] && [[ -n "${DISKUSAGE}" ]] && [[ -n "${IP}" ]] && [[ -n "${NIC}" ]] && [[ -n "${SSH}" ]] && [[ -n "${SSH}" ]]; then
    echo "All variables are must set and the length is not 0 before this script can run"
fi

#------------------------------------------------------------------------------

#!/bin/bash

die() {
echo "$@" >&2
  exit 2
}

if [ -z "${KERNEL}" ]; then 
    die "Variable KERNEL is not set" 
fi

if [ -z "${MEMORY}" ]; then
    die "Variable MEMORY is not set" 
fi

if [ -z "${DISKUSAGE}" ]; then
    die "Variable DISKUSAGE is not set" 
fi

if [ -z "${IP}" ]; then 
    die "Variable IP is not set" 
fi

if [ -z "${NIC}" ]; then 
    die "Variable NIC is not set" 
fi

if [ -z "${SSH}" ]; then 
    die "Variable SSH is not set" 
fi

if [[ -n "${KERNEL}" ]] && [[ -n "${MEMORY}" ]] && [[ -n "${DISKUSAGE}" ]] && [[ -n "${IP}" ]] && [[ -n "${NIC}" ]] && [[ -n "${SSH}" ]] && [[ -n "${SSH}" ]]; then
    echo "All variables are must set and the length is not 0 before this script can run"
fi

#RESULT
All variables are must set and the length is not 0 before this script can run
root@ubuntu:~/script#
```

## Comment in shell script
```sh
#!/bin/bash
die() {
echo "$@" >&2
  exit 2
}

if [ -z "${KERNEL}" ]; then 
    die "Variable KERNEL is not set" 
fi
<<COMMENT
if [ -z "${MEMORY}" ]; then
    die "Variable MEMORY is not set" 
fi

if [ -z "${DISKUSAGE}" ]; then
    die "Variable DISKUSAGE is not set" 
fi

if [ -z "${IP}" ]; then 
    die "Variable IP is not set" 
fi

if [ -z "${NIC}" ]; then 
    die "Variable NIC is not set" 
fi

if [ -z "${SSH}" ]; then 
    die "Variable SSH is not set" 
fi
COMMENT

if [[ -n "${KERNEL}" ]] && [[ -n "${MEMORY}" ]] && [[ -n "${DISKUSAGE}" ]] && [[ -n "${IP}" ]] && [[ -n "${NIC}" ]] && [[ -n "${SSH}" ]] && [[ -n "${SSH}" ]]; then
    echo "All variables are must set and the length is not 0 before this script can run"
fi


#------------------------------------------------------------------------------
#!/bin/bash
die() {
echo "$@" >&2
  exit 2
}

if [ -z "${KERNEL}" ]; then 
    die "Variable KERNEL is not set" 
fi
<<A
if [ -z "${MEMORY}" ]; then
    die "Variable MEMORY is not set" 
fi

if [ -z "${DISKUSAGE}" ]; then
    die "Variable DISKUSAGE is not set" 
fi
A
if [ -z "${IP}" ]; then 
    die "Variable IP is not set" 
fi

if [ -z "${NIC}" ]; then 
    die "Variable NIC is not set" 
fi

if [ -z "${SSH}" ]; then 
    die "Variable SSH is not set" 
fi

if [[ -n "${KERNEL}" ]] && [[ -n "${MEMORY}" ]] && [[ -n "${DISKUSAGE}" ]] && [[ -n "${IP}" ]] && [[ -n "${NIC}" ]] && [[ -n "${SSH}" ]] && [[ -n "${SSH}" ]]; then
    echo "All variables are must set and the length is not 0 before this script can run"
fi

#------------------------------------------------------------------------------
#!/bin/bash
die() {
echo "$@" >&2
  exit 2
}
<<AAAAAA
if [ -z "${KERNEL}" ]; then 
    die "Variable KERNEL is not set" 
fi

if [ -z "${MEMORY}" ]; then
    die "Variable MEMORY is not set" 
fi

if [ -z "${DISKUSAGE}" ]; then
    die "Variable DISKUSAGE is not set" 
fi
A
if [ -z "${IP}" ]; then 
    die "Variable IP is not set" 
fi

if [ -z "${NIC}" ]; then 
    die "Variable NIC is not set" 
fi

if [ -z "${SSH}" ]; then 
    die "Variable SSH is not set" 
fi

if [[ -n "${KERNEL}" ]] && [[ -n "${MEMORY}" ]] && [[ -n "${DISKUSAGE}" ]] && [[ -n "${IP}" ]] && [[ -n "${NIC}" ]] && [[ -n "${SSH}" ]] && [[ -n "${SSH}" ]]; then
    echo "All variables are must set and the length is not 0 before this script can run"
fi
<<AAAAAA
```

## Logical AND OR and NOT operators - ( &&, || and ! )
- Logical AND Operator && or -a
    - will compare two inputs & if both are true, it will return true else false.
- Logical OR Operator || or -o
    - Will check two conditions will return true, if any of them is true & return false when both are false.
- Logical NOT Operator !
    - will return true when the condition is false & return false if the condition is true.


## What is the difference between [ ] and [[ ]] And also (( )) ?
Difference between [ and [[
- [[ is the improvement version of [
- [[ have several benefits compare to [
- They are:
    - No need to use quotes .
    - We can also use < and > operators for strings while using `[[ ]]`.
    - [[ $x = y ]] && [[ $x = yes ]] ---->>> [[ $x = y && $x = yes ]]

1. We need `" "` for string and variable if using `[ ]`
```sh
#!/usr/bin/env bash

read -p "Do you want to start Docker? yes or no: " DOCKER

if [ "$DOCKER" == "yes" ]; then
    echo "Stating Docker ..........."
    systemctl start docker
else
    echo "Skipping .........."
fi

#------------------------------------------------------------------------------

#!/usr/bin/env bash

read -p "Do you want to start Docker? yes or no: " DOCKER

if [ "${DOCKER}" == "yes" ]; then
    echo "Stating Docker ..........."
    systemctl stat Docker
else
    echo "Skipping .........."
fi

```

2. We do not need `" "` for string and variable if using `[[ ]]` or `(( ))`
```sh
#!/usr/bin/env bash

read -p "Do you want to start Docker? yes or no: " DOCKER

if [[ $DOCKER == yes ]]; then
    echo "Stating Docker ..........."
    systemctl start docker
else
    echo "Skipping .........."
fi

#------------------------------------------------------------------------------

#!/usr/bin/env bash

read -p "Do you want to start Docker? yes or no: " DOCKER

if [[ ${DOCKER} == yes ]]; then
    echo "Stating Docker ..........."
    systemctl start docker
else
    echo "Skipping .........."
fi

#------------------------------------------------------------------------------

#!/usr/bin/env bash

read -p "Do you want to start Docker? yes or no: " DOCKER

if (( ${DOCKER} == yes )); then
    echo "Stating Docker ..........."
    systemctl start docker
else
    echo "Skipping .........."
fi

```

3. Best practice: use `"{ }"` while using `[[ ]]` or `(( ))`
```sh
#!/usr/bin/env bash

read -p "Do you want to start Docker? yes or no: " DOCKER

if (( "${DOCKER}" == "yes" )); then
    echo "Stating Docker ..........."
    systemctl start docker
else
    echo "Skipping .........."
fi

#------------------------------------------------------------------------------

#!/usr/bin/env bash

read -p "Do you want to start Docker? yes or no: " DOCKER

if [[ "${DOCKER}" == "yes" ]]; then
    echo "Stating Docker ..........."
    systemctl start docker
else
    echo "Skipping .........."
fi
```

4. Use `[[ ]]` while using `||` and `&&`
```sh
#!/usr/bin/env bash

read -p "Do you want to start Docker? yes or no: " DOCKER

if [[ "${DOCKER}" == "yes" || "${DOCKER}" == "no" ]]; then
    echo "Stating Docker ..........."
    systemctl start docker
else
    echo "Skipping .........."
fi
```

4. Use `[ ]` while using `-o` and `-a`
```sh
#!/usr/bin/env bash

read -p "Do you want to start Docker? yes or no: " DOCKER

if [ "${DOCKER}" == "yes" -o "${DOCKER}" == "no" ]; then
    echo "Stating Docker ..........."
    systemctl start docker
else
    echo "Skipping .........."
fi
```

5. `[[ ]]` support regular expression
```sh
#!/usr/bin/env bash

read -p "Do you want to start Docker? yes or no: " DOCKER

if [[ "${DOCKER}" =~ yes|Yes|Y|y|YES ]]; then
    echo "Stating Docker ..........."
    systemctl start docker
else
    echo "Skipping .........."
fi

#------------------------------------------------------------------------------

#!/usr/bin/env bash

read -p "Do you want to start Docker? yes or no: " DOCKER

if [[ "${DOCKER}" =~ yes|Yes|Y|y|YES ]]
then
    echo "Stating Docker ..........."
    systemctl start docker
elif [[ "${DOCKER}" =~ N|No|no|n|NO ]]
then
    echo "Skipping .........."
else
    echo "ERROR"
fi

```

## One time task execution with at | scheduling job with at command to execute once
at command is very useful for scheduling one time tasks.

**Example:**
- Shutdown system at the specified time
- Taking a one-time backup.

```
apt install at -y
```

**Syntax:**
```
echo "bash backup.sh" | at 9:00 AM  OR  echo "bash backup.sh" | at at now + 30 minutes,
Or
Run first: at 9:00 AM then enter and give the cmd (bash backup.sh) or script to run and
press ctrl+D.
```

**Commands used with at:**

- `at` : execute commands at specified time. 
- `atq` : lists the pending jobs of users.
- `atrm + job number` : delete jobs by their job number.

**Examples of at command:**

Ex-1: Schedule task at coming 10:00 AM.
- at 10:00 AM
Ex-2: Schedule task at 10:00 AM on coming Sunday.
- at 10:00 AM Sun
Ex-3: Schedule task at 10:00 AM on coming 25’th July.
- at 10:00 AM July 25
Ex-4: Schedule task at 10:00 AM on coming 22’nd June 2025.
- at 10:00 AM 6/22/2015
- at 10:00 AM 6.22.2015
Ex-5: Schedule task at 10:00 AM on the same date at next month.
- at 10:00 AM next month
Ex-6: Schedule task at 10:00 AM tomorrow.
- at 10:00 AM tomorrow
Ex-7: Schedule task to execute just after 1 hour.
- at now + 1 hour
Ex-8: Schedule task to execute just after 30 minutes.
- at now + 30 minutes
Ex-9: Schedule task to execute just after 1 and 2 weeks.
- at now + 1 week
- at now + 2 weeks
Ex-10: Schedule task to execute just after 1 and 2 years.
- at now + 1 year
- at now + 2 years
Ex-1: Schedule task to execute at midnight.
- at midnight

## Shell Script to send Automatic Mail Alert when RAM Memory gets Low
mail must be set up first
```sh
#!/bin/bash
TO="dowithscripting@gmail.com"
TH_L=400
free_RAM=$(free -mt | grep -E "Total" | awk '{print $4}')

if [[ $free_RAM -lt $TH_L ]]
then
  echo -e "Server is running with low RAM Size\nAvaialbe RAM is: $free_RAM" | /bin/mail -s "RAM INFO $(date)" $TO
fi

Cronjob:
-------
crontab -e
then write below and save it (for every min)
* * * * *  /bin/bash send_automatic_mail_alert_when_ram_size_is_low.sh
```

## What is an Array and How to define or declare it ?
- What is an array ?
    - An Array is the data structure of the bash shell, which is used to store multiple data’
    - Simple array: myarray=( ls pwd date 2 5.6 ) #No limit for length of an array
- How to Define/declare an array ?
    - There are different ways to define an array in bash shell scripting.
        - Empty Array: myArray=()
        - mycmds=( ls pwd date 2 5.6 )
        - myNewArray=( ls -lrt hostname -s )
        - myNewArray=( "ls –lrt" "hostname –s" )
        - declare -a NewArray
        - NewArray=( 1 3 4 5 bash scripting)

```sh
#!/usr/bin/env bash

declare -a NewArray
NewArray=( 1 3 4 5 bash scripting)
echo "${NewArray[4]}"
echo "${NewArray[0-4]}"
echo "${NewArray[-1]}"
```

```sh
#!/bin/bash

for each in 1 2 3 4 5
do
  echo "Welcome to shell scripting"
  echo "We done with very basics"
  echo "Now we are starting loops concepts"
done

#------------------------------------------------------------------------------
#!/bin/bash

if [[ -x httpd_info.sh ]]
then
  echo "httpd_info.sh is having execution permission" 
else
  echo "httpd_info.sh is not having execution permission"
fi


if [[ -x httpd_ver_port.sh ]]
then
   echo "httpd_ver_port.sh is having execution permission" 
else
   echo "httpd_ver_port.sh is not having execution permission"
fi


#for each in httpd_info.sh httpd_ver_port.sh check_ex_per.sh
for each in $(ls)
do
  if [[ -x $each ]]
  then
    echo "$each is having execution permission" 
  else
    echo "$each is not having execution permission"
  fi
done
#------------------------------------------------------------------------------

check_ex_per_of_files_for_given_dir.sh

#!/bin/bash

if [[ $# -ne 1 ]]
then
	echo "Usage: $0 <any_path>"
	exit 
fi

given_path=$1
for each in $(ls $given_path)
do
  if [[ -x $each ]]
  then
      echo "$each is having execution permission" 
  else
      echo "$each is not having execution permission"
  fi
done
#------------------------------------------------------------------------------

#!/bin/bash
#for each_value in 1 2 3
for each_file in $(ls)
do
   echo "this is a loop"
   echo "for this iteration each_value is: $each_file"
done
```


## Installing multiple packages with for loop and command line arguments
```sh
#!/bin/bash
#Author: Narendra 
#Installing mutliple pkags

$# = number of arguments
$@ = all arguments

if [[ $# -eq 0 ]]
then
  echo "Usage: $0 pkg1 pkg2 ...."
  exit 1
fi


if [[ $(id -u) -ne 0 ]]
then
  echo "Please run from root user or with sudo privilage"
  exit 2
fi

for each_pkg in $@
do
  if which $each_pkg &> /dev/null
  then
     echo "Already $each_pkg is installed"
  else
     echo "Installing $each_pkg ......"
     yum install $each_pkg -y &> /dev/null 
     if [[ $? -eq 0 ]]
     then
       echo "Successfully installed $each_pkg pkg"
     else
       echo "Unable to install vim $each_pkg"
     fi
  fi
done
```


##  Difference between $@ and $* (to print all arguments)
```sh
#!/bin/bash

echo -e "The below output is for \$*"
for each in $*
do
  echo $each
done

echo -e "The below output is for \$@"
for each in $@
do
  echo $each
done
```
```
root@ubuntu:~/script# ./test.sh 1 2 3 4 5 hi 
The below output is for $*
1
2
3
4
5
hi
The below output is for $@
1
2
3
4
5
hi
root@ubuntu:~/script# 
```

```sh
#!/bin/bash

echo -e "The below output is for $*"
for each in $*
do
  echo $each
done

echo -e "The below output is for $@"
for each in $@
do
  echo $each
done
```

```
root@ubuntu:~/script# ./test.sh 1 2 3 4 5 hi 
The below output is for 1 2 3 4 5 hi
1
2
3
4
5
hi
The below output is for 1 2 3 4 5 hi
1
2
3
4
5
hi
root@ubuntu:~/script# 
```

## Loop Control commands / statements
```sh
#!/bin/bash
#ls
<< mcom
for each_file in $(ls)
do
   echo "$each_file"
done
mcom

<< scom
cnt=1
for each_file in $(ls *.txt)
do
  if [[ $cnt -eq 1 ]]
  then 
     echo "$each_file"
     ((cnt++))
  fi
done
scom

echo "starting for loop"
cnt=1
for each_file in $(ls *.txt)
do
	if [[ $cnt -eq 1 ]]
	then
           echo "$each_file"
	   break
	fi
done

echo "for loop is over"

#------------------------------------------------------------------------------
#!/bin/bash
echo "starting for loop"
<< mycom
for each in $(seq 1 10)
do
  if [[ $each -gt 5 ]]
  then
	 break
  fi 
  echo "$each"
done
mycom

<< com
for each in $(seq 1 10)
do
  if [[ $each -ne 5 ]]
  then
     echo "$each"
  fi

done

com

for each in $(seq 1 10)
do
   if [[ $each -eq 5 ]]
   then
	   continue
   fi	 

   echo "$each"
done

echo "for loop is over"
```

## Case Statement
```sh
#!/bin/bash
clear
echo "--------------------------------"
echo "Welcome to Arithmetic Calculator"
echo "--------------------------------"
echo -e "[a]ddition\n[b]Subtraction\n[c]Multiplication\n[d]Division\n"
read -p "Enter your choice: " choice
case $choice in
   [aA])
        read -p "Enter first number: " num1
        read -p "Enter second number: " num2
        result=$((num1+num2))
        echo "The result for your choice is: $result"
        ;;
   [bB])
        read -p "Enter first number: " num1
        read -p "Enter second number: " num2
        result=$((num1-num2))
        echo "The result for your choice is: $result"
        ;;
   [cC])
        read -p "Enter first number: " num1
        read -p "Enter second number: " num2
        result=$((num1*num2))
        echo "The result for your choice is: $result"
        ;;
   [dD])
        read -p "Enter first number: " num1
        read -p "Enter second number: " num2
        result=$((num1/num2))
        echo "The result for your choice is: $result"
        ;;
   *)
       echo "Wrong choice"
       ;;
esac

#----------------------------------------------------------------------------

#!/bin/bash
mycode() {
   read -p "Enter first number: " num1
   read -p "Enter second number: " num2
}

clear
echo "--------------------------------"
echo "Welcome to Arithmetic Calculator"
echo "--------------------------------"
echo -e "[a]ddition\n[b]Subtraction\n[c]Multiplication\n[d]Division\n"
read -p "Enter your choice: " choice
case $choice in
   [aA])
        mycode
        result=$((num1+num2))
        echo "The result for your choice is: $result"
        ;;
   [bB])
        mycode
        result=$((num1-num2))
        echo "The result for your choice is: $result"
        ;;
   [cC])
        mycode
        result=$((num1*num2))
        echo "The result for your choice is: $result"
        ;;
   [dD])
        mycode
        result=$((num1/num2))
        echo "The result for your choice is: $result"
        ;;
   *)
       echo "Wrong choice"
       ;;
esac
```

## Functions
```sh
#!/bin/bash


read_inputs()
{
  read -p "Enter first num: " num1
  read -p "Enter second num: " num2
}

addition()
{
  sum=$((num1+num2))
  echo "The addition of $num1 and $num2 is: $sum"
}

subtraction()
{
  sub=$((num1-num2))
  echo "The sub of $Num1 and $num2 is: $sub"
}

read_inputs
addition
subtraction

#----------------------------------------------------------------------------

#!/bin/bash
display()
{
  y=55
  echo "The variable value of x is: $x"
  local x=67
  local p=78
}

x=5
display

echo "The value of a variable y is: $y"
echo "The x value after calling display function: $x"
echo "The value of p is: $p"
```

## How to create csv file using shell script