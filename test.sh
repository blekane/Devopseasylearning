

#------------------------COMMENTE------------------------
#!/bin/bash
<< COMMENT
Author: Tia Leo
Date: November  11, 2019
Modified on:             by:
Script to setup Jenkins on CentOS/RHEL 6.x and 7.x
COMMENT

echo "Testing comments in Linux"

<< TIA
Author: Tia Leo
Date: November  11, 2019 
Modified on:             by:
Script to setup Jenkins on CentOS/RHEL 6.x and 7.x
TIA

echo "Testing comments in Linux" 


#!/bin/bash
# Author: Tia Leo
# Date: November  11, 2019
# Modified on:             by:
# Script to setup Jenkins on CentOS/RHEL 6.x and 7.x

echo "Testing comments in Linux" # this is to test echo command



#!/bin/bash
<< COMMENT
This is single line comment  
COMMENT

echo "Hello world!"  
ls -l    #this is to ls command
# This is single line comment


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
echo "Testing comments in Linux" 
```
#----------------------VARIBLES--------------------------

#!/bin/bash
echo "The name of the your computer is: $HOSTNAME"
echo "Your home directory is: $PWD"
echo "Your present working directory is: $HOME"
echo "The Shell being used by the user: $SHELL"


#!/bin/bash
# Store linux comment as varible
testing=`date`
UNAME=`uname -a`
echo "The date and time are: $testing"
echo "The output of uname is: ${UNAME}"


#!/bin/bash
# Users defined variable
days1=10
guest1="Katie"
echo "${guest1} checked in ${days1} days ago"
days2=5
guest2="Jessica"
echo "${guest2} checked in ${days2} days ago"


#!/bin/bash
# assigning a variable value to another variable
value1=10
value2=$value1
echo The resulting value is $value2




#------------------------ ECHO COMMAND-----------------------
#!/bin/bash
read -p "Enter the your first name: " FIRST_NAME 
read -p "Enter the your last name: " LAST_NAME
read -p "Enter your age: " AGE
echo "Hello $LAST_NAME! Your first name is $FIRST_NAME, your last name is $LAST_NAME and you are $AGE years old."

#!/bin/bash
echo "Enter the your first name: "
read FIRST_NAME 
echo "Enter the your last name: "
read LAST_NAME
echo "Enter your age: "
read AGE
echo "Hello $LAST_NAME! Your first name is $FIRST_NAME, your last name is $LAST_NAME and you are $AGE years old."



#!/bin/bash
read -p "Enter the your first name: " FIRST_NAME 
read -p "Enter the your last name: " LAST_NAME
read -p "Enter your age: " AGE
read -s -p "Enter your password: " PASSWORD

echo "Hello $LAST_NAME! Your first name is $FIRST_NAME, your last name is $LAST_NAME and you are $AGE years old. You password is $PASSWORD"

#!/bin/bash
#!/bin/bash
read -p "Enter the your first name: " FIRST_NAME 
read -p "Enter the your last name: " LAST_NAME
read -p "Enter your age: " AGE
read -s -p "Enter your password: " PASSWORD

echo -e "Hello $LAST_NAME! \nYour first name is :$FIRST_NAME \nYour last name is: $LAST_NAME \nYou are $AGE years old \nYou password is: $PASSWORD"


#!/bin/bash
#!/bin/bash
read -p "Enter the your first name: " FIRST_NAME 
read -p "Enter the your last name: " LAST_NAME
read -p "Enter your age: " AGE
read -s -p "Enter your password: " PASSWORD

echo -e "Hello $LAST_NAME! \n
Your first name is :$FIRST_NAME \n
Your last name is: $LAST_NAME \n
You are $AGE years old \n
You password is: $PASSWORD"


#!/bin/bash
read -p "Enter the your first name: " FIRST_NAME 
read -p "Enter the your last name: " LAST_NAME
read -p "Enter your age: " AGE
read -s -p "Enter your password: " PASSWORD

useradd $FIRST_NAME  
usermod -c "$FIRST_NAME $LAST_NAME" $FIRST_NAME
cat /etc/passwd |grep $FIRST_NAME 


#!/bin/bash
echo "The name of the your computer is: $HOSTNAME"
echo "Your home directory is: $PWD"
echo "Your present working directory is: $HOME"
echo "The Shell being used by the user: $SHELL"
echo "The user who is currently login is: $USER"
echo "The user ID is: $ID"

echo "The kernel version is: `uname -r`"
echo "The kernel version is: $(uname -r)"
echo -e "Date and calendar: \n `date` \n `cal`"

#!/bin/bash
cat << EOF
The name of the your computer is: $HOSTNAME
Your home directory is: $PWD"
Your present working directory is: $HOME
The Shell being used by the user: $SHELL
The user who is currently login is: $USER
The user ID is: $ID"

The kernel version is: `uname -r`
The kernel version is: $(uname -r)
EOF

#!/bin/bash
echo
cat << EOF
- This concept is useful to write simple and short shell scripts.
- Chaining of Linux commands means, combining several commands and make them execute based upon the behavior of operator used in between them.
- The different Command Chaining Operators are:
    - Semi-colon Operator ;
    - Logical AND Operators &&
    - Logical OR Operator ||
    - Logical AND - OR Operators && ||
EOF
echo


#Bash If Statement Examples ( If then fi, If then else fi, If elif else fi, Nested if )

`In Bash, we have the following conditional statements:`
    - if..then..fi statement (Simple If)
    - if..then..else..fi statement (If-Else)
    - if..elif..else..fi statement (Else If ladder)
    - if..then..else..if..then..fi..fi..(Nested if)


#------------------------Bash If..then..fi statement-----------------------

#!/bin/bash
if [ conditional expression ]
then
	statement1
	statement2
	.
fi

#!/bin/bash
count=100
if [ $count -eq 100 ]
then
  echo "Count is 100"
fi


#!/bin/bash
echo -n "Enter a number: "
read VAR
 
if [[ $VAR -gt 10 ]]
then
  echo "The variable is greater than 10."
fi


#!/bin/bash
read -p "Enter a number: " NUMBER
if [[ $NUMBER -gt 10 ]]
then
  echo "The variable is greater than 10."
fi


##-----------Bash If..then..else..fi statement----------
If [ conditional expression ]
then
	statement1
	statement2
	.
else
	statement3
	statement4
	.
fi


#!/bin/bash
count=99
if [ $count -eq 100 ]
then
  echo "Count is 100"
else
  echo "Count is not 100"
fi

#!/bin/bash
read -p "Enter the first name: " FIRST_NAME 
read -p "Enter the first name: " LAST_NAME 
 
if [[ $VAR -gt 10 ]]
then
  echo "The variable is greater than 10."
else
  echo "The variable is equal or less than 10."
fi



#!/bin/bash
count=99
if [ $count -eq 100 ]
then
  echo "Count is 100"
elif [ $count -gt 100 ]
then
  echo "Count is greater than 100"
else
  echo "Count is less than 100"
fi

echo -e "\nPlease make a choice below:   \n
        *********************************
        *       1==> cpu                *
        *       2==> Memory             *
        *       3==> Os version         *
        *       4==> processes          *
        *       5==> system bits        *
        *       6==> mount points       *
        *       7==> ip address         *
        *       8==> Hostname           *
        *       9==> Kernel version     *
        *       10==> update OS         *
        *********************************\n"

echo -n " Enter your choice (1 - 10):   "
read ans


if  [ ${ans} -eq 1 ] 
then
lscpu

elif  [ ${ans} -eq 2 ]
then
free -h

elif [ ${ans} -eq 3 ]
then
cat /etc/*release

elif [ ${ans} -eq 4 ] 
then
ps -ef

elif [ ${ans} -eq 5 ]
then
getconf LONG_BIT

elif [ ${ans} -eq 6 ]
then
df -h

elif  [ ${ans} -eq 7 ] 
then
ip a

elif  [ ${ans} -eq 8 ]
then
hostname

elif  [ ${ans} -eq 9 ] 
then
uname -r

elif  [ ${ans} -eq 10 ] 
then
yum update -y

else
echo -e "\nPlease enter a valid choice (1- 10) \n"
exit 2
fi


##-----------Bash If..elif..else..fi--------------------
If [ conditional expression1 ]
then
	statement1
	statement2
	.
elif [ conditional expression2 ]
then
	statement3
	statement4
	.
.
.
else
	statement5
fi


#!/bin/bash
count=99
if [ $count -eq 100 ]
then
  echo "Count is 100"
elif [ $count -gt 100 ]
then
  echo "Count is greater than 100"
else
  echo "Count is less than 100"
fi


##-----------Bash If..then..else..if..then..fi..fi..---------

If [ conditional expression1 ]
then
	statement1
	statement2
	.
else
	if [ conditional expression2 ]
	then
		statement3
		.
	fi
fi


#!/bin/bash
count=99
if [ $count -eq 100 ]
then
  echo "Count is 100"
else
  if [ $count -gt 100 ]
  then
    echo "Count is greater than 100"
  else
  echo "Count is less than 100"
  fi
fi





**The different Command Chaining Operators are:**
- Semi-colon Operator `;`
- Logical AND Operators `&&`
- Logical OR Operator `||`
- Logical `AND` - `OR` Operators && `||`

**Note:**
- cmd1 ; cmd2 : Run cmd1 and then cmd2, regardless of the success or failure of cmd1
- cmd1 && cmd2 : Run cmd2 only if cmd1 succeeded
- cmd1 || cmd2 : Run cmd2 only if cmd1 failed
- cm1 && cmd2 || cmd3 : Run cmd2 if cm1 is success else run cmd3 
`cd "$(git rev-parse --show-toplevel)" || exit 2`: exit if you are not able the move into `"$(git rev-parse --show-toplevel)"`





## Comparison Operators with test command

Numbers:
[[ int1 -eq int2 ]]  or =    -- It return true if they are equal else false
[[ int1 -ne int2 ]]  or !=   -- It return false if they are not equal else true
[[ int1 -lt int2 ]]  or <    -- It return true if int1 is less than int2 else false
[[ int1 -le int2 ]]  or <=   -- It return true if int1 is less than or equal to int2 else false
[[ int1 -gt int2 ]]  or >    -- It return true if int1 is greater than int2 else false
[[ int1 -ge int2 ]]  or >=   -- It return true if int1 is greater than or equal to int2 else false

Strings:
[[ -z str ]]        -- It return true if the length of the str is zero else false
[[ -n str ]]        -- It return true if the length of the str is no-zero else false
[[ str1 == str2 ]]  -- It return true if both the strings are equal else false
[[ str1 != str2 ]]  -- It return true if both the strings are equal else false

File test Operators with test command
[[ -d file ]] -- It return true if the file/path is directory else false
[[ -f file ]] -- It return true if the file/path is a file else false
[[ -e file ]] -- It return true if the file/path is exists else false
[[ -r file ]] -- It return true if the file/path is readable else false
[[ -w file ]] -- It return true if the file/path is writable else false
[[ -x file ]] -- It return true if the file/path is executable else false




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

#!/bin/bash

function COVID() {
# && = AND
# || = OR
read -p "Enter the first name: " FIRST_NAME 
read -p "Enter the last name: " LAST_NAME
read -p "Enter age: " AGE
read -p "Do you have fever (y or n)?: " FEVER
read -p "Do you have a cough? (y or n): " COUGH
read -p "Do you have any difficulty breathing? (y or n): " BREATHING
read -p "Have you been in contact with someone who has been tested positive with the Coronavirus? (y or n): " CONTACT
read -p "Did you travel outside the United States for the past 2 weeks? (y or n): " TRAVEL
read -p "Is anyone in your house cough, fever, difficulty breathing or have been in contact with someone who has been tested positive for Coronavirus? (y or n): "  HOUSE

if [ "$FEVER" = "n" ] && [ "$COUGH" = "n" ] && [ "$BREATHING" = "n" ] && [ "$CONTACT" = "n" ] && [ "$TRAVEL" = "n" ] && [ "$HOUSE" = "n" ]
then
    echo "Hello $FIRST_NAME $LAST_NAME, You do not need to be tested for COVID-19"

elif [ "$FEVER" = "y" ] || [ "$COUGH" = "y" ] || [ "$BREATHING" = "y" ] || [ "$CONTACT" = "y" ] || [ "$TRAVEL" = "y" ] || [ "$HOUSE" = "y" ]
then   
    echo "Hello $FIRST_NAME $LAST_NAME, You  need to be tested for COVID-19"
else
    echo "Please $FIRST_NAME $LAST_NAME, please check your answers"
fi
}
COVID



echo
echo "Script name: $0"
echo "First argument: $1"
echo "Second argument: $2"
echo "Third argument: $3"
echo "Total number of command line arguments: $#"
echo

var_tom=$2


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


#!/bin/bash

<< COMMENT
Author: Tia Leo
Date: DEc  18, 2021
Modified on:             by:
This script is to check the server inventory
COMMENT

NATSTAT=`netstat -pnltu |grep 0.0.0.0:22 |grep -o 22`
UNAME=$(uname -r |grep -o 4.18)
MEMORY=` free -h |grep -i Mem: |grep -o 1.7Gi`
HHD=`df -h |grep -E /dev/nvme0n1p2 |grep -o 35G`

VAR1=Peter
VAR2=25
VAR3=Texas

echo
echo "SSH port that is open on this server is: $NATSTAT" 
sleep 2
echo 
echo "The Kernel version is: $UNAME"
sleep 2
echo 
echo "The total memory on this server is: $MEMORY"
sleep 2
echo 
echo "The root filesystem on this server is: $HHD"
sleep 2
echo 
echo "The number op CPU on this server is: $(nproc)"
echo
echo "$VAR1 is $VAR2 years old and he from $VAR3"



'''
Just a little happy new year script assignment for those who have requested. (It no mandatory though.)

Please write a script that will run on Centos (Red Hat) and Ubuntu servers. The script is going to do the following:
- Update the system
- Installed wget
- Installed curl
- Installed apache or HTTPD webserver
- Checked the memory, the root filesystem available
- Check if the user administrator exists. If yes, the script should not create the user. If not, the script should create a user.
'''

#! /bin/bash
#Author: Group 3
#Date: December 30 2021

echo "*****************Group 3 ***********"

sleep 2

UBUNTU=`cat /etc/*release |grep ID_LIKE |awk -F= '{print$2}'`
CENTOS=`cat /etc/*release |grep ID_LIKE |awk -F= '{print$2}'`

if [[ $UBUNTU == "debian" ]]
then
    echo "This is Ubuntu server"
    sleep 3
    echo

    echo "Updating the system"
    sleep 3
    apt update -y
    sleep 2
    echo

    echo "Installing wget"
    apt-get install wget #where is -y?
    sleep 2
    echo

    echo "Installing curl"
    apt install curl #where is -y?
    sleep 2
    echo

    echo "Installing Apache"
    apt-get install apache2 -y
    sleep 2
    echo

    echo "The file system available"
    FILESYSTEM_AVAILABLE=`df -h | awk '{print $1"\t "$4}'` ## I need the exact value of the file system available
    echo "$FILESYSTEM_AVAILABLE"
    sleep 2
    echo
    
    echo "Check if a user exits"
    sleep 1
    USERNAME=`cat /etc/passwd | grep administrator | awk -F: '{print$1}'`

    if [[ $USERNAME == administrator ]] # you might need a quote on administrator
    then
        echo "user $USERNAME found"
    else
        useradd administrator
        echo "user $USERNAME has been added"
    fi

# you didn't close the if statment


else [[ $CENTOS == "fedora" ]]  # this should be a new if statment. The output should not be fedora with quote ("fedora")
    echo "This is CentOs server"
    sleep 3

    echo "Updating the system"
    sleep 3
    yum update -y
    sleep 2

    echo "This is Ubuntu server" # duplicate of code
    sleep 3

    echo "Updating the system"  # duplicate of code
    sleep 3
    apt update -y
    sleep 2

    echo "Installing wget"
    yum install wget -y
    sleep 2

    echo "Installing curl"
    yum install curl
    sleep 2

    echo "Installing Apache"
    yum install httpd -y
    sleep 2

    echo "The file system available"
    FILESYSTEM_AVAILABLE=`df -h | awk '{print $1"\t "$4}'` ## I need the exact value of the file system available
    echo "$FILESYSTEM_AVAILABLE"
    sleep 2
    
    echo "Check if a user exits"
    sleep 1
    USERNAME=`cat /etc/passwd | grep administrator | awk -F: '{print$1}'`

    if [[ $USERNAME == administrator ]]
    then
        echo "user $USERNAME found"
    else
        useradd administrator
        echo "user $USERNAME has been added"
    fi

fi # well close





jeanbaptistedonkeng@gmail.com
bfranklin2716@gmail.com 
blandinekamdem04@gmail.com 
carrineyannicknintideme@gmail.com
cedrickengue@gmail.com
christ7289@gmail.com
yotioclaude7@gmail.com
fkyankey@gmail.com 
franois12@yahoo.fr 
zambougeorges27@gmail.com

kouakepn@yahoo.fr
njoya_tolale@yahoo.fr
henryene.02@gmail.com
igormoumbe1@gmail.com
sandrine.kamwa@gmail.com 
michelawono@gmail.com
kellymefenya2422@gmail.com
lefogue@gmail.com
kemvouachille@gmail.com
muketelp@gmail.com
juan.marietta@yahoo.fr 
kemvoumichelle@gmail.com
amythioune29@gmail.com
nelxofficial@gmail.com
patricktemgoua@gmail.com
pierretaboulatangue@gmail.com
raissatankeu@yahoo.fr
r.goune@outlook.com
sousmanethioune7@gmail.com
stephaniealimeta@gmail.com 
stchatchou@yahoo.com 
yougang2000@yahoo.fr
willyvaldesk@gmail.com
bruce_akono@icloud.com
bldvistes@gmail.com
cyprien.tchatchou@gmail.com
ijeberry2010@gmail.com
valdezebanda@gmail.com
lewath@yahoo.fr
christiankam66@gmail.com
kakovanel@gmail.com
DZALIALFRED@GMAIL.COM
philoyoum@gmail.com
fouateuderrick@gmail.com
zemkouonoel@gmail.com
papyssn@yahoo.com
Idikandji@outlook.com
princessokereke@gmail.com
arianemegne412@gmail.com
adelanoumbo1@gmail.com
stevetalek24@gmail.com
djeagouduclair@gmail.com
tchindamireille2012@gmail.com
arnauldnjamen04@gmail.com
laurenotedji@gmail.com
chendjoulevis@gmail.com
ericajet02@yahoo.com
fayesamboudiang@hotmail.com
alowasoh@gmail.com 
sandrakamtchoum@gmail.com 
amiemarieleegreen@gmail.com
kareendevops@gmail.com
jtchuenteu@gmail.com 
juanpolobiky@gmail.com
abdoulayethiam091@gmail.com
ingrid.yamndzi@gmail.com
nzombeng12@yahoo.com
kantinstephanetongue@gmail.com
nellycarolle@gmail.com
gaellepone@gmail.com
jwandji76@gmail.com
bertinecesao@outlook.com
simplicewk@gmail.com
lucy4miracle@yahoo.com
jenfoko@gmail.com
prodigyladis@gmail.com