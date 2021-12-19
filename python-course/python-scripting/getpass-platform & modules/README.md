# Introduction to Modules of Python

### What is a module ?
A module is a file containing Python definitions and statements. That means, module containing python functions, classes and variables.

### What is the use of module ?
Reusability
Note: If script name is mymodule.py then module name is mymodule

### Types of Python Modules:
- Default Modules
- Third Party Modules
Import either default or third party modules before using them.

**Different ways to import module:**
 - from math import *
 - from math import pi,pow


 # Platform module
The platform module is used to access the underlying platform’s data such as hardware,
operating system and interpreter version info.

### How to use platform module in a script ?
First import platform module using below syntax:
- import platform
- import platform as pt
- from platform import *
- from platform import system, platform

```py
import os
import math
import sys
import platform
import subprocess
import time
import system

OR

import os,math,sys,platform,subprocess,time,system
```

### How to list all functions and variables of a platform module ?
- There is a built-in function to list all the function names (or variable names) in a module and that is dir() function.
- Then use dir() function as: print(dir(platform))

**How to get help of a platform module ?**
- From script: print(help(platform))
- From Python command line: help(platform)


### How to import a script as a module and use into another script (use variable)
We need to import the script into our script without .py and we can use it in the new script.
**NB:** Make those files are in the same directory

```py
# variables_file.y
USER="admin"
PASSWORD="admin12345"
```

```py
# useradd.py
import variables_file
import os,math,sys,platform,subprocess,time,system

print(variables_file.USER)
print(variables_file.PASSWORD)
print(f'The user password is: {variables_file.PASSWORD}')
print(f'The user usernamr is: {variables_file.USER}')

#OUTPUT
admin
admin12345
The user password is: admin12345
The user usernamr is: admin 
```

### platform module
The platform module is used to access the underlying platform’s data such as hardware,
operating system and interpreter version info.

### To get help on python shell
```py
import platform
dir(platform)
help(platform)
```
OR

```py
import platform

print(dir(platform))
print(help(platform))
```

### Some system info
```py
import platform

print('uname    :', platform.uname())
print('system   :', platform.system())
print('node     :', platform.node())
print('release  :', platform.release())
print('version  :', platform.version())
print('machine  :', platform.machine())
print('processor:', platform.processor())

print(f'Python version: {platform.python_version()}')

#OUTPUT
uname    : uname_result(system='Windows', node='DESKTOP-RIUBCF4', release='10', version='10.0.19041', machine='AMD64')
system   : Windows
node     : DESKTOP-RIUBCF4
release  : 10
version  : 10.0.19041
machine  : AMD64
processor: Intel64 Family 6 Model 69 Stepping 1, GenuineIntel 
Python version: 3.9.0
```

# getpass module ===> (getpass() and getuser())
- **getpass()** prompts the user for a password without echoing. The getpass module
provides a secure way to handle the password prompts where programs interact with
the users via the terminal.
- **getuser()** function displays the login name of the user. This function checks the
environment variables LOGNAME, USER, LNAME and USERNAME, in order, and returns
the value of the first non-empty string. 

```py
import getpass

DB_USER=input('Enter the DB username: ')
DB_PASS=getpass.getpass()
print(f'The DB username is {DB_USER} and his password is {DB_PASS}')

#OUTPUT
Enter the DB username: dbadmin
Password: 
The DB username is dbadmin and his password is dbadmin12345
```

```py
import getpass

DB_USER=input('Enter the DB username: ')
DB_PASS=getpass.getpass(prompt='Enter the user DB password: ')
print(f'The DB username is {DB_USER} and his password is {DB_PASS}')

#OUTPUT
Enter the DB username: dbadmin
Enter the user DB password: 
The DB username is dbadmin and his password is dbadmin12345
```
### Check the user that is login
```py
#!/usr/local/bin/python3
import getpass
WHOAMI=getpass.getuser()
print(f'The user that is currently login is: {WHOAMI}')

#OUTPUT
The user that is currently login is: tia
```

### Encryption password in Linux (Thin will only works on Linux OS)
```py
#!/usr/local/bin/python3
import getpass, os, crypt

DB_USER=input('Enter the DB username: ')
DB_PASS=getpass.getpass(prompt='Enter the user DB password: ')
print(f'The DB username is {DB_USER} and his password is {DB_PASS}')

encPass = crypt.crypt(DB_PASS)
print(f'The encryption password is: {encPass }')

#OUTPUT
Enter the DB username: dbadmin
Enter the user DB password: 
The DB username is dbadmin and his password is dbadmin12345
The encryption password is: $6$xW2WRBjDT1SOr7W7$ORM2/u4ckKZEDuCfvaiXZLRoTDRys.XZEEp8oRa.XMRQnSONhciY8h93kDBpQGqwXURay5I2c6n7OmbLh3M15.
```

### Create a user with password
```py
#!/usr/local/bin/python3
import getpass, os, subprocess, sys, crypt

def add_user():

    DB_USER=input('Enter the DB username: ')
    DB_PASS=getpass.getpass(prompt='Enter the user DB password: ')
    encPass = crypt.crypt(DB_PASS)
    
    subprocess.run(['useradd', '-p', encPass, DB_USER ])
    #print(f'The user {DB_USER} was added sucessfully.')
add_user()
```