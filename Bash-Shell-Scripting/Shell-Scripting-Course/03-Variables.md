# Variables in Linux Shell Scripting

## Variables in bash shell script
Bash variables provide temporary storage for information that will be needed during the lifespan of the program.

## There are 2 types of variables:
- Users defined variable (local variables and global variables)
- Environment variables or shell variable

**Syntax:**
```
VARNAME=VALUE
```
**Note:**

- There should not be any space around `=` sign in variable assignment.
- When you use `VAR=VALUE`, the shell sees the `=` as a symbol and treats the command as a variable assignment. 
- When you use `VAR = VALUE`, the shell assumes that VAR must be the name of a command and tries to execute it.
- Shell does not care about the type of variables. Variables could store strings, integers, or real numbers.

## Here are a few quick points on syntax. 
- When referring to a variable we place a `$` sign before the variable name `echo $VALUE`
- When setting a variable we leave out the `$` sign `VAR=VALUE`
- Some people like to always write variable names in uppercase so they stand out. It's your preference however. They can be all uppercase, all lowercase, or a mixture.
- A variable may be placed anywhere in a script. when you run the script, Bash will replace it with the value of the variable. This is made possible as the substitution is done before the command is run.

## Here are some things to remember while printing variables:
- A variable in single quotes `'` is treated as a literal string, and not as a variable.
- Variables in quotation marks `"`  are treated as variables.
- To get the value held in a variable, you have to provide the dollar sign `$`.
- A variable without the dollar sign `$` only provides the name of the variable.

```sh
tia@localhost tia]# my_name=tia
[root@localhost tia]# echo '$my_name'
$my_name
[root@localhost tia]# echo "$my_name"
tia
[root@localhost tia]# echo $my_name
tia
[root@localhost tia]# echo my_name
my_name
[root@localhost tia]# 
```

## Environment Variables
The Environment Variables form a simple and effective way to pass information about the current operating environment to the program being executed.

**To see the active environment variables in your Bash session, use this command:**
```
env | less
```

```sh
echo "The name of the your computer is: $HOSTNAME"
echo "Your home directory is: $HOME"
echo "Your present working directory is: $PWD"
echo "The Shell being used by the user: $SHELL"
echo "The user who is currently login is: $USER"
echo "The user ID is: $ID"
```

**RESULT:**
```sh
The name of the your computer is: localhost.localdomain
Your home directory is :/home/tia
Your present working directory is: /home/tia/Desktop/shells
The Shell being used by the user /bin/bash
The user who is currently login is: tia
The user ID is: 1000
```

## Working with Special Variables
**- $0:** This will return the script name 

**- $#:** How many command line parameters were passed to the script.

**- $@:** All the command line parameters passed to the script.

**- $?:** The exit status of the last process to run.

**- $$:** The Process ID (PID) of the current script.

**- $USER:** The username of the user executing the script.

**- $HOSTNAME:** The hostname of the computer running the script.

**- $SECONDS:** The number of seconds the script has been running for.

**- $LINENO:** Returns the current line number of the script.

## Example 1:
You want to see all of them in one script, don’t you? You can! Save the following as a text file called, `special.sh`
```sh
#!/bin/bash
echo "There were $# command line parameters or arguments"
echo "They are: $@"
echo "Parameter 1 is: $1"
echo "The script is called: $0"
pwd
echo "pwd returned $?" # to see the return code of the pwd command
echo "This script has Process ID $$"
echo "The script was started by $USER"
echo "It is running on $HOSTNAME"
sleep 3
echo "It has been running for $SECONDS seconds"
echo "This is line number $LINENO of the script"
```

Type the following to make it executable: `chmod +x special.sh`

**RESULT:**

```
[root@localhost tia]# ./special.sh alpha bravo charlie 56 2048 thursday
There were 6 command line parameters or arguments
They are: alpha bravo charlie 56 2048 thursday
Parameter 1 is: alpha
The script is called: ./special.sh
/home/tia
pwd returned 0
This script has Process ID 20403
The script was started by tia
It is running on localhost.localdomain
It has been running for 3 seconds
This is line number 15 of the script
[root@localhost tia]#
```

## Example 2:
```sh
#!/bin/bash
echo "With this script called $0, I will give you today's date"
echo "A date has actually $# portions: date of week; date of month; month; year"
echo -e "\t-The day of the week is: $1"
echo -e "\t-the day of the month is: $2"
echo -e "\t-the actual month is: $3"
echo -e "\t-the actual year is: $4"
```

**RESULT:**

```
[root@server1 ~]# ./script.sh Friday 3 April 2020
With this script called ./script.sh, I will give you today's date
A date has actually 4 portions: date of week; date of month; month; year
        -The day of the week is: Friday
        -the day of the month is: 3
        -the actual month is: April
        -the actual year is: 2020
[root@server1 ~]#
```

## Working with local and global variables
**Example 1:**

```sh
#!/bin/bash
GLOBAL_VARIABLE="This is a global variable"
 
function global_variable() {
LOCAL_VARIABLE="This is a global variable"
}
 
function local_variable() {
echo $LOCAL_VARIABLE
echo $GLOBAL_VARIABLE
}
local_variable
```

**RESULT:**
```
This is a global variable
```

**Example 2:** 
```sh
#!/bin/bash
x=JOHN
function testvar1 () {
    local E=PAUL
    echo "the value of the variable E here is :$E"
{
testvar1
 
function testvar2 () {
    echo "In this second function I can still call the variable x :$x"
    echo "In this second function I cannot call the variable E :$E"
}
testvar2
```
**RESULT:**
```
[root@server1 ~]# ./script.sh
the value of the variable E here is :PAUL
In this second function I can still call the variable x :JOHN
In this second function I cannot call the variable E :
```

**Example 3:** 
```sh
read -p "1- Enter the first name: " FIRST_NAME 
read -p "2- Enter the last name: " LAST_NAME
read -p "3- Enter age: " AGE
read -p "4- Do you have fever (y or n)?: " FEVER
read -p "5- Do you have a cough? (y or n): " COUGH
read -p "6- Do you have any difficulty breathing? (y or n): " BREATHING
read -p "7- Have you been in contact with someone who has been tested positive with the Coronavirus? (y or n): " CONTACT
read -p "8- Did you travel outside the United States for the past 2 weeks? (y or n): " TRAVEL
read -p "9- Is anyone in your house cough, fever, difficulty breathing or have been in contact with someone who has been tested positive for Coronavirus? (y or n): "  HOUSE

echo "Below are your answers:"
#echo -e "1- $FIRST_NAME\n2- $LAST_NAME\n3- $AGE\n4- $FEVER\n5- $COUGH\n6- $BREATHING\n7- $CONTACT\n8- $TRAVEL\n9- $HOUSE"

echo "1- $FIRST_NAME"
echo "2- $LAST_NAME"
echo "3- $AGE"
echo "4- $FEVER"
echo "5- $COUGH"
echo "6- $BREATHING"
echo "7- $CONTACT"
echo "8- $TRAVEL"
echo "9- $HOUSE"
```

**Example 0:** 
```sh
#!/bin/bash

#Description: This script will create a user, group, shell and add the user to a group as primary and secondary group

# Author: Tia M
# Date: July 11, 2021

read -p "Enter the first name: " FIRST_NAME
read -p "Enter the last name: " LAST_NAME
read -p "Enter the group that you will like to create: " GROUP
read -p "Enter the user shell: " SHELL

groupadd $GROUP
useradd -c "$FIRST_NAME $LAST_NAME" -G $GROUP -s $SHELL $FIRST_NAME  

echo 
cat /etc/passwd |grep $FIRST_NAME

echo
cat /etc/group |grep $GROUP
```

**Example 4:** 
```sh
#! /bin/bash

# This script will create a user account
read -p "Enter the first name: " FIRST_NAME 
read -p "Enter the last name: " LAST_NAME

FIRST_NAME2=`echo "$FIRST_NAME" | tr '[:upper:]' '[:lower:]'`
LAST_NAME2=`echo "$LAST_NAME" | tr '[:upper:]' '[:lower:]'`

useradd $FIRST_NAME2
echo "Enter you password and confirm"
passwd $FIRST_NAME2
```

**Example 5:** 
```sh
#! /bin/bash

# This script will create a user account
read -p "Enter the first name: " FIRST_NAME 
read -p "Enter the last name: " LAST_NAME

FIRST_NAME2=`echo "$FIRST_NAME" | tr '[:upper:]' '[:lower:]'`
LAST_NAME2=`echo "$LAST_NAME" | tr '[:upper:]' '[:lower:]'`

useradd $FIRST_NAME2
usermod -c "$FIRST_NAME $LAST_NAME" $FIRST_NAME2
echo "Enter you password and confirm"
passwd $FIRST_NAME2

cat /etc/passwd |grep $FIRST_NAME2
cat /etc/shadow |grep $FIRST_NAME2
```

**Example 6:** 
```sh
#!/bin/bash
echo -n "Enter username: "
read username
echo -n "Enter password: "
read -s passwd
echo
echo "$username, the password entered is $passwd"
```

**Example 7:** 
```sh
#! /bin/bash

# This script will create a user account
echo -n "Enter the first name: " 
read FIRST_NAME 
echo -n "Enter the last name: " 
read LAST_NAME
echo -n "Enter the password: " 
read -s PASSWORD

echo -e "\nYou first name is: $FIRST_NAME, you last name is: $LAST_NAME and the password entered is $PASSWORD"
```

**Example 8:** 
```sh
#! /bin/bash

# This script will create a user account
echo -n "Enter the first name: " 
read FIRST_NAME 
echo -n "Enter the last name: " 
read LAST_NAME
echo -n "Enter the password: " 
read -s PASSWORD

#echo -e "\nYou first name is: $FIRST_NAME, you last name is: $LAST_NAME and the password entered is $PASSWORD"

FIRST_NAME2=`echo "$FIRST_NAME" | tr '[:upper:]' '[:lower:]'`
PASSWORD2=$FIRST_NAME2@$PASSWORD

useradd $FIRST_NAME2
usermod -c "$FIRST_NAME $LAST_NAME" $FIRST_NAME2
echo $PASSWORD2 | passwd --stdin $FIRST_NAME2

cat /etc/passwd |grep $FIRST_NAME2
cat /etc/shadow |grep $FIRST_NAME2
```

**NB:** This script will work well only in **CentOs** because there is no option call `--stdin` in **Ubuntu**

- [passwd: unrecognized option '--stdin' error on Debian when I run my created Bash Script](https://stackoverflow.com/questions/54382242/passwd-unrecognized-option-stdin-error-on-debian-when-i-run-my-created-bash)

I am using Debian. I am learning Bash scripting. I am creating a script that creates new user and sets password the problem is I get passwd: unrecognized option '--stdin' error

That is my script:
```sh
#!/bin/bash
read -p "Please Enter Your Real Name: " REAL_NAME 
read -p "Please Enter Your User Name: " USER_NAME 
useradd -c "${COMMENT}" -m ${USER_NAME} 
read -p "Please Enter Your Password: " PASSWORD
echo ${PASSWORD} | passwd --stdin ${USER_NAME}
passwd -e ${USER_NAME}
```

There is no `--stdin` option, and you need to protect your variable with quotes.
This is a working version:
```sh
#!/bin/bash
read -p "Please Enter Your Real Name: " REAL_NAME 
read -p "Please Enter Your User Name: " USER_NAME 
useradd -c "${COMMENT}" -m ${USER_NAME} 
read -p "Please Enter Your Password: " PASSWORD
echo -e "$PASSWORD\n$PASSWORD" |passwd "$USER_NAME"
passwd -e ${USER_NAME}
```

**Example 9: RESOLUTION** 
```sh
#! /bin/bash

# This script will create a user account
echo -n "Enter the first name: " 
read FIRST_NAME 
echo -n "Enter the last name: " 
read LAST_NAME
echo -n "Enter the password: " 
read -s PASSWORD

#echo -e "\nYou first name is: $FIRST_NAME, you last name is: $LAST_NAME and the password entered is $PASSWORD"

FIRST_NAME2=`echo "$FIRST_NAME" | tr '[:upper:]' '[:lower:]'`
PASSWORD2=$FIRST_NAME2@$PASSWORD

useradd $FIRST_NAME2
usermod -c "$FIRST_NAME $LAST_NAME" $FIRST_NAME2

echo -e "$PASSWORD2\n$PASSWORD2" |passwd "$FIRST_NAME2"
passwd -e ${FIRST_NAME2}

cat /etc/passwd |grep $FIRST_NAME2
cat /etc/shadow |grep $FIRST_NAME2
```