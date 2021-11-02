#!/bin/bash

# 4. Create User Accounts:
# 6.Configure a User Account

touch /tmp/userlist.txt
echo "Natasha" >> /tmp/userlist.txt
echo "harry" >> /tmp/userlist.txt
echo "Sarah" >> /tmp/userlist.txt
echo "Manalo" >> /tmp/userlist.txt

userlist=/tmp/userlist.txt
username=$(cat /tmp/userlist.txt | tr 'A-Z' 'a-z')
password=$username@redhat

for user in $username
do
useradd $user
echo $password | passwd --stdin $user
done

usermod -aG sysmgrs natasha
usermod -aG sysmgrs harry
usermod -s /sbin/nologin sarah
usermod -u 3533 manalo

# 11. Search Files 
find / -user natasha -exec cp -a {} /root/findfiles \;

# 7. Search a String
cat /usr/share/dict/words |grep ismi > /root/lists

# 10. Create a Share Directory
mkdir /home/managers
chgrp sysmgrs /home/managers
chmod 2770 /home/managers

# 9.Configure Permission
cp /etc/fstab /var/tmp/fstab
chown root /var/tmp/fstab
chmod g-x /var/tmp/fstab; chmod o-x /var/tmp/fstab
setfacl -m u:natasha:rw- /var/tmp/fstab
setfacl -m u:harry:--- /var/tmp/fstab
chmod o+r /var/tmp/fstab

# 13. Create a logical volume
fdisk /dev/sdb <<EOF
p
n
e
4147200
16777215
p
w
EOF
partprobe

fdisk /dev/sdb <<EOF
p
n
e
4149248
+1G
p
t
5
8e
p
w
EOF
partprobe

pvcreate /dev/sdb5
vgcreate -s 16MB qagroup /dev/sdb5
lvcreate -l 60 -n qa qagroup
mkfs.ext3 /dev/qagroup/qa
mkdir /mnt/qa
echo "/dev/qagroup/qa   /mnt/qa   ext3    defaults      0 0" >> /etc/fstab
mount -a


# 19. Add a Swap Partition

fdisk /dev/sdb <<EOF
p
n
6248448
+756M
p
t
6
82
p
w
EOF
partprobe

mkswap /dev/sdb6
echo "/dev/sdb6    swap      swap    defaults        0 0" >> /etc/fstab
swapon -a

# 5. Configure SELINUX to make it in enforcing mode

sed -i '/SELINUX=permissive/d' /etc/selinux/config
sed -i '/disabled /aSELINUX=enforcing' /etc/selinux/config
# sed -i '/#     disabled - No SELinux policy is loaded./aSELINUX=enforcing' /etc/selinux/config
# echo "SELINUX=enforcing" >> /etc/selinux/config
