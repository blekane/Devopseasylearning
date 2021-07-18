# Linux Basic Commands

### Check the server IP address
```
ifconfig
ip a
hostname -i 
hostname -I
ip addr show
```

### See system hostname 
```
hostname 
```

### List system reboot history
```
last reboot  
```

### Connect into a server using ssh
```
ssh [username]@[server IP]
ssh -p [port] [username]@[server IP]
ssh tia@10.0.0.8
ssh -p 22 root@192.168.1.98
ssh [username]@[ser IP] -i [key path]  # if connecting using and existing ssh key 
```

### See active (listening) ports 
```
netstat -pnltu 
netstat -pnltu |grep 22
```

### Get help
```
man
man [command]
info [command]
[command] --help
```

### Check the OS distribution
```
cat /etc/os-release
OR 
cat /etc/*release
cat /etc/*rel*/
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

### Clear the screen
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
mkdir /home/tia/Downloads/devops
mkdir ~/Downloads/devops
mkdir -p /home/tia/Downloads/devops/test/   #create directory test with parent directory devops at the same time 
```
### Create a file 
```
touch [file name]
vim [file name]

touch [path][file name]
vim [path][file name]

touch /home/tia/Downloadsoutput.txt
touch ~/Downloadsoutput.txt
ls ~
```
### Copy files
```
cp [path][file name] [destination path][file name]
cp /home/tia/Downloads/output.txt /home/tia/Desktop/output.tx
```

### Copy Directories recursively (R) ing copy the directory and all associated files.
```
cp -R [path][directory name] [destination path][directory name]
cp -R /home/tia/Downloads/devops /home/tia/Desktop/devops
``` 

### Move Directories and files
```
mv [path][directory name] [destination path][directory name]
mv [path][file name] [destination path][file name]

mv /home/tia/Download/output.txt /home/tia/Desktop/test.tx
cp -R /home/tia/Downloads/devops /home/tia/Desktop/devops
```

### Rename files and directories can aslo be used to move files or directory from one destination to another 
```
mv [directory name] [new directory name]
mv [file name] [new file name]

mv devops devops-course
mv output.txt test.tx
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

### Recursively search for a pattern in a directory
```
grep -r [pattern] [directory_name] 
```

### Check who is login on a server
```
who
who | grep janet 
w | grep janet
id
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
rmdir
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

### wall command
wall -- send a message to everybody's terminal.
``` 
wall <<<"Hello everyone"
OR
wall "The system will be restarted in 10 minutes."
```
```
wall

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
adduser    # to create a user with password, full name and other credentials at the same time.
useradd [username] -s /bin/bash   # create a user with bash environment 
useradd [username] -m -d /home/[username]    # create user with home directory
useradd [username] -m -d /home/[username]  -s /bin/bash   #create user with home directory and bash environment 
```

### Show information about a particular user
```
yum install finger
finger [username] 
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
ls /home     # check all user having a home directory 
```
### Password file
```
/etc/shadow
```
### environment variable
```
env                     # to check all environment variables 
export USER=devops      # this will add an environment varialble called USER with value devops in he virtual machine 
unset USER              # remove environment variable USER in the virtual machine 
```

### Find files and directory path in root file system
```
find / -name [file name]
find / -name [directory name]

find / -type f -name [file name]
find / -type d -name [directory name]
```

### Find Files Using Name in Current Directory
```
find . -name tecmint.txt
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

### List all installed packages with yum
```
yum list installed 
```

### Remove a package
```
yum remove [package_name] -y

yum list installed
yum list installed |grep tree
yum remove tree.x86_64 -y

yum list installed |grep httpd
yum remove httpd.x86_64 -y
yum remove httpd-tools.x86_64 -y
```

### Install an .rpm package from a local file
```
rpm -i [package_name.rpm] 
```

### Remove an .rpm package
``` 
rpm -e [package_name.rpm] 
```

### Upgrade .rpm package from a local file
```
rpm -U [package_name.rpm] 
```

### Google Installation
```
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm

yum install ./google-chrome-stable_current_*.rpm
OR
rpm -i google-chrome-stable_current_x86_64.rpm
```
```
rpm -U google-chrome-stable_current_x86_64.rpm
yum list installed |grep google
rpm -e google-chrome-stable.x86_64
yum remove google-chrome-stable.x86_64 -y
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

### How To Open A Port In CentOS / RHEL 7 through CLI?
```
sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
sudo firewall-cmd --reload
```

### How to stop, enable and restart the firewalld in CentOS / RHEL 7?
```
systemctl stop firewalld.service
systemctl status firewalld.service
systemctl enable firewalld.service
systemctl restart firewalld.service
```

### How To Open A Port In Ubuntu?
```
syntax:
ufw allow port-number/protocol
example:
$ sudo ufw allow 8080/tcp
$ sudo ufw allow 80/tcp
Ubuntu reload / restart iptables service command
$ sudo ufw reload
```


### Archive an existing file 
```
tar cf [compressed_file.tar] [file_name]
```

### Extract an archived file
```
tar xf [compressed_file.tar] 
```
### Create a gzip compressed tar file by running 
```
tar czf [compressed_file.tar.gz] [file_name]
```

### Unzip and zip
```
wget https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/static-website-example.zip
unzip static-website-example.zip
ls -ltrh
```
```
zip -r static-website-example.zip static-website-example
```
```
unzip static-website-example.zip
```
 
### Host a new webside
```
wget https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/static-website-example.zip 
unzip static-website-example.zip 
cp -R static-website-example/* . 
rm -rf static-website-example.zip 
rm -rf static-website-example
```

### Download and upload from remote server
```
scp -r tia@10.0.0.34:/home/tia/website/static-website-example.zip . 
scp -r static-website-example.zip tia@10.0.0.34:/home/tia/Downloads
```

### Download and upload from remote ec2
```
scp -i [myssh.pem] [local_file] [username]@[IP]:/home/ec2-user

scp -i Devops-easy-learning-Centos-key.pem static-website-example.zip ec2-user@ec2-3-132-195-227.us-east-2.compute.amazonaws.com:/home/ec2-user

scp -i Devops-easy-learning-Centos-key.pem ec2-user@ec2-3-132-195-227.us-east-2.compute.amazonaws.com:/home/ec2-user/static-website-example.zip .
```

### Download from the internet using wget
* [Installing or updating Zoom on Linux](https://support.zoom.us/hc/en-us/articles/204206269-Installing-or-updating-Zoom-on-Linux#h_825b50ac-ad15-44a8-9959-28c97e4803ef)
```
wget [url]
wget https://zoom.us/download?os=linux
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

### Show disk usage of the directory you are currently
```
du -h
```

### Show root file system disk usage 
```
df -h
```

### Display disk partitions, sizes, and types with the command
```
fdisk -l
```

### List all running process
```
top
ps aux
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

### See information about block devices
```
lsblk 
```

### check if the system in 64 or 32 bit system 
```
getconf LONG_BIT
arch 
```

### To kill a proccess
```
kill -9 [PID number]
kill -15 [PID number]
```

### Terminate a Linux process under a given ID
``` 
kill [process_id]
```

### Terminate a process under a specific name
``` 
killall  [process_name]
```

### Run a Linux Command or job in the Background
```
command &
sleep 5000
```

### List all running jobs
```
jobs -l
```

### Bring a particular job to the foreground
```
fg [job_number] 
```

### Terminate the background process
```
kill -9 [job_ID] 
kill -9 25177
```

### Linux symbol 
- `~`  is equal to the current user's home directlry. E.g: /home/someone/
- `*`	 A symbol which stands for "everything" `rm -rf *`
- `&`	 Run a command in the background
- `&&` These symbols written together stand for `and`
- `\`  Allows you to continue writing commands/Bash syntax in new line.
- `..` help to take one step back 
- `.`	 In navigation or referring to files/folders, the dot stands for the current folder.
- `#`	 Everything after this symbol in the same line is considered to be a comment, so it won't be processed by the shell.
- `>`	  Take the output of a command and redirect it into a file (will overwrite the whole file).
- `;`   help move to the new line 

### Example with \
Let create 5 directories
```
mkdir hr finance manager supervisor employee student
```
```
mkdir hr \
  finance \
  manager \
  supervisor \
  employee \
  student
```


