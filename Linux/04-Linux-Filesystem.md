## Linux Filesystem

Let's take a quick look at the standard for the filesystem to better understand how things are organized.
The filesystem starts with a **root** represented by a **slash**. The root is the highest level of the organizational hierarchy of the filesystem. Each system only has **one filesystem**, and everything else, folders, external hard drives, network shares, is represented within it. 

![](/images/filesystem.JPG)

- **ROOT (/)** it's like a C drive in windows. It can read, write or execute any program
- **HOME:** That's where the regular user's home folders are stored. Root is where the root's home folder is stored.
- **ETC:** it is where most programs keep their configuration files
- **BIN:** it is where rigular user commands are store (executable programs are stored in BIN AND SBIN)
- **SBIN:** it is where rigular root user commands are store (executable programs are stored in BIN AND SBIN)
- **DEV:** it is where the system keeps references to all the hardware it has such as hard drives, memory, CPUs, and everything else. 
- **MNT:** You may also need to work in the mnt folder which is where local or network filesystems are mounted into the overall system or the media folder where removable file systems like USB drives and optical drives are mounted.
- **TMP:** it is a temporary directory. Its contains temporary data that will be erased when you reboot your computer
- **USR:** user directory. It contains user data and programs
- **VAR:** variable data directory. It is where the system must be able to write files and folders during operation. It's the system LOG
- **lib:** it is where 32 bit programs are installed
- **lib64:** it is where 64 bit programs are installed

![](/images/filesystem-2.JPG)

