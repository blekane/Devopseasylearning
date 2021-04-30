## OS module (Operating system module)
It is used to work/interact with the system to automate many task like create dir, files, identify file and dir and so on.
- `os.makedirs()` -->> To create dir  with path
- `os.mkdir()`    -->> To create a directory
- `os.getcwd()`   -->> To print the current working directory
- `os.chdir()`    -->> To change the current working directory
- `os.listdir()`  -->> To list directory
- `os.removedirs` -->> To remove dir recursively
- `os.rmdir`      -->> To remove dir
- `os.rename(scr, dst)` -->> To rename a dir
- `os.environ()`  -->> T print the env (system variable)


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

### To create dir  with path
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

os.walk