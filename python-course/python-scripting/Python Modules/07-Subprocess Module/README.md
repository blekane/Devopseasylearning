## Subprocess Module: To execute any Operatin System Commands with python 
- We cannot store os.system command into a variable. os.system command will be printed by default and only the return code can be store into a variable.
- if we need to store the output of our command into a variable, we need to use a `Subprocess Module`

### Subprocess Module Syntax with notes
```py
import subprocess
sp=subprocess.Popen(cmd,shell=True/False,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
stdout=subprocess.PIPE # This will stored the standard output of the command
stderr=subprocess.PIPE # This will stored the standard error of the command
rc=sp.wait() # This will store a return code into a variable. if print(rc) is 0, this mean the command run sucessfully. if print(rc) is 0 not 0, this means the command fails
universal_newlines=True # this  will  print the standard output as a string
out,err=sp.communicate() # This will split the standard output and error into 2 variables

print(f'OUTPUT IS: {out}') # this  will  print the standard output
print(f'Error is: {err}') # this  will  print the standard error
print(f'Exit code or return code is: {rc}') # this  will  print the exit code

if shell=True then your cmd is a string (as your os command)
if shell=False then your cmd is a list

Note: shell=False dont work on your os environment variables
      shell=True  works on your os environment variables
      
ex: cmd="ls -lrt" ==> shell=True # This will open a new terminal and execute your command. Use it if you want to work with env variable because the execuation will be slow.
    cmd="ls -lrt".split()  or ['ls','-lrt']  ==> shell=False # This will use python terminal to run your code. As a result, it is faster than shell=True. It use when we do not need to use env
    cmd="ls -lrt" ==> shell=True always on windows
```


### Subprocess Module Syntax
```py
import subprocess
sp=subprocess.Popen(cmd,shell=True/False,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)

rc=sp.wait()
out,err=sp.communicate()
print(f'OUTPUT IS: {out}')
print(f'Error is: {err}')
print(f'Exit code or return code is: {rc}')

if shell=True then your cmd is a string (as your os command)
if shell=False then your cmd is a list

Note: shell=False dont work on your os environment variables
      
ex: cmd="ls -lrt" ==> shell=True
    cmd="ls -lrt".split()  or ['ls','-lrt']  ==> shell=False
    cmd="ls -lrt" ==> shell=True always on windows
```


### Check the return code output and error with a good command (ls -lrT)
```py
#!/usr/bin/env python3
import subprocess
LS="ls -lrt"
sp=subprocess.Popen(LS,shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
rc=sp.wait()
out,err=sp.communicate()
print(f'The return code is: {rc}')
print(f'The error is: {err}')
print()
print(f'The output is: \n{out}')

# Output
[root@ip-172-31-91-83 ~]# ./a.py
The return code is: 0
The error is:
The output is:
total 26112
-rw-r--r--  1 root     root     26724009 Oct  5 15:41 Python-3.9.0.tgz
-rwxr-xr-x  1 root     root          339 Oct 31 03:59 python.sh
```


### Convert the output into list so that you can  grep and information that you want
```py
#!/bin/python3
import subprocess
LS="ls -lrt"
sp=subprocess.Popen(LS,shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
rc=sp.wait()
out,err=sp.communicate()
print(f'The return code is: {rc}')
print(f'The error is: {err.splitlines()}')
print(f'The output is: \n{out.splitlines()}')
print(f'The first index is: {out.splitlines()[0]}')
print(f'The last index is: {out.splitlines()[-1]}')

# Output
[root@ip-172-31-91-83 ~]# ./a.py
The return code is: 0
The error is: []
The output is:
['total 8', '-rwxr-xr-x 1 root root 339 Oct 31 03:59 python.sh', '-rwxr-xr-x 1 root root 417 Oct 31 06:09 a.py']
The first index is: total 8
The last index is: -rwxr-xr-x 1 root root 417 Oct 31 06:09 a.py
```


### Check the return code output and error with a wrong command (ls -lrT)
```py
#!/bin/python3
import subprocess
LS="ls -lrT"
sp=subprocess.Popen(LS,shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
rc=sp.wait()
out,err=sp.communicate()
print(f'The return code is: {rc}')
print(f'The error is: \n{err}')
print(f'The output is: \n{out}')

# Output
[root@ip-172-31-91-83 ~]# ./a.py
The return code is: 2
The error is:
ls: option requires an argument -- 'T'
Try 'ls --help' for more information.

The output is:
```

### Take a decision base on return code
```py
#!/bin/python3
import subprocess
GIT_VERSION="ls -lrT"
GIT_VERSION_SP=subprocess.Popen(GIT_VERSION,shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
RETURN_CODE=GIT_VERSION_SP.wait()
GIT_VERSION_OUTPUT,GIT_VERSION_ERROR=GIT_VERSION_SP.communicate()
if RETURN_CODE == 0:
    print("Good")
else:
    print("Bad")

# Output
Bad
```

### Use shell=False
```py
#!/bin/python3
import subprocess
LS="ls -lrT".split()
sp=subprocess.Popen(LS,shell=False,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
rc=sp.wait()
out,err=sp.communicate()
print(f'The return code is: {rc}')
print(f'The error is: \n{err}')
print(f'The output is: \n{out}')

# Output
[root@ip-172-31-91-83 ~]# ./a.py
The return code is: 2
The error is:
ls: option requires an argument -- 'T'
Try 'ls --help' for more information.

The output is:

```


### Using env variable (we must use shell=True)
```py
#!/bin/python3
import subprocess
HOME="echo $HOME"
sp=subprocess.Popen(HOME,shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
rc=sp.wait()
HOME_DIR,ERROR_HOME=sp.communicate()
print(f'The user home directory is: {HOME_DIR}')

# Output
The user home directory is: /root

#--------------------------------------------------------------------------------------

#!/bin/python3
import subprocess
HOME="echo $HOME"
PWD="echo $PWD"
SP_HOME=subprocess.Popen(HOME,shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
rc1=SP_HOME.wait()
HOME_DIR,ERROR_HOME=SP_HOME.communicate()

SP_PWD=subprocess.Popen(PWD,shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
rc2=SP_PWD.wait()
PWD_DIR,ERROR_PWD=SP_PWD.communicate()

print(f'The user home directory is: {HOME_DIR} \nThe use present working directory is: {PWD_DIR}')

# Output
The user home directory is: /root
The use present working directory is: /root
```


### How to print the bash version on AWS EC2?
```py
import subprocess
BASH_VERSION="bash --version".split()
BASH_VERSION_SP=subprocess.Popen(BASH_VERSION,shell=False,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
BASH_VERSION_RC=BASH_VERSION_SP.wait()
BASH_VERSION_OUTPUT,BASH_VERSION_ERROR=BASH_VERSION_SP.communicate()
# print(BASH_VERSION_OUTPUT)
# print(BASH_VERSION_OUTPUT.splitlines())
# print(BASH_VERSION_OUTPUT.splitlines()[0])
# print(BASH_VERSION_OUTPUT.splitlines()[0].split())
# print(BASH_VERSION_OUTPUT.splitlines()[0].split()[3])
# print(BASH_VERSION_OUTPUT.splitlines()[0].split()[3].split())
# print(BASH_VERSION_OUTPUT.splitlines()[0].split()[3].split('('))
# print(BASH_VERSION_OUTPUT.splitlines()[0].split()[3].split('.'))
print(BASH_VERSION_OUTPUT.splitlines()[0].split()[3].split('(')[0])

#--------------------------------------------------------------------------------------

#!/bin/python3
import subprocess
BASH_VERSION="bash --version".split()
BASH_VERSION_SP=subprocess.Popen(BASH_VERSION,shell=False,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
BASH_VERSION_RC=BASH_VERSION_SP.wait()
BASH_VERSION_OUTPUT,BASH_VERSION_ERROR=BASH_VERSION_SP.communicate()
print(BASH_VERSION_OUTPUT.splitlines()[0].split()[3].split('(')[0])
RESULT=BASH_VERSION_OUTPUT.splitlines()[0].split()[3].split('(')[0]
print(f'The Bash version is: {RESULT}')

#--------------------------------------------------------------------------------------

#!/bin/python
import subprocess
BASH_VERSION="bash --version".split()
BASH_VERSION_SP=subprocess.Popen(BASH_VERSION,shell=False,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
BASH_VERSION_RC=BASH_VERSION_SP.wait()
BASH_VERSION_OUTPUT,BASH_VERSION_ERROR=BASH_VERSION_SP.communicate()

a='GNU bash, version 4.2.46(2)-release (x86_64-koji-linux-gnu)'
b=(a.split())
print(b)
print(b[3])
print(b[3][0:5])
kERNEL_VERSION=a.split()[3][0:5]
print(f'The kernel version is: {kERNEL_VERSION}')

if BASH_VERSION_ERROR==0:
   #print(BASH_VERSION_OUTPUT.splitlines()) ===> This split lines into list
   for each_line in BASH_VERSION_OUTPUT.splitlines():
      if "version" in each_line  and "release" in each_line:
          print(BASH_VERSION_OUTPUT.split()[3].split('(')[0])
          # 'GNU bash, version 4.2.46(2)-release (x86_64-koji-linux-gnu)'
          # print(BASH_VERSION_OUTPUT.split()[3].split('(')[0])        
else:
   print("Command was failed and error is: ",BASH_VERSION_ERROR)

#--------------------------------------------------------------------------------------

#!/bin/python3
import subprocess
BASH_VERSION="bash --version".split()
BASH_VERSION_SP=subprocess.Popen(BASH_VERSION,shell=False,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
BASH_VERSION_RC=BASH_VERSION_SP.wait()
BASH_VERSION_OUTPUT,BASH_VERSION_ERROR=BASH_VERSION_SP.communicate()

if BASH_VERSION_RC==0:
   for each_line in BASH_VERSION_OUTPUT.splitlines():
       if "version" in each_line  and "release" in each_line:
           #print(each_line.split()[3].split('(')[0])
           RESULT=each_line.split()[3].split('(')[0]
           print(f'The Bash version is: {RESULT}')             
else:
     print(f"Command was failed and error is: \n{BASH_VERSION_ERROR}")
   
#-------------------------------------------------------------------------------------

import subprocess
cmd=["bash","--version"]
sp=subprocess.Popen(cmd,shell=False,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
rc=sp.wait()
o,e=sp.communicate()

if rc==0:
   for each_line in o.splitlines():
      if "version" in each_line  and "release" in each_line:
         print(each_line.split()[3].split('(')[0])
else:
   print("Command was failed and error is: ",e)

```


### Check  git version and take decision
```py
#!/bin/python
import subprocess
GIT_VERSION="git --version"
sp=subprocess.Popen(GIT_VERSION,shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
rc=sp.wait()
out,err=sp.communicate()
# print(out)
# print(out.splitlines()) # This is use to split multiple lines into list
# print(out.split()) # This is use to split one line into list
# print(out.split()[-1])
# print(out.split()[-1].split('.'))
# print(out.split()[-1].split('.')[0])
RESULT=out.split()[-1].split('.')[0]

if int(RESULT) > 3:
    print("GIT verssion check passed")
else:
    print("GIT verssion check failed")
```


### Check kernel version and make decision
```py
#!/bin/python
import subprocess
KERNEL_VERSION="uname -r |cut -d. -f1"
sp=subprocess.Popen(KERNEL_VERSION,shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
rc=sp.wait()
out,err=sp.communicate()
print(out)
print(err)
print(rc)
if out > 3:
    print("Kernel verssion check passed")
else:
    print("Kernel verssion check failed")

#--------------------------------------------------------------------------------------

#!/bin/python
import subprocess
KERNEL_VERSION="uname -a".split()
KERNEL_VERSION_SP=subprocess.Popen(KERNEL_VERSION,shell=False,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
KERNEL_VERSION_RC=KERNEL_VERSION_SP.wait()
KERNEL_VERSION_OUTPUT,KERNEL_VERSION_ERROR=KERNEL_VERSION_SP.communicate()

# print(KERNEL_VERSION_OUTPUT.split())
# print(KERNEL_VERSION_OUTPUT.split()[2])
# print(KERNEL_VERSION_OUTPUT.split()[2].split("-"))
# print(KERNEL_VERSION_OUTPUT.split()[2].split("-")[0])
# print(KERNEL_VERSION_OUTPUT.split()[2].split("-")[0].split(".")[0])
RESULT=KERNEL_VERSION_OUTPUT.split()[2].split("-")[0].split(".")[0]

if int(RESULT) > 3:
    print("Kernel verssion check passed")
else:
    print("Kernel verssion check failed")
```


### Example
```py
import subprocess
#!/bin/python3
cmd="java -version"
sp=subprocess.Popen(cmd,shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
rc=sp.wait()
o,e=sp.communicate()
if rc==0:
    if bool(o)==True:
        print(o)
    #print(bool(o),bool(e))
    '''
    if bool(o)==False and bool(e)==True:
        print(e.splitlines()[0].split()[2].strip("\""))
    '''
    if bool(o)==False:
        if bool(e)==True:
            print(e.splitlines()[0].split()[2].strip("\""))
else:
    print(e)
```
#--------------------------------------------------------------------------------------

```py
#!/bin/python3
import subprocess
BASH_VERSION="bash --version".split()
BASH_VERSION_SP=subprocess.Popen(BASH_VERSION,shell=False,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
BASH_VERSION_RC=BASH_VERSION_SP.wait()
BASH_VERSION_OUTPUT,BASH_VERSION_ERROR=BASH_VERSION_SP.communicate()

if BASH_VERSION_RC==0 and bool(BASH_VERSION_OUTPUT)==True:
    print(BASH_VERSION_RC)
    print(BASH_VERSION_OUTPUT.splitlines()[0].split()[3].split('(')[0])
    RESULT=BASH_VERSION_OUTPUT.splitlines()[0].split()[3].split('(')[0]
    print(f'The Bash version is: {RESULT}')
else:
    print(BASH_VERSION_ERROR)
 
```

```py
#!/usr/local/bin/python3
import getpass, os, subprocess, sys, crypt

def add_user():

    DB_USER=input('Enter the DB username: ')
    DB_PASS=getpass.getpass(prompt='Enter the user DB password: ')
    encPass = crypt.crypt(DB_PASS)
    
    subprocess.run(['useradd', '-p', encPass, DB_USER ])
   
add_user()
```


### Example
```py
#!/bin/python
#!/usr/local/bin/python3
import subprocess
import os
SELINUX="cat /etc/sysconfig/selinux |grep ^SELINUX |head -1 |awk -F= '{print$2}'"
sp=subprocess.Popen(SELINUX,shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
rc=sp.wait()
out,err=sp.communicate()
b="enforcing"

print(type(out) is type(b))
print(b,type(b))
print(out,type(out))

if out == b:
    print("SELINUX CHECK PASSED")
else:
    os.system("sed -i '/^SELINUX/d' /etc/sysconfig/selinux")
    os.system("sed -i '/#     disabled - No SELinux policy is loaded./aSELINUX=enforcing' /etc/sysconfig/selinux")
    print("SELINUX CHECK FAILED. Selinux was set to ENFORCING mode")
    print(out)
    print(rc)



#!/usr/local/bin/python3
import subprocess
import os

sp=subprocess.Popen("cat /etc/sysconfig/selinux",shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
rc=sp.wait()
out,err=sp.communicate()

print(type(out) is type(b))
print(b,type(b))
print(out,type(out))

try:
    for  each_line in out.splitlines():
        if "SELINUX" in each_line and "enforcing" in each_line:
            SELINUX =  each_line.split("=")[0]
            if SELINUX == "enforcing"
                print("SELINUX CHECK PASSED")
except:
    print(e)
else:
    os.system("sed -i '/^SELINUX/d' /etc/sysconfig/selinux")
    os.system("sed -i '/#     disabled - No SELinux policy is loadeaSELINUX=enforcing' /etc/sysconfig/selinux")
    print("SELINUX CHECK FAILED. Selinux was set to ENFORCING mode")
```





