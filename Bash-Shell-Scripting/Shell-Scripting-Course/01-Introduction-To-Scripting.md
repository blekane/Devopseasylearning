# Instroduction to Linux Shell Scripting

## What is a shell?
- Shell read input from the standard input device or from the file and send it to the kernel.
- Shell is a program that takes commands from the keyboard and passes them to the operating system (kernel) for execution
- Shell is exactly called a user interface that we use to interact with the OS or kernel.

![](/images/sh.JPG)

## Types of Shell
There are two main shells in Linux:

**1. The Bourne Shell:** The prompt for this shell is $ and its derivatives are listed below:
- Bourne shell (sh)
- Korn shell (ksh)
- POSIX shell (sh)
- Bourne Again Shell also knew as bash (most popular)

**2. The C shell:** The prompt for this shell is `%`, and its subcategories are:
- C shell also is known as csh`
- TENEX/TOPS C shell (tcsh)

## How to display all the shells in that unix or linux support?
List the content of /etc/shells
```
cat /etc/shells
```

## The default shell in linux 
When we install linux, the default shell is bash and we can use `$SHELL` in the CLI to check the default shell.
echo $SHELL

## What is bash?
- It stand for bourne again shell invented by **Stephen Bourne**
- It is an enhanced version of bourne shell (sh) which was was originally written by **Brian Fox**

## Why is bash so popular or why bash is a default shell in Linux?
This is because Stephen Bourne incorporated or added the following feature:
- Command alias
- Command completion by using tap key
- File completion
- The command history
- We do not need to repeat the command that we type previously, we can just use the up arrow key to record the command
- **NB:** we do not see these features in other shells


## What is a script or shell scripting?
- It is an executable file or a program that carries out instructions to accomplier a specific task, one task or multiple tasks at the same time.
- It is writing a series of commands for the shell to execute. you can combine lengthy and repetitive sequences of commands into a single and simple script, which can be stored and executed anytime. This reduces the effort required by the end user.

## Advantages  of shell script:
- Time saving
- Automation
- To avoid error
- To avoid repetitive work

## Disadvantages of shell scripts
- A single mistake can change the command which might be harmful
- Slow execution speed (compare to Ansible)
- Not well suited for large and complex task 


## What is a sherbeng?
It is the first line in the script which indicates the environment the script needs to be run. It consists of a number sign and an exclamation point character `(#!)`, followed by the full path to the **interpreter** such as `/bin/bash`. All scripts under Linux execute using the interpreter specified on the first line.

**NB:** If we do not put the sherbeng in Linux, the script will still run because the default shell on Linux is bash. This is because we are in the bash environment. 

## Example of sherbeng:
```
#!/usr/bin/env bash (for bash shell script)
#!/bin/bash (for bash shell script)
#!/usr/bin/python3 (for python shell script)
```

## Let us understand the steps in creating a Shell Script
- Create a file using a vi or vim editor or VS code (or any other editor).Name script file with extension `.sh`
- Start the script with `#!` you interpreter `(#! /bin/bash)`
- Author and date
- Write some code.
- Save the script file as `filename.sh` for instance
- Give execute permission `chmod +x filename.sh`
For executing the script type bash filename.sh or `./filename.sh` or `sh filename.sh` or `bash filename.sh`


## Commentts in shell script
You can put your comments in your script as follows
```sh
#!/bin/bash
# Author :Ali
# Date:
# Script follows here:
pwd
ls
```

Save the above content and make the script executable 
```
chmod +x test.sh
```

The shell script is now ready to be executed
```
./test.sh
```