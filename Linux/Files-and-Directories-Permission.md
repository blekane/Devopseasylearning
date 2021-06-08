## File and Directories Permissions in Linux/Unix

**In this Linux file commands tutorial, you will learn**
- Ownership of Linux files
- Permissions
- Changing file/directory permissions with 'chmod' command
- Absolute(Numeric) Mode
- Symbolic Mode
- Changing Ownership and Group
- SGID (set group ID)
- SUID (set user ID)
- Sticky bir
- ACL (Access Control List)

## Ownership of Linux files
Every file and directory on your Unix/Linux system is assigned 3 types of owner, given below.

- **User:** A user is the owner of the file. By default, the person who created a file becomes its owner. Hence, a user is also sometimes called an owner.

- **Group:** A roup can contain multiple users. All users who are in the same group will have the same Linux group permissions access to the file. Suppose you have a project where a number of people require access to a file. Instead of manually assigning permissions to each user, you could add all users to a group, and assign group permission to file such that only this group members and no one else can read or modify the files.

- **Other:** Other
Any other user who has access to a file. This person has neither created the file, nor he belongs to a usergroup who could own the file. Practically, it means everybody else. Hence, when you set the permission for others, it is also referred as set **permissions for the world**.

## Permissions
Every file and directory in your UNIX/Linux system has following 3 permissions defined for all the 3 owners discussed above.


- **Read:** This permission give you the authority to open and read a file. Read permission on a directory gives you the ability to lists its content.

- **Write:** The write permission gives you the authority to modify the contents of a file. The write permission on a directory gives you the authority to add, remove and rename files stored in the directory. 

Consider a scenario where you have to write permission on file but do not have write permission on the directory where the file is stored. You will be able to modify the file contents. But you will not be able to rename, move or remove the file from the directory.


- **Execute:** In Windows, an executable program usually has an extension `.exe` and which you can easily run. In Unix/Linux, you cannot run a program unless **the execute permission is set**. If the execute permission is not set, you might still be able to see/modify the program code, **but not run it**.

## Let's see file permissions in Linux with examples 1:
![](/images/files1.JPG)


## Let's see file permissions in Linux with examples 2:
![](/images/files2.JPG)


## Changing file/directory permissions with 'chmod' command
We can use the `chmod` command which stands for **change mode**. Using the command, we can set permissions (read, write, execute) on a file/directory for the owner, group and the world. Syntax:
```
chmod [permissions] [file/directory name]
```

**There are 2 ways to use the command**
- Absolute(Numeric or Octal) Mode
- Symbolic Mode

## Absolute(Numeric) Mode
In this mode, file permissions are not represented as characters but a **three-digit octal number**.
The table below gives numbers for all for permissions types.
![](/images/files3.JPG)

## Symbolic Mode
In the Absolute mode, you change permissions for all 3 owners. In the symbolic mode, you can modify permissions of a specific owner. It makes use of mathematical symbols to modify the Unix file permissions.

![](/images/files4.JPG)

![](/images/files5.JPG)


# Special Types of Permission in Linux
There is 4 types of special permission in linux:
- SGID (set group ID)
- SUID (set user ID)
- Sticky bir
- ACL (Access Control List)

**Command to check special permission:**
```
getfalcl  [file or directory name]
ls -l  [file or directory name]
```

![](/images/files6.JPG)

**NB:**
- Uppercase **S** means the execute permission is not being set
- Lowercase **s** means the execute permission is being set
- Uppercase **T** means the execute permission is not being set
- Lowercase **t** means the execute permission is being set

# SUID
**SUID:** it's a special permission assigned to a file. These permissions allow the file being executed with the **privileges** (permissions) of the owner of the file. For example, if a file was owned by the root user and has the SUID being set, no matter who executed the file it would always run with root user privileges.

### Octal (numbers) representation

**4 set the SUID**
```
chmod 4[permission] [file or directory name]
```
**Example:**
```
chmod 4766 hr 
```

### Symbolic representation
```
chmod u+s [file or directory name] 
```
**Example:**
```
chmod u+s hr
Or
chmod u+s,a+rwx hr

chmod u=rws,g=rw,o=rw hr
Or
chmod u=rwS,g=rw,o=r hr
```
**Users are able to change their password in Linux because the SUID is being set on the `passwd` command**
![](/images/files7.JPG)
