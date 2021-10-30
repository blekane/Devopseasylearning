## Modules
Modules in ansible are just python scripts that are copied over into the target servers and they are stored in the home directory of the user that was set up to run ansible commands on the tagert servers in a hidden file called .ansible. When the task is done, ansible will automatically remove the module.
```
ansible all -m ping
```
m= module or command to be run on the tatget servers

## Default forks configuration
By default, ansible runs tasks only on 5 remote nodes parallelly. If you have more than 5 remote nodes, you must change this value. Otherwise, ansible will run on 5 nodes first, pick up another 5 nodes on so on. 

![](/images/ans1.JPG)

If the forks value is 1, ansible will run a task in series as shell script in the loop. Which will finish with one server first before running on the second server and so on.

![](/images/ans2.JPG)

If you have 500 target servers in your environment, put 500 so that ansible will run the task on all the 500 servers at the same time (parallelly)
![](/images/ans3.JPG)

### This command will run at the same time if forks=5
```
ansible all -m shell -a "sleep 5; echo 'hi'"
```

### This will runs in serie if forks=1
```
ansible all -m shell -a "sleep 5; echo 'hi'"
```

### Ping module
To check connectivity
```
ansible all -m ping
```

### To check the uptime of a servers
```
ansible app -m shell -a "uptime"
```
- Shell module is used to run all linux command on the remote node
- -m=module
- -a=argument (some module required argument and some will not)

## Custom inventory
```
ansible -i myhosts web -m shell -a "uptime"
ansible -i myhosts web -m shell -a "free -mh"
-i=inventory
```

### Get `ansible_os_family` and `ansible_pkg_mgr` with setup
```
ansible all -m setup -a "filter=ansible_distribution*"
ansible all -m setup -a 'filter=ansible_os_family'
ansible all -m setup -a 'filter=ansible_pkg_mgr'
```

### PRIVILEGE ESCALATION
Ansible provides features for the privilege escalation against servers. If you want to run the ad-hoc command as a non-root user, you can use the `--become` option to get the root privileges and the `-K` option to prompt the password.
```
ansible all -m shell -a "fdisk -l" --become
```
Run the ad-hoc command 'fdisk -l' as a user 'ansadmin' with the privilege option '--become' and the '-K' to prompt the 'SUDO Password'.
```
ansible all -m shell -a 'fdisk -l' -u ansadmin --become -K
Or 
ansible all -m shell -a 'fdisk -l' -u ansadmin -b -K
```
- u=user
- b=become root
- K=ask for sudo password
- m=module

### If you're using the custom inventory file, add the `-i` option followed by the inventory file name.
```
ansible app -i myhosts -m setup -a "filter=ansible_distribution*"
```
- -i=inventory
- This when you do not want to use the default inventory in file in ansible.cfg file

### Update Repository and Upgrade Packages
To update and upgrade the repository of Ubuntu and Centos servers, we can use the ad-hoc command with the apt module.
```
ansible all -m apt -a 'update_cache=yes' --become
ansible all -m yum -a 'update_cache=yes' --become
```

### MANAGE PACKAGES
Ad-hoc command will give you an easy way to install that package without login to each server.

1. Install Package
Install a single package using the ad-hoc command with the apt module as below.
```
ansible all -m yum -a 'name=nginx state=latest' --become
```
2. Remove Package
Remove the package and purge all configuration related to the package.
```
ansible yum -m yum -a 'name=nginx state=absent purge=yes' --become
```

### Transfer a file from ansible engine to nodes using copy module
```
ansible all -m copy -a "src=/etc/ansible/hosts dest=/hosts"
Or
ansible all -m copy -a "src=./hosts dest=/tmp"
```

This will copy hosts file to the target servers in /tmp with the same file name
ansible all -m copy -a "src=/etc/ansible/hosts dest=/hosts"

This will copy hosts file to the target servers in /tmp with different file name call inventory
ansible all -m copy -a "src=/etc/ansible/hosts dest=/inventory"


### COMMAND MODULE
By default, if you run an ansible ad-hoc command without providing the module, it will use the command module.
**NB:** this will work only if you are not using some special characters such as <, > pipe ( | ), & and so on. If you want to use this special characters, then use the shell module

1. This will use a default module command
```
ansible all -a "uname -r"
Or
ansible all -m command -a "uname -r"
```

2. We can add the default command module
ansible all -m command -a "uname -r"

3. This will give the same result
ansible all -m shell -a "uname -r"

4. This will not work with command module because of special characters ( > )
ansible all -m command -a "cat /etc/passwd > /tmp/file.txt"

ansible all -m shell -a "cat /etc/passwd > /tmp/file.txt" # this will work because we are using shell module

5. This will work
ansible all -m command -a "cat /etc/passwd"
Or 
ansible all -a "cat /etc/passwd"


### Difference between shell and command in ansible
The command(s) will not be processed through the shell, so variables like $HOME and operations like `"<", ">", "|", ";"` and "&" will not work. Use the shell module if you need these features.

The Shell and Command modules are very similar, the major difference being that the shell module does not escape commands, allowing you to use shell operators like redirects ("greater than", "less than"), pipe ("|") and boolean operators ("&&", "||"). 

