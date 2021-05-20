# Linux Basic Commands

### Enable ssh on Centos 6
```
service sshd status
service sshd start
chkconfig sshd on
```
### Check the server IP address
```
ifconfig
ip a
```

### Connect into a server using ssh
```
ssh [username]@[server IP]
ssh -p 22 [username]@[server IP]
ssh tia@10.0.0.8
ssh root@192.168.1.98
```

### Get help
```
man
man [command]
info [command]
```

### Check the OS distribution
```
cat /etc/os-release
OR 
cat /etc/*release
```

### List Directory
```
ls
ll
ls -la
ls -l
ls -a
ll -la -lh
ls ~ or ll ~
```

### Calendar
```
cal
cal + the year 
cal 2019
cal + month + year 
cal 12 2017
```
### Tab tab function
* This the look for a particular command if you know how the command bigins and you do not know the end
```
ca tab tab
```

### Check the date
```
date
```
### Check how long the server has been up
```
uptime
```

### Check all previous commands 
```
history
```

### Claer the screen
```
clear
ctrl + l
```

### Print Working Directory
```
pwd
```

### Change Working Directory
```
cd
cd ..
cd ../..
cd ../../..
cd -
cd ~ or cd
```

```
d = directory 
- = regular file such as photos and documents
l = symbolic link
c = character device file
b  = block devices such as HHD and USB
s = socket file. it facilitate communication between applications
p = name pipe file
```

### Make directory 
```
mkdir [path][directory name]
mkdir [directory name]
mkdir /home/tia/Download/devops
mkdir ~/Download/devops
```
### Create a file 
```
touch [file name]
vim [file name]

touch [path][file name]
vim [path][file name]

touch /home/tia/Download/output.txt
touch ~/Download/output.txt
ls ~
```
### Copy files
cp [path][file name] [destination path][file name]
cp /home/tia/Download/output.txt /home/tia/Desktop/output.tx

### Copy Directories
```
cp -R [path][directory name] [destination path][directory name]
cp -R /home/tia/Download/devops /home/tia/Desktop/devops
``` 

### Move Directories and files
```
mv [path][directory name] [destination path][directory name]
mv [path][file name] [destination path][file name]

mv /home/tia/Download/output.txt /home/tia/Desktop/test.tx
cp -R /home/tia/Download/devops /home/tia/Desktop/devops-course
```

### Rename files and directories
```
mv [directory name] [new directory name]
mv [file name] [new file name]

mv devops devops-course
mv output.txt test.tx
```

### Sync command
**-a** : Preserve the specified attributes such as directory and file mode, ownership, timestamps, if possible additional attributes: context, links, xattr, all.
**-v**: Verbose output.
**-r**: Copy directories recursively.

```
rsync -av /var/lib/jenkins /jenkinshome/
```

### basic vim command
```
i or o # insertion mode
:wq    # write and quit
:q!    # quit without save
```

### Line and words count
```
wc -l file.txt
wc -c
wc -w
cat file.txt |wc -l
wc -lwc output.txt
```

### Seach string in a file
```
grep [string] [file name]
grep error error.txt
```

### Check who is login on a server
```
who
who | grep janet 
w | grep janet
```

### empty a file
```
> [file name]
output.txt
```

### Apend and redirect
```
ls -la -lh > output.txt (redirect)
ls -la -lh >> output.txt (append)
```

### Delete a file
```
rm -f
rm -rf
```

### Delete a directory
```
rm -rf 
```

### delete all files and directories
* NB: You most move into the directory where you want to delete all first
```
rm -rf *
```

### switch user
```
su
su - root
su - tia
```

### Open file
```
less
more
cat
head
head -n15 or head -15
tail
nl
```

### List the content of the home directory
```
ll ~ or ls ~
```

### Cancel 
```
ctrl + c
```

### Reboot the system
```
reboot
init 6
telinit 6
```

### Shutdown the server
```
init 0
halt
poweroff
```

### Reboot and shutdown with option
```
shutdown [OPTION] [TIME] [MESSAGE]

shutdown -h +5 "Server is going down for upgrade. Please save your work."
shutdown -h + number of minute + [message]
shutdown -h +10 "Server is going down for upgrade. Please save your work."
shutdown -r +5 "Server will restart in 5 minutes. Please save your work."
shutdown -c
```

# wall command
``` 
wall <<<"Hello everyone"
```
```
Hello everyone.
I hope everything is okay.
See you all tomorrow.

good night!

ctrl + d to send
```

### Add a user
```
useradd [username]
useradd tom
```

### Delete a user
```
userdel -r [username]
userdel -r [username]
userdel -r tom
```

### Assign a password to a user
```
passwd [username]
passwd tom
```

### Check all users on a server
```
cat /etc/passwd
```
### Password file
```
/etc/shadow
```

### Find files and directory path in root file system
```
find / -name [file name]
find / -name [directory name]

find / -type f -name [file name]
find / -type d -name [directory name]
```

### Find Files Using Name in Current Directory
find . -name tecmint.txt


### Find Files Under Home Directory
```
find /home -name tecmint.txt
```

### Find Files Using Name and Ignoring Case
* Find all the files whose name is tecmint.txt and contains both capital and small letters in /home directory.
```
find /home -iname tecmint.txt

./tecmint.txt
./Tecmint.txt
```

### Find all PHP Files in a Directory
```
find . -type f -name "*.php"

./tecmint.php
./login.php
./index.php
```

### ssh config file
```
find / -name sshd_config
/etc/ssh/sshd_config
service sshd restart
systemctl restart sshd.service
```

### Copy a file from a remote server
```
scp [username]@[server IP address]:[romte path] [destination path]
scp tia@52.91.239.56:/tmp/script.txt /home/tia/Download/script.txt
scp tia@52.91.239.56:/tmp/script.txt .
```

### Copy a directory from a remote server
```
scp [username]@[server IP address]:[romte path] [destination path]
scp -r tia@52.91.239.56:/tmp/devops /home/tia/Download/devops-course
scp -r tia@52.91.239.56:/tmp/devops .
```
### Copy all directories and files from a remote server
```
scp [username]@[server IP address]:[romte path] [destination path]
scp -r tia@52.91.239.56:/tmp/* /home/tia/Download/devops-course
scp -r tia@52.91.239.56:/tmp/* .
```

### Copy a file from local to remote server
```
scp [file name] [username]@[server IP address]:[destination path][file name]
scp ~/Download/test.txt tia@52.91.239.56:/tmp/test.txt
scp test.txt tia@52.91.239.56:/tmp/test.txt
```

### Copy a directory from local to remote server
```
scp -r [directory name] [username]@[server IP address]:[destination path][directory name]
scp -r ~/Download/devops-course tia@52.91.239.56:/tmp/devops
scp -r devops-course tia@52.91.239.56:/tmp/devops
```

### Install and update software with a package manager
**Debian** and distros like **Ubuntu** use the **APT** package manager. APT stands for Advanced Package Tool. Red Hat and CentOS use the YUM package manager.

**Fedora** uses **DNF**. **SUSE** uses **YaST**, and Arch uses **Pacman**. Generally speaking the tools all work in a similar way. 

![](/images/package.JPG)

### Update linux system
```
yum update -y
``` 

### Install package
```
yum -y install [package name]
yum -y install tree
yum -y install git
yum -y install curl
yum -y install wget
```

### Google Installation
```
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
yum install ./google-chrome-stable_current_*.rpm
```
### check if a package is install
```
which [package name]
which git
```

### Install httpd
```
yum install httpd
systemctl start httpd
systemctl enable httpd
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --reload
```
```
vim /var/www/html/index.html
```
```html
<html>
  <head>
    <title>Welcome to devopseasylearning.com</title>
  </head>
  <body>
    <h1>Success! The devopseasylearning.com virtual host is working!</h1>
  </body>
</html>
```

### Download from the internet using wget
* [Installing or updating Zoom on Linux](https://support.zoom.us/hc/en-us/articles/204206269-Installing-or-updating-Zoom-on-Linux#h_825b50ac-ad15-44a8-9959-28c97e4803ef)
```
wget [url]
wget https://zoom.us/download?os=linux
```

### Use RPM in Linux to install software
```
wget https://zoom.us/download?os=linux
rpm -i zoom_x86_64.rpm
```

### If you are upgrading from an earlier version of the software package, run RPM in upgrade mode, as in the following example:
```
rpm -U zoom_x86_64.rpm
```

### kernel version
```
uname -r
uname -a
```

### Delete the history
```
history -c
```

### RAM information
```
free -h
```

### Disk usage
```
du -h
```

### List all running process
```
top
```

### CPU informaton
```
cat /proc/cpuinfo
nproc
lscpu
```

### List all the hardwares of the system
```
lshw
```

### check if the system in 64 or 32 bit system 
```
getconf LONG_BIT
```

### To kill a proccess
```
kill -9 [PID number]
kill -15 [PID number]

kill + PID number
killall + name
```




