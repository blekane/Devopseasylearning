## Add users to group admin
```
groupadd admin
usermod -aG admin tom
visudo
%admin  ALL=(ALL)       ALL
sudo su
```

## Alow a user to run docker command with sudo 
```
useradd tim 
passwd tim
usermod -aG docker tim
```






