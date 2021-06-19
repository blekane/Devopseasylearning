## Runlevel In Linux 
**NB:** Use CentOs server for hand on

In Linux, the system can be run in different states. This enables the system admin to change the system state based on the work being done on the server. We have **7 runlevels** in Linux

- **Runlevel 0 or init 0:** or init o is to shutdown the system
- **Runlevel 1 or init 1:** or single use mode is the maintenance mode and it is used for troubleshooting and only the user root can login.
- **Runlevel 2 or init 2:** Multi-user mode  (people can login but the server can connect to the internet)
- **Runlevel 3 or init 3:** CLI mode (Company prefers runlevel 3).
- **Runlevel 4 or init 4:** N/A ( probability for future used)
- **Runlevel 5 or init 5:** fully functional system with a GUI or GUI mode
- **Runlevel 6 or init 6:** to reboot the system

### Command to check the default run level
```
runlevel

OR

who -r (r = runlevel)
```

## Boot up process in Linux

**1- BIOS**
Bios stand for basy input output system. When you turn on the system, the Bios run first. It runs a program called a POST (power on self test). This program is responsible for checking all the main hardware. When everything is good, it looks for the MBR program and loads it.

**2- MBR or master boot record**
It has information about the boot loader. It is located in the first sector of the hard drive. We have two types of boot loaders.
- LiLO (old boot loader in linux)
- The Grub or GRand Unified Bootloader (new boot loader in linux)

**3- Grub: Grand unified boot loader**
The grub will display a splash screen with all available kernels for the user to choose. If none is choosing, it will load and will execute the default kernel.

All the grub configurations are in:

For Centos 6
```
/etc/grub.conf
/boot/grub/grub.conf
```

For Centos 7
```
cat /etc/grub2.cfg
cat /etc/grub2.cfg |grep timeout
cat /etc/grub2.cfg |grep -i core
```

![](/images/run1.JPG)

**4- Kernel**
It is responsible for mounting all the file systems starting with the root file system by reading the content of the file system table `/etc/fstab`. We put all the mount points here so the kernel can mount it when the system is booting. The kernel also executes the init program.

![](/images/run2.JPG)

**5- The init** 
It is the first program running on a Linux system with the PID of 1. It is the parent of all processes on the system. It checks the inittab file for the default runlevel, executes it `etc/inittab` and sends the command runlevel program.

**Some of the most important systemd targets are:**
**- graphical.target** – run the system with graphical user interface (Desktop).
**- multi-user.target** – System run in multi user mode, but text based login only, no desktop
**- rescue.target** – Rescue mode, can be used to reset root password.

```
systemctl get-default
systemctl set-default target-name
systemctl set-default graphical.target
systemctl set-default multi-user.target
systemctl set-default rescue.target
```

![](/images/run3.JPG)

**7- Runlevel**
In runlevel step, the system turns on or off the service base of the default runlevel. They is a directory on the system where we can check all those runlevel call `/etc/rc.d`

![](/images/run4.JPG)

