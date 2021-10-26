## Things to know before working with ansible
	```
	1) ansible is agentless ( means, we do not need to run any agent on remote servers for communication )
	
	2) ansible follows push model ( means we push the configuration from ansible controller to remote servers )
	
	3) ansible uses SSH protocol to communicate with remote servers
	
	4) ansible uses below methods for remote servers authentication
	
			password based
			key based

Ansible controller ( is the machine/host/server where we install ansible ) 

	/etc/ansible default directory ( we have two important file in it )
	
		hosts ( default inventory file in which we can mention remote servers we want to apply/push the changes to)
		
		ansible.cfg  ( default ansible configuraton - can be used to customize as per our need )


Ansible Terminlogy 

	1) ansible ad-hoc commands ( single task that can be executed against remote servers )
	
	2) ansible playbooks  ( set of instructions written in a .yml file to execute against remote servers  )
```

## assignment:
```
    please answer the following question
    1- what does it means by configuration management tool
    2- in what category of tool does ansible fall
    3- explain ansible in simple way
    4-  what is the structure of ansible
    5- what does it means by indempotency (ansible will not complain that the package is already install when you run it for the second time)
    6- why is ansible prefer to other tools
    7- what are tools simar as ansible
    8- is ansible a push base or pull base?
    9- what does it mean by push base
    10- is ansible agentless ? please justify (not agent is been install on the server)
    11- what is inventory file
    12- where does the default inventory file locate
    13- what is the best way to install ansible (by using pip)
    14- what is the name of the script that ansible use
    15- what is the meaning of "hosts: all" in the playbook
    16 please provide the sctruture of a simple playbook with on task
    17-  configure ansible following this setup
          a- one master
          b- two node ubuntu
          c- one node centos
          d- ping all nodes and send the screenshoot
    18- write a playbook that perform the following task
          a- update all servers
          b-  create a directory with your name
          c-  install git httpd apache2 vim curl wget openssl
          d- clone the following repository  https://github.com/kemvoueric/Devops-easy-learning-jenkins-install.git
          e- move the output of the previous clone repository to the directory your created on step b
          f-  run the script downloaded from repos
          g create a user with your name a password and add it to the suoders file
    19 - please send your homework as a file attached to the general channel on slack
    20 - for any issue while doing this homework paste the issue on slack and we will get back to you
```

```yml
##############################################PROBLEM##############################
-- willy          ---------- create group manager, update all packages, check if java, jenkins is install, if jenkins is install restart jenkins
-- alfred ----------------- add a user called alfred and add it to a  manager group assign a name call 'alfred le bengiuste' and  id 414141
-- awamba ------------------- create file and at the same time append 5 line into that file plus assign that file to user alfred and group manager
--                         with read write permission for user and read only permission to others
christian  ----------- installll a list of packages  : httpd apache2 vim curl unzip wget nginx
emeric --------------- write a script that will print all users and write a module ro run that script and print the output
ivo -------------------- write a docker compose file with 4 services running the following container nginx httpd apache2 centos ubuntu
                          and run docker-compose with ansible  
philomene -------------- create a service that will start nginx  httpd apache2 and also a module that will print all
                                 running containers and list all images
 igor ----------- create 5 five directory as a list in a single modules and give read write execute permission to all recursively for all file
 stephane ------------- create a user stephane assign a password abc123 and make sure that password expired at first login
 noel --------------  write a script that will print the first and last string on /etc/password then write a module that will run
############################################SOLUTION##############################
---
- hosts: all
  become: yes
  tasks:
          - name: Ensure group "manager" exists
            ansible.builtin.group:
              name: manager
              state: present
          - name: checking java
            shell: java -version
            register: willy
            ignore_errors: yes
          - debug:
               msg: "value of willy is: {{ willy.stdout_lines }}"
          - name: checking jenkins
            shell: ls /var/lib | grep jenkins
            register: current_version
            ignore_errors: yes
          - name: Start jenkins
            ansible.builtin.service:
              name: jenkins
              state: started
            when: current_version.rc == 0
          - name: Add the user 'Alfred'
            ansible.builtin.user:
              name: alfred
              comment: le benguiste
              uid: 414141
              group: manager
          - name: Touch a file, using symbolic modes to set the permissions (equivalent to 0644)
            ansible.builtin.file:
              path: /home/ansible/large
              state: touch
              owner: ansible
              group: manager
          - name: create a file and append 5 line
            blockinfile:
              path: /home/ansible/large
              block: |
                Match User ansible-agent
                PasswordAuthentication no
                Match User ansible-agent
                Match User ansible-agent
                Match User ansible-agent
          - name: Change file ownership, group and permissions
            ansible.builtin.file:
              path: /home/ansible/large
              owner: alfred
              group: manager
              mode: '0644'
          - name: Copy emeric.sh
            ansible.builtin.copy:
                  src: /home/ansible/emeric.sh
                  dest: /home/ansible/emeric.sh
                  owner: ansible
                  group: manager
                  mode: '0777'
          - name: run emeric.sh
            shell: bash /home/ansible/emeric.sh
            register: xyz
          - debug:
              msg: "value of xyz is: {{ xyz.stdout_lines }}"
          - name: igor create directory if they don't exist
            file:
              path: "{{ item }}"
              state: directory
              owner: ansible
              group: manager
              mode: 0775
            loop:
              - directory1
              - directory2
              - directory3
              - directory4
              - directory5
          - name: Create stephane user
            user:
              name: stephane
              password: "{{ 'password' | password_hash('sha512') }}"
              shell: /bin/zsh
              update_password: on_create
            register: stephane
          - name: Force stephane to change password
            shell: chage -d 0 stephane
            when: stephane.changed
          - name: cat /etc/passwd
            shell: cat /etc/passwd | awk -F":" '{print $1 "              " $NF}'
            register: xyz
          - debug:
              msg: "value of xyz is: {{ xyz.stdout_lines }}"
######################################################
- hosts: ubuntu
  become: yes
  tasks:
     - name: Upgrade all packages on servers
       apt:
          name: "*"
          state: latest
     - name: install packages
       apt:
        name:
            - apache2
            - vim
            - curl
            - unzip
            - wget
        state: present
######################################
- hosts: devcentos
  become: yes
  tasks:
          - name: Upgrade all packages on servers
            yum:
                name: "*"
                state: latest
          - name: install packages
            yum:
              name:
                  - httpd
                  - vim
                  - curl
                  - unzip
                  - wget
              state: present
```