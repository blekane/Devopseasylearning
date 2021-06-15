# AWK, SED, CUT, TR, GREP, EGREP, SORT, AND PIPE COMMAND

## TR COMMAND
This command can be used to convert strings from uppercase to lowercase or from uppercase to lowercase.
```
cat > linux_distro
```
```
Ubuntu
Ubuntu
Linux Mint
elementary OS
Ubuntu Server
CentOS
CentOS
SUSE Linux Enterprise Server
Arch Linux
Slackware
Debian
```
```
Ctrl + d to save
```

**To replace all the uppercase with lowercase**
```
cat linux_distro |tr 'A-Z' 'a-z'
cat linux_distro |tr '[:upper:]' '[:lower:]'
```

**RESULT:**
```
ubuntu
ubuntu
linux mint
elementary os
ubuntu server
centos
centos
suse linux enterprise server
arch linux
slackware
debian
```

**To replace all the lowercase by uppercase**
```
cat linux_distro |tr 'a-z' 'A-Z'
OR 
cat linux_distro |tr '[:lower:]' '[:upper:]'
```
**RESULT:**
```
UBUNTU
UBUNTU
LINUX MINT
ELEMENTARY OS
UBUNTU SERVER
CENTOS
CENTOS
SUSE LINUX ENTERPRISE SERVER
ARCH LINUX
SLACKWARE
DEBIAN
```

## SORT COMMAND
**SORT** command is used to sort a file, arranging the records in a particular order.
```
cat > linux_distro
```
```
Ubuntu
Ubuntu
Linux Mint
elementary OS
Ubuntu Server
CentOS
CentOS
SUSE Linux Enterprise Server
Arch Linux
Slackware
Debian
```
```
Ctrl + d to save
```
**To sort in alphabetical order**
```
cat linux_distro |sort
```

**RESULT:**
```
Arch Linux
CentOS
CentOS
Debian
elementary OS
Linux Mint
Slackware
SUSE Linux Enterprise Server
Ubuntu
Ubuntu
Ubuntu Server
```
**To reverse sort**
```
cat linux_distro |sort -r
```

**RESULT:**
```
Ubuntu Server
Ubuntu
Ubuntu
SUSE Linux Enterprise Server
Slackware
Linux Mint
elementary OS
Debian
CentOS
CentOS
Arch Linux
```

**To sort and remove duplicates**
```
cat linux_distro |sort -u
```
**RESULT:**
```
Arch Linux
CentOS
Debian
elementary OS
Linux Mint
Slackware
SUSE Linux Enterprise Server
Ubuntu
Ubuntu Server
```

**To sort in alphabetical order and remove duplicates**
```
cat linux_distro |sort -u |sort
```
```
Arch Linux
CentOS
Debian
elementary OS
Linux Mint
Slackware
SUSE Linux Enterprise Server
Ubuntu
Ubuntu Server
```

## AWK AND CUT COMMAND
The CUT and AWK commands in UNIX are commands for cutting out the sections from each line of files and writing the result to standard output to a file. 

**Redirection**
```
head -n15 /var/log/messages > log_messages
```

**To print column 3**
```	
head -n10 /var/log/messages | awk '{print $3}'
head -n10 /var/log/messages | cut -d" " -f3
```

**To print column 2 and 3**
```
head -n10 /var/log/messages | awk '{print $2,$3}'
head -n10 /var/log/messages | cut -d" " -f2,3
```

**To print column 1 still 3**
```	
head -n10 /var/log/messages | awk '{ print $2,$2,$3}'
head -n10 /var/log/messages | cut -d" " -f1-3
```

**This will remove column 3 and redirect the output to file1.txt**
```
head -n10 /var/log/messages | awk '{$3=" "; print$0}' > file1.txt
```

**This will remove column 1, 2 & 3 and redirect the output to file2.txt**
```	
head -n10 /var/log/messages | awk '{$1=$2=$3=" "; print$0}' > file2.txt	
```

**To print columns with ":" as field separator**
```
head -n10 /var/log/messages |awk '{print$3}'
head -n10 /var/log/messages |awk '{print$3}' |awk -F":" '{print$1}'
head -n10 /var/log/messages |awk '{print$3}' |awk -F":" '{print$2}'
head -n10 /var/log/messages |awk '{print$3}' |awk -F":" '{print$3}'
```

**To print column 1, 2 and 3 with ":" as field separat**
```
head -n10 /etc/passwd | awk -F":" '{print$1,$3,$4}'
head -n10 /etc/passwd | cut -d: -f1-3
```

**To change the output delimiter from ":" to ",". 1-7 is because the password file have 7 columns**
```
head -n10 /etc/passwd | cut -d: -f1-7 --output-delimiter=", "
```

**To change the output delimiter from ":" to "space. 1-7 is because the password file have 7 columns"**
```
head -n10 /etc/passwd | cut -d: -f1-7 --output-delimiter=" "
```

**Redirection**
```
ls -l > temp.txt
```

**Print column 1 and 9 in all the lines that have root**
```	
awk '/root/ {print $1, $9}' temp.txt
```

**Print column 5 in all the lines that have tia**
```
ls -lh | awk '/tia/{print $5}'
```

**To print column 1 and use ":" as field separator**
```	
awk -F":" '{print$1}' /etc/passwd
cut -d: -f1 /etc/passwd
```

**To print column 1, 2 and 3 ":" as field separator**
```
awk -F":" '{print$1,$3,$4}' /etc/passwd
cut -d: -f1-3 /etc/passwd
```

## Example 
Use the AWK command to filter all unauthorized users that are trying to login into your server.

**Open the log file**
```
find / -name secure
```
**Monitor the log file in real time**
```
tail -f /var/log/secure
```
**Grep Failed**
```
cat /var/log/secure | grep "Failed"
```
**Print line 9 to get all unauthorize users**
```
cat /var/log/secure | grep "Failed"  | awk '{print $9}'
```
**Sort the result and remove duplicate**
```	
cat /var/log/secure | grep "Failed"  | awk '{print $9}' | sort -u
```
**Count how many people try to login and failed**
```	
cat /var/log/secure | grep "Failed"  | awk '{print $9}' | sort -u |wc -l
```
**Redirect the output into a file**
cat /var/log/secure | grep "Failed"  | awk '{print $9}' | sort -u |wc -l > users.txt	

```
find / -name secure
tail -f /var/log/secure
cat /var/log/secure | grep "Failed"
cat /var/log/secure | grep "Failed"  | awk '{print $9}'
cat /var/log/secure | grep "Failed"  | awk '{print $9}' | sort -u
cat /var/log/secure | grep "Failed"  | awk '{print $9}' | sort -u |wc -l
cat /var/log/secure | grep "Failed"  | awk '{print $9}' | sort -u |wc -l > users.txt
```

## SED COMMAND
The SED command in UNIX stands for stream editor and it can perform a lot of functions on files like, searching, find and replace, insertion or deletion. Though most common use of SED commands in UNIX is for a substitution or for find and replace. By using SED you can edit files even without opening them, which is a much quicker way to find and replace something in a file, than first opening that file in VI Editor and then changing it.

```
cat > geekfile.txt
```
unix is a great OS. Unix is open source. Unix is free os.
Learning unix operating systems is a good skill. 
Which one can you choose between unix and Windows?. I love unix
unix is easy to learn, unix is a multiuser os,please learn unix.
unix is a powerful OS and this is why companies use Unix


