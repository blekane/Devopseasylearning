## How Recover the Root Password
To change or to recover the root password, we take the system to maintenance mode.

### Centos 6 or RHEL 6
1. Reboot your system `reboot`
2.  When the system is booting up, we interrupt the grub by pressing any key on the keyboard to take it to maintenance mode. And press `e` for edit, we choose the kernel and we press another `e` to edit
3.  After that, put a space and put `1` to let the system know that you want to go to runlevel 1 which is maintenance mode
4. Press `enter` and press `b` to boot and this will give you root access
5. Change the root password with “passwd root” and confirm the password
6. Type `exit` to reboot

### Centos 7 or RHEL 7
1. reboot your system `reboot`
2. Hold `shift` to interrupt the boot 
3. Press `e` to edit
4. Go to the end of Linux16 and add `rd.break` to break the boot and boot into single user mode
5. Press `ctrl +x` to reboot
6. Type `mount -o remount,rw /sysroot` to mount the file system so that we can able to write something on it
7. Type `chroot /sysroot` to become a root
8. Type `passwd` to reset or change the password. 
9. Type the new root password and confirm it
10. Type “touch /.autorelabel” to relabel selinux so that selinux will automatically relabel your selinux context 
11. Type `exit` 
12. Type `exit` again to exit a root user. 

**NB:** Be patient and do not touch anything about the warning that you may have.

13. Type `systemctl set-default graphical.target` if you system did not boot into graphical mode

At the grub menu: tap `e` for edit mode
![](/images/p1.JPG)

**Recap Of All commands**
![](/images/p2.JPG)