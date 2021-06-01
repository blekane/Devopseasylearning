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
