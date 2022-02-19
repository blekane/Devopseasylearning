## Strip operations on strings
It will remove word at the beginning and end of a srting
This will remove space at the beginnig and the end of your string
```py
string1=" Python scripting for Devops course automation "
print(string1)
print(string1.strip())

#OUTPUT
 Python scripting for Devops course automation
Python scripting for Devops course automation
```

## Encrypt password
```py
#!/usr/bin/env python3

import subprocess
import time
import sys
import subprocess 
import getpass 
import crypt
import os

USERS = '''
kareen
TIA
biky
abdou
'''.lower().split()

password = USERS

def add_user(): 
    for e in password:
        encPass=crypt.crypt(e)
        print(encPass)
```

## Python version
```py
string1 = "  5Python3.9 "
print(string1.strip())
print(string1.strip('3.9'))
print(string1.strip().strip('3.9'))
print(string1.strip().strip('5').strip('3.9'))
print()

RESULT = string1.strip().strip('5').strip('Python')
print(RESULT)

if RESULT == 3.9:
    print("The python version is equal: {0}".format(RESULT))
else:
    print("The python version is not eqaul: {0}".format(RESULT))


#OUTPUT  
5Python3.9
  5Python3.9 
5Python      
Python       

3.9
The python version is not eqaul: 3.9
```

## Uname command
```py
UNAME = "Linux 4347d2fdde67 5.11.0-1022-aws #23~20.04.1-Ubuntu SMP Mon Nov 15 14:03:19 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux"
print(UNAME.split())
print(UNAME.split().index('5.11.0-1022-aws'))
print(UNAME.split()[2])
print(UNAME.split()[2].split("."))
print(UNAME.split()[2].split(".")[0])

RESULT = UNAME.split()[2].split(".")[0]
print(RESULT)

if RESULT == 5:
    print("The python version is equal: {0}".format(RESULT))
else:
    print("The python version is not eqaul: {0}".format(RESULT))


#OUTPUT 
['Linux', '4347d2fdde67', '5.11.0-1022-aws', '#23~20.04.1-Ubuntu', 'SMP', 'Mon', 'Nov', '15', '14:03:19', 'UTC', '2021', 'x86_64', 'x86_64', 'x86_64', 'GNU/Linux']
2
5.11.0-1022-aws
['5', '11', '0-1022-aws']
5
5
The python version is not eqaul: 5
```

## Print
```py
x = 3
y = 5.7
lan_name = "python scripting"
print(x, y, lan_name)
print("{} {} {}".format(x, y, lan_name))
print("{0} {1} {2}".format(x, y, lan_name))
print("{0} {1} {2}".format(y, lan_name, x))
print(f"{x} {y} {lan_name}")

#OUTPUT 
3 5.7 python scripting
3 5.7 python scripting
3 5.7 python scripting
5.7 python scripting 3
3 5.7 python scripting
```

## env
```py
import os
print(os.environ["HOME"])
print(os.environ["HOSTNAME"])
print(os.environ["PWD"])

#OUTPUT 
/root
6459c59c11d2
/student_home
```

## Bash version
```py
import subprocess
cmd = ["bash", "--version"]
sp = subprocess.Popen(cmd, shell=False, stdout=subprocess.PIPE,
                      stderr=subprocess.PIPE, universal_newlines=True)
rc = sp.wait()
out, e = sp.communicate()

if rc == 0:
    for each_line in out.splitlines():
        if "version" in each_line and "release" in each_line:
            print(each_line)
            print(each_line.split())
            print(each_line.split()[3])
            print(each_line.split()[3].split('('))
            print(each_line.split()[3].split('(')[0])
            print(each_line.split()[3].split('(')[0].split(".")[0])
            RESULT = (each_line.split()[3].split('(')[0].split(".")[0])
            print(RESULT)
            if RESULT >= "5":
                print("The bash version is Ok and it is: {}".format(RESULT))
            else:
                print("The bash version is Not Ok and it is: {}".format(RESULT))
```


## Packages installation
```py
#!/usr/bin/env python3

import subprocess

package_name = "apache2"
subprocess.run(["apt-get", "install", "-y", package_name], check=True)
```
#--------------------------------------------------------------------
```py
#!/usr/bin/env python3

import subprocess

PACKAGE_NAME = ["apache2", "tree", "git", "wget", "unzip"]

subprocess.run(["apt-get", "install", "-y", PACKAGE_NAME[0]], check=True)
subprocess.run(["apt-get", "install", "-y", PACKAGE_NAME[1]], check=True)
subprocess.run(["apt-get", "install", "-y", PACKAGE_NAME[2]], check=True)
subprocess.run(["apt-get", "install", "-y", PACKAGE_NAME[3]], check=True)
subprocess.run(["apt-get", "install", "-y", PACKAGE_NAME[4]], check=True)
```
#--------------------------------------------------------------------


```py
#!/usr/bin/env python3

import subprocess

PACKAGE_NAME = ["apache2", "tree", "git", "wget", "unzip"]
for i in PACKAGE_NAME:
    subprocess.run(["apt-get", "install", "-y", i], check=True)
```

#--------------------------------------------------------------------

```py
#!/usr/bin/env python3

import subprocess

PACKAGE_NAME = ["apache2", "tree", "git", "wget", "unzip"]
for i in PACKAGE_NAME:
    subprocess.run(["apt-get", "remove", "-y", i], check=True)
```

#--------------------------------------------------------------------
```py
#!/usr/bin/env python3

import subprocess

PACKAGE_NAME = ["apache2", "tree", "git", "wget", "unzip"]
for i in PACKAGE_NAME:
    subprocess.run(["apt-get", "install", "-y", i], check=True)
```



#--------------------------------------------------------------------
```py
#!/usr/bin/env python3

import subprocess

PACKAGE_NAME = ["apache2", "tree", "git", "wget", "unzip"]
CMD = "which"

for i in PACKAGE_NAME:
    sp = subprocess.Popen([CMD, i], shell=False, stdout=subprocess.PIPE,
                          stderr=subprocess.PIPE, universal_newlines=True)
    rc = sp.wait()
    out, err = sp.communicate()

    if rc == 0:
        print("{0} is already installed".format(i))
    else:
        print("Installing {0} ---------Please wait ----------".format(i))
        subprocess.run(["apt-get", "install", "-y", i], check=True)
```

#--------------------------------------------------------------------
```py
#!/usr/bin/env python3

import subprocess
import time

PACKAGE_NAME = ["apache2", "tree", "git", "wget", "unzip"]

for i in PACKAGE_NAME:
    sp = subprocess.Popen(["which", i], shell=False, stdout=subprocess.PIPE,
                          stderr=subprocess.PIPE, universal_newlines=True)
    rc = sp.wait()
    out, err = sp.communicate()

    if rc == 0:
        time.sleep(3)
        print("{0} is already installed".format(i))
        print(out)
    else:
        time.sleep(3)
        print("Installing {0} ---------Please wait ----------".format(i))
        subprocess.run(["apt-get", "install", "-y", i], check=True)
        print(out)
```
 
#--------------------------------------------------------------------
```py
#!/usr/bin/env python3

import subprocess
import time
import sys

PACKAGE_NAME = ["tom", "tim", "van", "david", "paul", "jhon"]

for i in PACKAGE_NAME:
    sp = subprocess.Popen(["cat /etc/passwd |grep -o  &>/dev/nul", i], shell=True, stdout=subprocess.PIPE,
                          stderr=subprocess.PIPE, universal_newlines=True)
    rc = sp.wait()
    out, err = sp.communicate()

    if rc == 0:
        time.sleep(3)
        print("User {0} is already exist on this server".format(i))
    else:
        time.sleep(3)
        print("Adding user {0} ---------Please wait ----------".format(i))
        subprocess.run(["useradd", i], check=True)
```

```py
#!/usr/bin/env python3

import subprocess
import time
import sys

USERS = '''
kareen
TIA
biky
abdou
'''.lower().split()


print(USERS)

for i in USERS:
    sp = subprocess.Popen(["id", i], shell=False, stdout=subprocess.PIPE,
                          stderr=subprocess.PIPE, universal_newlines=True)
    rc = sp.wait()
    out, err = sp.communicate()

    if rc == 0:
        print(f"the return code is: {rc}")
        time.sleep(3)
        print("User {0} is already exist on this server".format(i))
    else:
        time.sleep(3)
        print("Adding user {0} ---------Please wait ----------".format(i))
        subprocess.run(["useradd", i], check=True)
```


```py
import subprocess
output = subprocess.run(
    ["ls", "-l"], capture_output=True, universal_newlines=True)
print(output.stdout)

import subprocess
output = subprocess.run(
    ["ls -l"], capture_output=True, universal_newlines=True, shell=True)
print(output.stdout)
```


```py
import os
import getpass
import subprocess
import crypt

USER_NAME = input("Enter the username: ")
PASSWORD = getpass.getpass("Enter the user password: ")

exit_code=os.system("cat /etc/passwd |grep -o USER_NAME") # this will store the exit code value

if exit_code==0:
    print("User {} exist already on this server".format(USER_NAME))
else:
    encPass = crypt.crypt(PASSWORD)
    subprocess.run(['useradd', '-p', encPass, USER_NAME])
    print("User was added successfully".format(USER_NAME))



USER_NAME = "smith"
PASSWORD = "12345"

exit_code=os.system("cat /etc/passwd |grep -o smith") # this will store the exit code value

if exit_code==0:
    print("User {} exist already on this server".format(USER_NAME))
else:
    encPass = crypt.crypt(PASSWORD)
    subprocess.run(['useradd', '-p', encPass, USER_NAME])
    print("User was added successfully".format(USER_NAME))
```

```py
os.chdir("/tmp")
try:
    os.removedirs("tia")
except:
    print("The file do not exist")
finally:
    os.mkdir("tia")
```

### Install a web server with os.path()
```py
#!/usr/local/bin/python3
import os
path_httpd="/var/www/html"
print(os.path.exists(path_httpd))

if os.path.exists(path_httpd):
    print("Apache in install already")
else:
    os.system("yum -y install httpd")
    os.system("systemctl start httpd  && systemctl enable httpd")
    os.chdir("/var/www/html")
    os.system("echo welecome to httpd Web page >> index.html")
    os.system("firewall-cmd --zone=public --permanent --add-port=80/tcp && firewall-cmd --reload")
```

### Set and get env
```py
import os

# Set environment variables
os.environ['API_USER'] = 'username'
os.environ['API_PASSWORD'] = 'secret'

# Get environment variables
USER = os.getenv('API_USER')
PASSWORD = os.environ.get('API_PASSWORD')
SHELL = os.environ.get('SHELL')
UID= os.environ.get('UID')
print(os.environ['HOME'])
print(os.environ.get('HOME'))

# Getting non-existent keys
try:
    FOO = os.getenv('FOO')
    print(FOO)
except:
    print("ERROR")


print(USER)
print(PASSWORD)
print(SHELL)
print(UID)

# os.system("env")

# OUTPUT
/root
/root
None
username
secret
/bin/bash
None
```

### Check if a user is root
```py
import os
if os.getgid() == 0:
    print("Your are root")
elif os.getgid() != 0:
    print("Your are not root")
else:
    print("Hummmmmmm")
```

### Adding 2 paths
```py
import os
path1 = "/home"
path2 = "usr/tia"

print(path1+path2)
print(path1+'/'+path2)
print(os.path.join(path1,path2))


import os
P = 'python.py'
ENV = os.environ.get('HOME')
file_path = os.path.join(ENV, P)

print(file_path)
```