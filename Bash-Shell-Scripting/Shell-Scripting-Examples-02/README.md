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

which apache2 2>&1 1>/dev/nul && { echo; echo "Apache2 is installed on this host"; echo "The DApache2 version is: $(apache2 -v)"; } || { apt install apche2 -y; }

which git 2>&1 1>/dev/nul && { echo; echo "Git is installed on this host"; echo "The Git version is: $(git --version)"; } || { apt install git -y; }

which tree 2>&1 1>/dev/nul && { echo; echo "Tree is installed on this host"; echo "The tree version is: $(tree --version)"; } || { apt install tree -y; }

echo "All Done"
```




# if and if-else Conditional Statements
**Syntax:**
```sh
Cmd1 && Cmd2
if Cmd1
then
    Cmd2
fi

Cmd1 && { Cmd2 ; Cmd3 ; }
if Cmd1
then
    Cmd2
    Cmd3
fi


Cmd1 && Cmd2 || Cmd3
if Cmd1
then
    Cmd2
else
    Cmd3
fi

Cmd1 && { Cmd2 ; Cmd3 ; } || Cmd4
if Cmd1
then
    Cmd2
    Cmd3
else
    Cmd4
fi
```