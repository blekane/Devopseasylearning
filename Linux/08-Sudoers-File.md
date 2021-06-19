## Sudoers File in Linux
**The sudoers file** is a system file in Linux and Unix used to allocate system rights to system users. This allows the administrator to control who does what. Remember, Linux is built with security in mind. When you want to run a command that requires root rights, Linux checks your username against the sudoers file.

### What is the difference between sudo and su in linux
![](/images/sudoers1.JPG)


### Sudoers file location
```
cat /etc/sudoers
```
**NB:** never user other text editor like nano or vim to edit sudoers file because it can lock the system if other admin users are editing the sudoers file

Always use these commands to edit sudoers file
```
sudo visudo: for sudo sudoers users
visudo: for root users
```
![](/images/sudoers2.JPG)

### Editing sudoers file with visudo
What will happened if 2 admins want to edit the sudoers file at the same time using visudo?

**Admin 1**

The sudoers is going to open without any issue
![](/images/sudoers3.JPG)

**Admin 2**

As we use `visudo` to open the file, we will be notified that someone else is editing the sudoers file already because only one user can edit the file at the same time to avoid `system lock off`.
![](/images/sudoers4.JPG)

### What will happened if 2 admins want to edit the sudoers file at the same time using vim?
system lock off or block

### Default time for sudoers 
man sudoers and search for `/timestamp`: you will find out that the default timestamp_timeout is `5 min` for CentOs and `15 min` for Ubuntu. 

### All users will be prompt to enter their password after 5 min that they user sudo
```
Default timestamp_timeout=5  
```

### All users will be prompt to enter their password after 10 min that they user sudo
```
Default timestamp_timeout=10  
```

### All users will be prompt to enter their password each that they user sudo
```
Default timestamp_timeout=0   
```

### To set a time  timestamp for multiple users
This meant all these particular users aryan,tia,lucas,janet,leo will be prompt for password every time that they use sudo
```
Defaults: aryan,tia,lucas,janet,leo timestamp_timeout=0 
```

### This meant all these particular users aryan,tia,lucas,janet,leo will be prompt for password every 10 minutes that they use sudo
```
Defaults: aryan,tia,lucas,janet,leo timestamp_timeout=10 
```

### Allow root to run any commands anywhere
```
root    ALL=(ALL)       ALL
```

### Allows users in group wheel to run all commands with root privilege
```
%wheel  ALL=(ALL)       ALL
```

### All users in admin  group will run all commands with root privilege 
```
%admin  ALL=(ALL)       ALL
```

### All users in admin group will run all commands with root privilege without providing sudo password
```
%admin       ALL=(ALL)       NOPASSWD: ALL
```

### ansadmin will run all commands with root privilege 
ansadmin  ALL=(ALL)       ALL

### ansadmin will run all commands with root privilege without providing sudo password
ansadmin        ALL=(ALL)       NOPASSWD: ALL

### How to add a user and grant him root privilege to reset user password only?
Add a group called helpdesk and add all helpdesk users that you want them to rest users' password. Then add the following to the sudoers file.
```
%helpdesk ALL=/usr/bin/passwd
```

### This means user aryan will be able to change leo and tia password
```
aryan ALL=(root) /usr/bin/passwd/tia, /usr/bin/passwd leo 
```

### This means aryan can start, stop and check a status of sshd daemon for CentOs 6
```
aryan ALL=(root) /sbin/service sshd stop, /sbin/service sshd start, /sbin/service sshd status
```
```
sudo service sshd status
sudo service sshd start
sudo service sshd stop
```