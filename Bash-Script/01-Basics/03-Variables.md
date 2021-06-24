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
echo "Your home directory is: $PWD"
echo "Your present working directory is: $HOME"
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
