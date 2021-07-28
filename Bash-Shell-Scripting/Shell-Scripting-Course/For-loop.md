# For loop In Shell Scripting
A ‘for loop’ is a bash programming language statement which allows code to be repeatedly executed. A for loop is classified as an iteration statement. it is the repetition of a process within a bash script. 

**For loop syntax:**
```sh
for VARIABLE in 1 2 3 4 5 .. N
do
    command1
    command2
    commandN
done
```
OR
```sh
for VARIABLE in file1 file2 file3
do
    command1 on $VARIABLE
    command2
    commandN
done
```
OR
```sh
for OUTPUT in $(Linux-Or-Unix-Command-Here)
do
    command1 on $OUTPUT
    command2 on $OUTPUT
    commandN
done
```

**Example 1:**
```sh
#!/bin/bash
for i in 1 2 3 4 5
do
   echo "Welcome $i times"
done
```
**Output:**
```
Welcome 1 times
Welcome 2 times
Welcome 3 times
Welcome 4 times
Welcome 5 times
```


**Example 2:**
```sh
for items in $(sed -n '/tcpdump/, /print still the end/p' /etc/passwd | awk -F":" '{print$1}' | sed '/tcpdump/d'| sort -u);
do
echo "The username is $items"
sleep 3
done
```

**Example 3:**
```sh
#!/bin/bash
for i in {1..5}
do
   echo "Welcome $i times"
done
```

**Output:**
```
Welcome 1 times
Welcome 2 times
Welcome 3 times
Welcome 4 times
Welcome 5 times
```

**Example 4:**
```
Create User Accounts:	
Create the users, group and group membership:
Create the sysmgrs group
A user natasha, using sysmgrs as a sub group
A user harry, also using sysmgrs as a sub group
A user sarah cannot access the SHELL which is interactive in the system
Password for harry, sarah and natasha is redhat
```

```sh
touch /tmp/userlist.txt
echo "Natasha" >> /tmp/userlist.txt
echo "harry" >> /tmp/userlist.txt
echo "Sarah" >> /tmp/userlist.txt

userlist=/tmp/userlist.txt
username=$(cat /tmp/userlist.txt | tr 'A-Z' 'a-z')
password=$username@redhat

for user in $username
do
useradd $user
echo $password | passwd --stdin $user
done

groupadd sysmgrs
usermod -aG sysmgrs natasha
usermod -aG sysmgrs harry
usermod -s /sbin/nologin sarah
```

**Example 5:**
```
vim us_presidents.csv 
cat us_presidents.csv 
cat us_presidents.csv | cut -f2 
cat us_presidents.csv | cut -f2 |cut -d" " -f1 
cat us_presidents.csv | cut -f2 |cut -d" " -f1 |tr 'A-Z' 'a-z' 
cat us_presidents.csv | cut -f2 |cut -d" " -f1 |tr 'A-Z' 'a-z' |sort 
cat us_presidents.csv | cut -f2 |cut -d" " -f1 |tr 'A-Z' 'a-z' |sort |sort -u 
cat us_presidents.csv | cut -f2 |cut -d" " -f1 |tr 'A-Z' 'a-z' |sort |sort -u |wc -l 
cat us_presidents.csv | cut -f2 |cut -d" " -f1 |tr 'A-Z' 'a-z' |sort |sort -u > users.txt
```

**To list all the users**
```
cat users.txt
```
```
abraham
andrew
barack
benjamin
bill
calvin
chester
dwight
franklin
george
gerald
grover
harry
herbert
james
jimmy
john
lyndon
martin
millard
name
richard
ronald
rutherford
theodore
thomas
ulysses
warren
william
woodrow
zachary
```

**To add all the users and expired their account**
```
vim useradd.sh 
```
```sh
#!/bin/bash
userlist=/tmp/users.txt
username=$(cat /tmp/users.txt | tr 'A-Z' 'a-z')
password=$username@redhat
 
for user in $username
do
useradd $user
echo $password | passwd --stdin $user
passwd --expire $user
done
```

**To delete all the users using the for loop**
```
vim userdel.sh
```
```sh
#!/bin/bash
userlist=/tmp/users.txt
username=$(cat /tmp/users.txt)
 
for user in $username
do
userdel -r $user
done
```

**Example 5:**

**List of server that we want to create users on using for loop**
```
vim list_of_server.txt
```
```
10.0.0.36
10.0.0.31
3.85.142.148
18.206.125.130
```

**Create all the users to be copy over**
```
vim users.txt
```
```
abraham
andrew
barack
benjamin
bill
calvin
chester
dwight
franklin
george
gerald
grover
harry
herbert
james
jimmy
john
lyndon
martin
millard
name
richard
ronald
rutherford
theodore
thomas
ulysses
warren
william
woodrow
zachary
```

**Uesr add script to be copy over**
```
vim useradd.sh 
```
```sh
#!/bin/bash
userlist=/tmp/users.txt
username=$(cat /tmp/users.txt | tr 'A-Z' 'a-z')
password=$username@redhat
 
for user in $username
do
useradd $user
echo $password | passwd --stdin $user
passwd --expire $user
done
```

**To delete all the users using the for loop**
```
vim userdel.sh
```
```sh
#!/bin/bash
userlist=/tmp/users.txt
username=$(cat /tmp/users.txt)
 
for user in $username
do
userdel -r $user
done
```

**Loop script to copy file over and create users**
```
vim useradd-loop.sh
```

```sh
#!/bin/bash
count=1
for each_server in $(cat list_of_server.txt)
do
  echo "$count. working on ${each_server}"
  ssh root@${each_server} "cd /tmp && rm -rf *"
  scp users.txt root@${each_server}:/tmp
  scp useradd.sh root@${each_server}:/tmp
  ssh root@${each_server} "chmod +x /tmp/useradd.sh && sh /tmp/useradd.sh"
done
# $count. = 1. Or start with 1. working on <IP>
# 1. working on 3.231.129.201 
```

```
vim userdel-loop.sh
```
```sh
#!/bin/bash
count=1
for each_server in $(cat list_of_server.txt)
do
  echo "$count. working on ${each_server}"
  scp userdel.sh root@${each_server}:/tmp
  ssh root@${each_server} "chmod +x /tmp/userdel.sh && sh /tmp/userdel.sh"
done
```

![](/images/loop1.JPG)