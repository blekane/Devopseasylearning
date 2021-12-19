## Steps to create any user on Ubuntu server:
```
useradd automation
passwd automation
Check UserHome: ls -lrt /home/automation
if user home is not created then run below two commands:
mkdir -p /home/automation
chown -R automation:automation /home/automation

How to change a shell for the user?
simply run below command and provide the password and path of the required shell as /bin/bash.
Command is: chsh
```


chown -R eric:eric /home/eric
mkdir -p /home/eric
usermod -s /bin/bash eric
usermod -aG sudo eric
usermod -aG admin eric

usermod -aG docker eric

