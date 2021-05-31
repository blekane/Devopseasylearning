## USERS AND GROUPS MANAGEMENT

### To add a new use
```
useradd <username >
```

### To delete the user and keep his home directory 
```
userdel <username>
```

### To delete the user and delete his home directory 
```
userdel -r <username>
```

### To assign a password to a new and reset user password (your most have root privileges)
```
passwd <username >
```

### To add a new group
```
groupadd <group name>
```

### add a new group accounting with the group ID 1050
```
groupadd -g <group ID> <group name>
groupadd -g 1050 accounting
```

### To change GID or group ID
```
groupmod -g <group ID> <group name>
groupmod -g 1000 manager
```

### To change the group name
```
groupmod -n <new group name>  <old group name>
```

### To delete group
```
groupdel <group name>
```

### To add the groups multiple groups as once
```
groupadd finance; groupadd HR; groupadd manager
```

### To check the group that the user belongs to
```
id <username>
groups  <username>
```

## Useradd and usermod options:
`usermod` is use to modify the user account

![](/images/u1.JPG)


**-u =** user ID of the new account
**-aG =** append the user to a supplementary group
**-G =** add the user to a secondary group
**-c =** comment or a user's full name at the 5 column
**-l** = new value of the login name or to change the login name
**-e =** set account expiration date 

### To change login name
```
usermod -l + new username + old username
usermod -c "tom john" tom
```

### To change the user default primary group
``` 
usermod -g <group name> <username>
```

### To add the user in the secondary group
```
usermod -G  <group name> <username>
```

### To add the user in the supplementary group
```
usermod -aG  <group name> <username>
```

### To see all members of the group
```
getent group + group name
```

### To change user default shell 
```
chsh <username>
Or
usermod -s /bin/sh <username>
Or
chsh --shell /bin/sh <username>
Or
vim /etc/passwd <change the shell>
```

### To block a user so that he will not be able to login
```
usermod -s /sbin/nologin <username>
usermod -s /sbin/nologin ruth
Or
usermod -s /sbin/false <username>
usermod -s /sbin/nfalse ruth
```

### To reverse the process so that user ruth can be able to login
```
usermod -s /bin/bash <username>
usermod -s /bin/bash ruth
```
![](/images/u2.JPG)

### To delete a user from a particular group 
```
gpasswd -d <username> <group name>
```
![](/images/u3.JPG)

### Example using usermod: 
```
groupadd finance; groupadd HR; groupadd manager; groupadd sysadmin
useradd tom

usermod -s /sbin/nologin -u 1500 -g HR -G sysadmin -aG manager,finance -c "tim smith" tim

groups tom
tail /etc/group
```
![](/images/u4.JPG)
