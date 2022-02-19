## OS module (Operating system module)
It is used to work/interact with the system to automate many task like create dir, files, identify file and dir and so on.


## Help on OS module 
```py
import os
dir(os)
help(os)
```

- `os.makedirs()` -->> To create dir  with path
- `os.mkdir()`    -->> To create a directory
- `os.getcwd()`   -->> To print the current working directory
- `os.chdir()`    -->> To change the current working directory
- `os.listdir()`  -->> To list directory
- `os.removedirs` -->> To remove dir recursively
- `os.rmdir`      -->> To remove dir
- `os.rename(scr, dst)` -->> To rename a dir
- `os.environ()`  -->> T print the env (system variable)

```py
print(os.getcwd()) # print curent working dir
print(os.cpu_count()) #get the number of cpu
print(os.sep) #to get the seperator (/)
os.chdir("/tmp") # change dir
os.removedirs("/tmp/hr/manager/engineering") #remove dir recursively and path
os.rmdir("tia") #remove dir in the curent dir
os.rename("/tmp/hr", "/tmp/manager") #==> os.rename(scr, dst) rename a dir
os.mkdir("tia2") #create a dir
os.makedirs("/tmp/hr/manager/engineering") #create dir with path and parent dir
print(os.listdir()) #list dir and files in the curent dir
print(os.listdir("/tmp")) 
os.environ['API_PASSWORD'] = 'secret' #set env
print(os.environ.get('API_PASSWORD')) #print env
os.system("env") #print all env
print(os.environ['HOME']) #print existing env
print(os.getgid()) #print the group id
```

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

## OS.path from os module 
- `os.path.basename()`   -->> To print the last element in your path
- `os.path.dirname()`    -->> To print the last element in your path
- `os.path.split()`      -->> To split a path and it base name and directory output
- `os.path.getsize()`    -->> To check the path size in bite
- `os.path.exists()`     -->> To check if the path exists
- `os.path.isfile()`     -->> To check if the path is a file
- `os.path.isdir()`      -->> To check if the path is a directory
- `os.path.islink()`      -->> To check if the path is a link


## OS.system from os module 
It is the execute the shell command or your os shell command. it will print the output of your command by default and if you set it as a variable, it will print the exit code or return code.
```py
import os
KERNEL_VERSION=os.system("uname -r |cut -d. -f1")
print(f"KERNEL CHECK FAILED. The kernel version on the server is {KERNEL_VERSION}")

#Output
3
KERNEL CHECK FAILED. The kernel version on the server is 0 # 0 is the exit code
```

### Run multiple command
```py
import os
a = os.system('ls -l && uptime && cal && cat /etc/passwd |grep root && cat /etc/*release')
print(a)
```

### Clear the terminal on windows or Linux
```py
import os
import platform
if platform.system()=="Windows":
    os.system("cls")
else:
    os.system("clear")
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

### os.path.basename and os.path.dirname
```py
#!/usr/local/bin/python3
import os
path="/home/tia/Downloads/code.py"
print(os.path.basename(path))
print(os.path.dirname(path))

# Output
[root@localhost Downloads]# ./code.py 
code.py
/home/tia/Downloads
```

### os.path.split()
```py
#!/usr/local/bin/python3
import os
path="/home/tia/Downloads/code.py"
print(os.path.split(path))

# Output
[root@localhost Downloads]# ./code.py 
('/home/tia/Downloads', 'code.py')
```

### To check the path size in bite
```py
#!/usr/local/bin/python3
import os
path="/home/tia/Downloads/code.py"
print(os.path.getsize(path))
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

### To check all OS operation in python shell
```py
import os
 print(os.sep)
```

### To print the seperator (/ in linux and \ in windows)
```py
import os
print(os.sep)

# Output
$ python hello.py
\
```

### This will give and error because of \Users. It is a special character
```py
path_1="C:\Users\Owner\Dropbox\AWS-EKS\TIA-NOTES\PYTHON-SCRIPTING"
print(path_1)

# Output
File "C:\Users\Owner\Dropbox\AWS-EKS\TIA-NOTES\PYTHON-SCRIPTING\hello.py", line 39
    path_1="C:\Users\Owner\Dropbox\AWS-EKS\TIA-NOTES\PYTHON-SCRIPTING"
```

### This will not give any error 
```py
path_1="C:\\Users\Owner\Dropbox\AWS-EKS\TIA-NOTES\PYTHON-SCRIPTING"
OR
path_1="C:\\Users\\Owner\\Dropbox\\AWS-EKS\\TIA-NOTES\\PYTHON-SCRIPTING"
print(path_1)

# Output
$ python hello.py
C:\Users\Owner\Dropbox\AWS-EKS\TIA-NOTES\PYTHON-SCRIPTING
```

### To print the current working directory
```py
import os
os.getcwd()
print(os.getcwd())

# Output
$ python hello.py
C:\Users\Owner\Dropbox\AWS-EKS\TIA-NOTES\PYTHON-SCRIPTING
```

### To change the current working directory
```py
import os
os.chdir("C:\\Users\\Owner\\Downloads\\New folder")
os.chdir("/home/user/Download")
print(os.getcwd())

# Output
$ python hello.py
C:\Users\Owner\Downloads\New folder
```

### To list directory
```py
import os
print(os.listdir())
print(os.listdir("C:\\Users\Owner\Dropbox\AWS-EKS\TIA-NOTES\PYTHON-SCRIPTING"))
print(os.listdir("/home/user/Download"))
```

### To create a directory
```py
import os
os.chdir("C:\\Users\Owner\Dropbox\AWS-EKS\TIA-NOTES\PYTHON-SCRIPTING")
os.chdir("/")
os.mkdir("Loops")
print(os.listdir())

#!/usr/local/bin/python3
import os
os.chdir("/")
os.mkdir("Loops")
print(os.listdir())
```

### To create dir with path
```py
#!/usr/local/bin/python3
import os
os.makedirs("/tmp/HR")
print(os.listdir("/tmp"))
```

### To rename a dir
```py
#!/usr/local/bin/python3
import os
os.rename("/HR", "/Finance")
print(os.listdir("/"))
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

# os.walk (it the same as find in Linux)
- r = root file system
- d = directoriers
- f = files


### Search all file from /home
```py
import os

req_file = input("Enter the file name that you want to search: ")

for r, d, f in os.walk("/home/tia"): #search all file starting from /home
    for each_file in f:
        print(os.path.join(r, each_file))
```

### Search all file from /home and print just all maches
```PY
import os
req_file = input("Enter the file name that you want to search: ")

for r, d, f in os.walk("/home/tia"): #search all file starting from /home
    for each_file in f:
        if each_file == req_file:
            print(os.path.join(r, each_file))

#OUTPUT
Enter the files name that you want to search: python.py
/home/tia/python.py
```

### Search all dir from /home and print just all maches
```py
import os

req_file = input("Enter the directory name that you want to search: ")

for r, d, f in os.walk("/home/tia"): #search all dir starting from /home
    for each_dir in d:
        if each_dir == req_file:
            print(os.path.join(r, each_dir))

#OUTPUT
Enter the directory name that you want to search: Downloads
/home/tia/Downloads
```

### Search all file from / filesystem
```py
import os
req_file = input("Enter the file name that you want to search: ")

for r, d, f in os.walk("/"): #search all file starting from /
    for each_file in f:
        if each_file == req_file:
            print(os.path.join(r, each_file))

#OUTPUT
Enter the file name that you want to search: python.py
/home/tia/python.py
/root/python.py
/root/python-scripting/python.py
```

### Search all file from /etc filesystem
```py
import os
req_file = input("Enter the file name that you want to search: ")

for r, d, f in os.walk("/etc"): #search all file starting from /etc
    for each_file in f:
        if each_file == req_file:
            print(os.path.join(r, each_file))

#OUTPUT
root@ubuntu:~/python-scripting# p
Enter the file name that you want to search: shadow
/etc/shadow
root@ubuntu:~/python-scripting# p
Enter the file name that you want to search: passwd
/etc/passwd
/etc/pam.d/passwd
```