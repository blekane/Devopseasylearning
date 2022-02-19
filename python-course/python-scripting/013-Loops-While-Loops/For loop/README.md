## Python Scripting 

### What is a module ?
A module is a file containing Python definitions and statements. That means, module containing python functions, classes and variables.

### What is the use of module ?
Reusability. Note: If script name is mymodule.py then module name is mymodule

### Types of Python Modules:
- Default Modules
- Third Party Modules
Import either default or third party modules before using them.

### Why Loops:
All programming languages need a way to execute block of code many times, this is possible with loops.

**Python has two types of loops:**
- for loop
- while loop

### For loop:
The for loop in Python is used to iterate over a sequence (list, tuple, string) or other iterable objects.

### While loop:
while loop is used to execute a block of statements repeatedly until a given a condition is satisfied.


### Practice: Read a path and check if given path is a file or a directory
```py
#This is a platform independet script(you can run on any operating system)
import os
path=input("Enter your path: ")

if os.path.exists(path):
	print(f"Given path : {path}is a valid path")
	if os.path.isfile(path):
		print("and it is a file path")
	else:
		print("and it is a directory path")
else:
	print(f"Given path : {path} is not existing on this host")
```

### Introduction to loops with an example
```py
import os
import sys
path=input("Enter your directory path: ")
if os.path.exists(path):
	df_l=os.listdir(path)
else:
	print("please provide valid path")
	sys.exit()
```

### Loops | Working with for loop
```py
### we are repeating here
my_list=[3,4,5,'hello',7]
print(my_list[0])
print(my_list[1])
print(my_list[2])
print(my_list[3])
print(my_list[-1])

print('------------')
for e in my_list:
	print(e)

#OUTPUT
3
4
5
hello
7
------------
3
4
5
hello
7
```

```py
for each_char in "poython":
	print("--------")
print('')
for each_char in "poython":
	print("--------,", each_char)


--------
--------
--------
--------
--------
--------
--------

--------, p
--------, o
--------, y
--------, t
--------, h
--------, o
--------, n
```

```py
for each_char in [1,2,3,4,5]:
	print("--------")
print('')
for each_char in [1,2,3,4,5]:
	print("--------",each_char)
print('We are working with loop')

#OUTPUT
--------
--------
--------
--------
--------

-------- 1
-------- 2
-------- 3
-------- 4
-------- 5
We are working with loop
```

```py
my_list=[3,4,8,34,68,65,87,5,23,30]

for each in my_list:
	rem=each%2
	if rem==0:
		print(f"{each} is even")
	else:
		print(f"{each} is odd"

#OUTPUT
3 is odd
4 is even
8 is even
34 is even
68 is even
65 is odd
87 is odd
5 is odd
23 is odd
30 is even
```


### Simple practice with for loop
```py
usr_str=input("Enter your string: ")

index=0
for each_char in usr_str:
	print(f'{each_char} -->{index}')
	index=index+1

Input is: python
Output is:
p --> 0
y --> 1
t --> 2
h --> 3
o --> 4
n --> 5
```


#  Find all files in a directory with required extension .py/.sh/.log/.txt etc…

### Check if the path exist
```py
import os
req_path=input("Enter your directory path: ")
req_ex=input("Enter the required files extention .py/.sh/.log/.txt/.conf: ")

if os.path.exists(req_path):
  print('Impliment your logic')
else:
  print(f"The given path {req_path} do not exists")

#OUTPUT 1
Enter your directory path: /fr
Enter the required files extention .py/.sh/.log/.txt/.conf: .py
The given path /fr do not exists
```

### Check if the path is a file or a dir
```py
#!/usr/local/bin/python3
import os
req_path=input("Enter your directory path: ")
req_ex=input("Enter the required files extention .py/.sh/.log/.txt/.conf: ")

if os.path.isfile(req_path):
	print(f"The given path {req_path} is a file. Please pass only directory path")
else:
	print("Impliment your actual logic")

#OUTPUT 1
Enter your directory path: /home/tia/Downloads/code.py
Enter the required files extention .py/.sh/.log/.txt: .py
The given path /home/tia/Downloads/code.py is a file. Please pass only directory path

#OUTPUT 2
Enter your directory path: /etc
Enter the required files extention .py/.sh/.log/.txt: .py
Impliment your actual logic
```

### List all fill and dir as a list in the given path
```py
import os
req_path=input("Enter your directory path: ")
req_ex=input("Enter the required files extention .py/.sh/.log/.txt/.conf: ")

if os.path.isfile(req_path):
  print(f"The given path {req_path} is a file. Please pass only directory path")
else:
  all_f_ds=os.listdir(req_path)
  print(all_f_ds)
```

### check if the path is empty or not 
```py
#!/usr/local/bin/python3
import os
req_path=input("Enter your directory path: ")
req_ex=input("Enter the required files extention .py/.sh/.log/.txt/.conf: ")

if os.path.isfile(req_path):
  print(f"The given path {req_path} is a file. Please pass only directory path")
else:
  all_f_ds=os.listdir(req_path)
  print(all_f_ds)
  if len(all_f_ds)==0:
  	print(f"The given path is {req_path} an empty path")
  else:
  	print("Impliment your actual logic here")
```

### Check all operation with and operator
```py
#!/usr/local/bin/python3
import os
req_path=input("Enter your directory path: ")
req_ex=input("Enter the required files extention .py/.sh/.log/.txt/.conf: ")

if os.path.exists(req_path) and os.path.isdir(req_path) and len(os.listdir(req_path)) != 0:
	print("Impliment your actual logic here")
else:
	print(f"Invalid {req_path}")
```

```py
#!/usr/local/bin/python3
import os
req_path=input("Enter your directory path: ")

if os.path.exists(req_path) and os.path.isdir(req_path) and len(os.listdir(req_path)) != 0:
	req_ex=input("Enter the required files extention .py/.sh/.log/.txt: ")
else:
	print(f"Invalid {req_path}")
```

### print individual file
```py
#!/usr/local/bin/python3
import os
req_path=input("Enter your directory path: ")

if os.path.exists(req_path) and os.path.isdir(req_path) and len(os.listdir(req_path)) != 0:
	req_ex=input("Enter the required files extention .py/.sh/.log/.txt/.conf: ")
	all_f_ds=os.listdir(req_path)
	for each_f in all_f_ds:
		if each_f.endswith(req_ex):
			print(each_f)
else:
	print(f"Invalid Path: {req_path}")
```

### Print the result as a list
```py
#!/usr/local/bin/python3
import os
req_path=input("Enter your directory path: ")

if os.path.exists(req_path) and os.path.isdir(req_path) and len(os.listdir(req_path)) != 0:
	req_ex=input("Enter the required files extention .py/.sh/.log/.txt/.conf: ")
	all_f_ds=os.listdir(req_path)
	req_files=[]
	for each_f in all_f_ds:
		if each_f.endswith(req_ex):
			req_files.append(each_f)
	print(f'The required files are: {req_files}')
else:
	print(f"Invalid Path: {req_path}")

#OUTPUT 1
[root@localhost Downloads]# ./code.py 
Enter your directory path: /etc
Enter the required files extention .py/.sh/.log/.txt/.conf: .conf
The required files are: ['resolv.conf', 'mke2fs.conf', 'e2fsck.conf', 'sos.conf', 'idmapd.conf', 'libuser.conf', 'host.conf', 'logrotate.conf', 'mtools.conf', 'dracut.conf', 'ld.so.conf', 'nsswitch.conf', 'yum.conf', 'GeoIP.conf', 'request-key.conf', 'krb5.conf', 'libaudit.conf', 'asound.conf', 'fuse.conf', 'sestatus.conf', 'sudo-ldap.conf', 'sysctl.conf', 'sudo.conf', 'kdump.conf', 'pnm2ppa.conf', 'pbm2ppa.conf', 'numad.conf', 'rsyslog.conf', 'cgconfig.conf', 'man_db.conf', 'cgrules.conf', 'locale.conf', 'cgsnapshot_blacklist.conf', 'oddjobd.conf', 'vconsole.conf', 'autofs.conf', 'autofs_ldap_auth.conf', 'dnsmasq.conf', 'fprintd.conf', 'wvdial.conf', 'usb_modeswitch.conf', 'radvd.conf', 'rsyncd.conf', 'nfs.conf', 'nfsmount.conf', 'ipsec.conf', 'updatedb.conf', 'brltty.conf', 'chrony.conf', 'ksmtuned.conf', 'tcsd.conf', 'ntp.conf', 'dleyna-server-service.conf']

#OUTPUT 1
# This will give us an empty list because the file .sh do not exist
[root@localhost Downloads]# ./code.py 
Enter your directory path: /etc
Enter the required files extention .py/.sh/.log/.txt/.conf: .sh
The required files are: []
```

### Check if the len = 0 (this means the list is empty)
```py
#!/usr/local/bin/python3
import os
req_path=input("Enter your directory path: ")

if os.path.exists(req_path) and os.path.isdir(req_path) and len(os.listdir(req_path)) != 0:
	req_ex=input("Enter the required files extention .py/.sh/.log/.txt/.conf: ")
	all_f_ds=os.listdir(req_path)
	req_files=[]
	for each_f in all_f_ds:
		if each_f.endswith(req_ex):
			req_files.append(each_f)
	if len(req_files)==0:
		print(f"There are no {req_ex} files in the location of {req_path}")
	else:
		print(f"There are {len(req_files)} files with {req_ex}")

else:
	print(f"Invalid Path: {req_path}")

#OUTPUT 1
[root@localhost Downloads]# ./code.py 
Enter your directory path: /etc
Enter the required files extention .py/.sh/.log/.txt/.conf: .conf
There are 53 files with .conf

#OUTPUT 1
[root@localhost Downloads]# ./code.py 
Enter your directory path: /etc
Enter the required files extention .py/.sh/.log/.txt/.conf: .sh
There are no .sh files in the location of /etc
```

### End goal
```py
#!/usr/local/bin/python3
import os
req_path=input("Enter your directory path: ")

if os.path.exists(req_path) and os.path.isdir(req_path) and len(os.listdir(req_path)) != 0:
	req_ex=input("Enter the required files extention .py/.sh/.log/.txt/.conf: ")
	all_f_ds=os.listdir(req_path)
	req_files=[]
	for each_f in all_f_ds:
		if each_f.endswith(req_ex):
			req_files.append(each_f)
	if len(req_files)==0:
		print(f"There are no {req_ex} files in the location of {req_path}")
	else:
		print(f"There are {len(req_files)} files in the location of {req_path} with an extention of {req_ex}")
		print(f"So, the files are: \n{req_files}")

else:
	print(f"Invalid Path: {req_path}")

#OUTPUT 1
Enter your directory path: /etc
Enter the required files extention .py/.sh/.log/.txt/.conf: .conf 
There are 53 files in the location of /etc with an extention of .conf
So, the files are: 
['resolv.conf', 'mke2fs.conf', 'e2fsck.conf', 'sos.conf', 'idmapd.conf', 'libuser.conf', 'host.conf', 'logrotate.conf', 'mtools.conf', 'dracut.conf', 'ld.so.conf', 'nsswitch.conf', 'yum.conf', 'GeoIP.conf', 'request-key.conf', 'krb5.conf', 'libaudit.conf', 'asound.conf', 'fuse.conf', 'sestatus.conf', 'sudo-ldap.conf', 'sysctl.conf', 'sudo.conf', 'kdump.conf', 'pnm2ppa.conf', 'pbm2ppa.conf', 'numad.conf', 'rsyslog.conf', 'cgconfig.conf', 'man_db.conf', 'cgrules.conf', 'locale.conf', 'cgsnapshot_blacklist.conf', 'oddjobd.conf', 'vconsole.conf', 'autofs.conf', 'autofs_ldap_auth.conf', 'dnsmasq.conf', 'fprintd.conf', 'wvdial.conf', 'usb_modeswitch.conf', 'radvd.conf', 'rsyncd.conf', 'nfs.conf', 'nfsmount.conf', 'ipsec.conf', 'updatedb.conf', 'brltty.conf', 'chrony.conf', 'ksmtuned.conf', 'tcsd.conf', 'ntp.conf', 'dleyna-server-service.conf']

#OUTPUT 2
[root@localhost Downloads]# ./code.py 
Enter your directory path: /etc
Enter the required files extention .py/.sh/.log/.txt/.conf: .sh
There are no .sh files in the location of /etc

#OUTPUT 2
[root@localhost Downloads]# ./code.py 
Enter your directory path: /fsrf
Invalid Path: /fsrf
```

### Another End goal
```py
#!/usr/local/bin/python3
import os
req_path=input("Enter your directory path: ")
req_ex=input("Enter the required files extention .py/.sh/.log/.txt/.conf: ")

if os.path.isfile(req_path):
  print(f"The given path {req_path} is a file. Please pass only directory path")
else:
  all_f_ds=os.listdir(req_path)
  if len(all_f_ds)==0:
     print(f"The given path is {req_path} an empty path")
  else:
     req_ex=input("Enter the required files extention .py/.sh/.log/.txt: ")
     req_files=[]
     for each_f in all_f_ds:
        if each_f.endswith(req_ex):
           req_files.append(each_f)
     if len(req_files)==0:
        print(f"There are no {req_ex} files in the logcation of {req_path}")
     else:
        print(f"There are {len(req_files)} files in the location of {req_path} with an extention of {req_ex}")
        print(f"So, the files are: {req_files}")
```


### for loop to work with strings, list, tuple and dictionaries
```py
my_dir={'a':1,'b':'2','c':'3','d':'4'}
for e in my_dir:
	print(e)

print(' ')

for e in my_dir.values():
	print(e)

print(' ')

for e in my_dir.items():
	print(e)

print(' ')

for keys,values in my_dir.items():
	# print(keys)
	# print(values)
	print(keys, values)

#OUTPUT
a
b
c
d
 
1
2
3
4
 
('a', 1)
('b', '2')
('c', '3')
('d', '4')
 
a 1
b 2
c 3
d 4
```
