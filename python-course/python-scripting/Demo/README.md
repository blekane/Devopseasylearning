### Run multiple command based on OS module
```py
#!/usr/local/bin/python3
import os
a = os.system('ls -l && uptime && cal && cat /etc/passwd |grep root && cat /etc/*release')
print(a)
```

### Working with platform to manage multiple OS
```py
#!/usr/local/bin/python3
import os, platform
if platform.system() == "Windows":
     os.system("dir")
elif platform.system() == "Linux":
    os.system('ls -l') 
elif platform.system() == "Ubuntu":
    os.system('apt-get install git -y') 
else:
     print("Wrong OS platform")


#!/usr/local/bin/python3
import os
import platform
if platform.system()=="Windows":
    os.system("cls")
else:
    os.system("clear")
```

### Install packages base on exit code
```py
#!/usr/local/bin/python3
import os
returned_value = os.system("git --version")  
print(returned_value) # returns the exit code in unix

if os.system("git --version") == 0:
    print("Git is install already")
else: 
    os.system("yum install git -y")

#Output
git version 1.8.3.1
0

#!/usr/local/bin/python3
import os
if os.system("git --version") == 0:
    os.system("yum remove git -y")
else:
    print("Git is not installed")
```

```py
#!/usr/local/bin/python3
import os
KERNEL_VERSION=os.system("uname -r |cut -d. -f1")
#print(f"KERNEL CHECK FAILED. The kernel version on the server is: {os.system("uname -r |cut -d. -f1")}")
print(f"KERNEL CHECK FAILED. The kernel version on the server is {KERNEL_VERSION}")

#Output
3
KERNEL CHECK FAILED. The kernel version on the server is 0 # 0 is the exit code
```

```py
#!/usr/local/bin/python3
import os

if os.system("uname -r |cut -d. -f1 > /dev/null 2>&1 ") >= 3:
    print(f"KERNEL CHECK FAILED.")
else:
    print(f"KERNEL CHECK PASSED.")
```

```py
#!/usr/local/bin/python3
import os

id=os.system("id admin  > /dev/null 2>&1")
if id == 0:
    print("The Use admin exists already on this server")
else:
    
    os.system("useradd admin") 
    os.system("sed -i '/^admin/d' /etc/sudoers")
    os.system("sed -i '/NOPASSWD: ALL/aadmin  ALL=(ALL)       ALL' /etc/sudoers")
```

### Add a User in Linux using Python Script (pure)

```py
#!/usr/local/bin/python3
import os 
import subprocess 
import sys 
import getpass 
import crypt
  

def add_user():    
    #Ask for the input 
    username = input("Enter Username: ")    
  
    #Asking for users password 
    password = getpass.getpass() 
    encPass = crypt.crypt(password)

    try:
        subprocess.run(['useradd', '-p', encPass, username ])  
    except Exception as e:
        print(e)
add_user() 
```

### Add a User in Linux using Python Script (pure)
import crypt
password = "12345"
crypt.crypt(password)

```py
#!/usr/local/bin/python3
# importing linrary 
import os 
import subprocess 
import sys 
import getpass 
import crypt
  
def add_user(): 
    
    id=os.system("id admin10  > /dev/null 2>&1") # this will give the exit code   
    username="admin10"
    password = "12345" 
    encPass = crypt.crypt(password)
    if id == 0: # to check the exit code
        print("The Use admin exists already on this server")
    else:
        print("")
        subprocess.run(['useradd', '-p', encPass, username ])
        os.system("sed -i '/^admin10/d' /etc/sudoers")
        os.system("sed -i '/NOPASSWD: ALL/aadmin10  ALL=(ALL)       ALL' /etc/sudoers")
add_user() 


#!/usr/local/bin/python3
import os 
import subprocess 
import sys 
import getpass 
import crypt

def add_user():    
    username="admin"
    password = "12345" 
    encPass = crypt.crypt(password)
    try:
        subprocess.run(['useradd', '-p', encPass, username ])
        os.system("sed -i '/^admin/d' /etc/sudoers")
        os.system("sed -i '/NOPASSWD: ALL/aadmin  ALL=(ALL)       ALL' /etc/sudoers")    
    except Exception as e:
        print(e)
add_user() 
```

### Encrypt a password
```py
#!/usr/local/bin/python3
# importing linrary 
import crypt 
def add_user(): 
    password = "12345"
    encPass=crypt.crypt(password)
    print(encPass)
add_user() 
```

### Use encryption password to create a user (pure)
```py
#!/usr/local/bin/python3
# importing linrary 
import os 
import subprocess 
import sys 
import getpass 
import crypt
  
def add_user(): 
    
    id=os.system("id admin15  > /dev/null 2>&1") # this will give the exit code   
    username="admin15"
    password = "$6$4T1sur0zaOYhr.5W$NQAeVotk.LYwGUL21HElNNWqgIdJlZrvAXCzBj56amyvqTaGj1j39RgnVumOSDSfBmwg5geGVcrGRQpGmop44." 
    if id == 0: # to check the exit code
        print("The Use admin exists already on this server")
    else:
        print("")
        subprocess.run(['useradd', '-p', password, username ])
        os.system("sed -i '/^admin15/d' /etc/sudoers")
        os.system("sed -i '/NOPASSWD: ALL/aadmin15  ALL=(ALL)       ALL' /etc/sudoers")
add_user() 



#!/usr/local/bin/python3
import os 
import subprocess 
import sys 
import getpass 
import crypt

def add_user():    
    username="admin"
    password = "$6$4T1sur0zaOYhr.5W$NQAeVotk.LYwGUL21HElNNWqgIdJlZrvAXCzBj56amyvqTaGj1j39RgnVumOSDSfBmwg5geGVcrGRQpGmop44." 
    try:
        subprocess.run(['useradd', '-p', password, username ])
        os.system("sed -i '/^admin/d' /etc/sudoers")
        os.system("sed -i '/NOPASSWD: ALL/aadmin  ALL=(ALL)       ALL' /etc/sudoers")    
    except Exception as error:
        print(error)
add_user() 

```

### Deleting a User in Linux using Python Script
```py
#!/usr/local/bin/python3
import os 
import subprocess 
import sys 
import getpass 
  
def delete_user(): 
     username = input("Enter Username : ") 
  
     try: 
         output = subprocess.run(['userdel -r', username ]) 
         if output.returncode == 0: 
             print("User successfully deleted with given credentials") 
  
     except: 
         print(f"Failed to delete user.") 
         sys.exit(1) 
  
delete_user() 
```

### How to call a shell script from python code?
```py
#with test.sh in the same folder:
#!/bin/sh
yum install -y git
```

```py
#!/usr/local/bin/python3
import os
#os.system("your command here")
# or
os.system('chmod +x test.sh')
os.system('sh test.sh')
#os.system('sh /tmp/file.sh')
``` 

```py
#!/usr/local/bin/python3
import subprocess
import shlex
os.system('chmod +x test.sh')
subprocess.call(shlex.split('./test.sh'))
```

```py
#!/usr/local/bin/python3
import os
import subprocess
import shlex
os.system('chmod +x test.sh')
subprocess.call(shlex.split('bash /home/tia/Downloads/test.sh'))
```

```py
#!/usr/local/bin/python3
import os
import subprocess
os.system('chmod +x test.sh')
subprocess.call(['sh', './test.sh'])
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


#!/usr/local/bin/python3
import os

def add_user():    

    try:
        os.system("yum -y install httpd")
        os.system("systemctl start httpd  && systemctl enable httpd")
        os.chdir("/var/www/html")
        os.system("echo welecome to httpd Web page > index.html")
        os.system("firewall-cmd --zone=public --permanent --add-port=80/tcp && firewall-cmd --reload")  
    except Exception as e:
        print(e)
add_user() 
print('end')
```

### Check if a path is file, link or dir
```py
import os
path="/tmp"

if os.path.isfile(path):
    print(f"{path} is a file")
elif os.path.isdir(path):
    print(f"{path} is a directory")
elif os.path.islink(path):
    print(f"{path} is a link")
else:
    os.system("Error")
```

### Take decision base on exit code
```py
#!/usr/local/bin/python3
import os
cmd="uptime"
exit_code=os.system(cmd) # this will store the exit code value
if exit_code==0:
    print("Your command was sucessfully executed")
    print(exit_code)
else:
    print("You command was failed")
    print(exit_code)
```