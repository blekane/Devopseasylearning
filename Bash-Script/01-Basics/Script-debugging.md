## How to debug a script?
When a script does not work properly, we need to determine the location of the problem. The UNIX/Linux shells provide a debugging mode. Run the entire script in debug mode or just a portion of the script. To run an entire script in debug mode, add `-x` after the `#!/bin/` [shell or interpreter] on the first line.

**For Example:**
```sh
#!/bin/bash -x
```

To run an entire script in debug mode from the command line, add a -x to the sh command used to execute the script:
```
sh -x script_name
```

Run several portions of a script in debug mode by placing the `set -x` option at the point where debugging is to begin and the `set +x` option where you want it to stop. Do this as many times in the script as you want. The debug options are shown in Table below:

| Option | Meaning | 
| :--- | :--- | 
| set -x | Prints the statements after interpreting metacharacters and variables |
| set +x | Stops the printing of statements |

**For Example:**
```sh
#!/bin/sh
set -x
echo "Your home is : $HOME"
echo The bash version is: $BASH_VERSION
set +x
echo The name of the your computer is: $HOSTNAME
echo Your home directory is :$HOME
echo Your present working directory is: $PWD
echo echo The Shell being used by the user $SHELL
echo You path is: $PATH
echo The user who is curently login is: $USER
echo The user ID is: $UID
echo The Default terminal emulator is: $TERM
echo your current language is: $LANG
```

**Output:**
```sh
++ echo 'Your home is : /root'
Your home is : /root
++ echo The bash version is: '5.0.17(1)-release'
The bash version is: 5.0.17(1)-release
++ set +x
The name of the your computer is: ubuntu
Your home directory is :/root
Your present working directory is: /root/scripts
echo The Shell being used by the user /bin/bash
You path is: /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin
The user who is curently login is: root
The user ID is: 0
The Default terminal emulator is: xterm-256color
your current language is: en_US.UTF-8
```

## How to escape a special character in bash?
The double quote (") allows the dollar sign ($) to retain its special meaning. Both the backslash (\) and single quote (') would remove the special meaning of the dollar sign. 

```sh
[root@server1 ~]# echo "$5"
 
[root@server1 ~]# echo '$5'
$5
[root@server1 ~]# echo \$5
$5
[root@server1 ~]#
```

## How do I capture the output of the script into a file? 
```sh
#!/bin/bash
 
cat << EOF
    ****************************
    * 1 = service sshd status  *
    * 2 = service sshd start   *
    * 3 = service sshd restart *
    * 4 = service sshd stop    *
    ****************************
EOF
yum install git -y
yum install tree -y
```

1. we can pipe the script into a tee command and the script will just run quirely and the output will be redirected into a file.
```
vim script.sh
./script.sh |tee result.txt
cat result.txt |less
```

2. We can use append “>” or redirect “>>” to redirect the output in a file
```
./script.sh > result2.txt
cat result2.txt |less
```

**Output:**
```
    ****************************
    * 1 = service sshd status  *
    * 2 = service sshd start   *
    * 3 = service sshd restart *
    * 4 = service sshd stop    *
    ****************************
Loaded plugins: fastestmirror, langpacks
Loading mirror speeds from cached hostfile
 * base: mirror.dal.nexril.net
 * extras: mirror.cogentco.com
 * updates: centos.mirror.lstn.net
Package git-1.8.3.1-21.el7_7.x86_64 already installed and latest version
Nothing to do
Loaded plugins: fastestmirror, langpacks
Loading mirror speeds from cached hostfile
 * base: mirror.dal.nexril.net
 * extras: mirror.mi.incx.net
 * updates: centos.mirror.lstn.net
Package tree-1.6.0-10.el7.x86_64 already installed and latest version
Nothing to do
```
