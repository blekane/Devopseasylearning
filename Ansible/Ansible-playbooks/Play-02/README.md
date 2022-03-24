
```yaml
# How to define multiple when conditions in Ansible
tasks:
  - name: Reboot Debian or Ubuntu Linux box
    ansible.builtin.command: /sbin/shutdown -r now
    when: (ansible_distribution == "Debian" ) or (ansible_distribution == "Ubuntu")

 - name: Reboot the box if kernel updated and hostname == aws-proxy-server
        reboot:
          msg: "Reboot initiated by Ansible for kernel updates"
          connect_timeout: 5
          reboot_timeout: 300
          pre_reboot_delay: 0
          post_reboot_delay: 30
          test_command: uptime
        when: (reboot_file.stat.exists) and (inventory_hostname == 'aws-proxy-server')


---
  - hosts: localhost
    gather_facts: false
    become: yes
    vars:
      VAR1: value1
      VAR2: value2
      VAR3: value3
    tasks:
      - name: validate multiple variables
        shell: echo "Hello World"
        when: >
            (VAR1 == "value1")  or (VAR2 == "value2" and VAR3 == "value3")


# ---------------------------------------------------------------------
#Ansible When Condition Examples
# https://docs.ansible.com/ansible/latest/user_guide/playbooks_conditionals.html

---
  - name: SImple play to install httpd
    hosts: web_servers
    gather_facts: true
    #become: yes
    tasks:
      - name: Installing httpd using yum
        yum:
          name: httpd
          state: present
        when: ansible_distribution != "Ubuntu"
      - name: Istalling apache2 using apt
        apt:
          name: apache2
          state: present
        when: ansible_distribution == "Ubuntu"


---
- hosts: localhost
gather_facts: no

tasks:
- name: verify httpd version
command: /usr/sbin/httpd -v
register: version
ignore_errors: True

- name: print httpd version
debug:
msg: "{{ version }}"
when: "version.rc == 0" #rc=return code

- name: install httpd
yum: name=httpd state=present
when: "version.rc != 0 "


---
- hosts: webserver1
  tasks:
  - name: install system updates for centos systems
    yum: name=* state=latest update_cache=yes
    when: ansible_distribution == "CentOS"
 
- hosts: dbserver
  tasks:
  - name: install system updates for ubuntu systems
    apt: upgrade=dist update_cache=yes
    when: ansible_distribution == "Ubuntu"


---
- hosts: all
  vars:
    - user: sammy
  tasks:
    - name: Check if file already exists
      command: ls /home/{{ user }}/myfile
      register: file_exists
      ignore_errors: yes

    - name: create file for user
      file:
        path: /home/{{ user }}/myfile
        state: touch
      when: file_exists is failed

    - name: show message if file exists
      debug:
        msg: The user file already exists.
      when: file_exists is succeeded


---
- hosts: all
  vars:
    - user: tia
  tasks:
    - name: Check if file already exists
      command: ls ~/{{ user }}/myfile
      register: file_exists
      ignore_errors: yes

    - name: create file for user
      file:
        path: ~/{{ user }}/myfile
        state: touch
      when: file_exists is failed

    - name: show message if file exists
      debug:
        msg: The user file already exists.
      when: file_exists is succeeded


tasks:
  - name: Shut down CentOS 6 and Debian 7 systems
    ansible.builtin.command: /sbin/shutdown -t now
    when: (ansible_facts['distribution'] == "CentOS" and ansible_facts['distribution_major_version'] == "6") or
          (ansible_facts['distribution'] == "Debian" and ansible_facts['distribution_major_version'] == "7")



tasks:
  - name: Register a variable, ignore errors and continue
    ansible.builtin.command: /bin/false
    register: result
    ignore_errors: true

  - name: Run only if the task that registered the "result" variable fails
    ansible.builtin.command: /bin/something
    when: result is failed

  - name: Run only if the task that registered the "result" variable succeeds
    ansible.builtin.command: /bin/something_else
    when: result is succeeded

  - name: Run only if the task that registered the "result" variable is skipped
    ansible.builtin.command: /bin/still/something_else
    when: result is skipped
# ---------------------------------------------------------------------
#Loops in Ansible

---
- hosts: all
  tasks:
  - name: Install multiple packages
    when: ansible_distribution == "CentOS" 
    yum: name=httpd state=latest 
    when: ansible_distribution == "CentOS" 
    yum: name=git state=latest
    when: ansible_distribution == "CentOS" 
    yum: name=make state=latest
    when: ansible_distribution == "CentOS" 
    yum: name=gcc state=latest
    when: ansible_distribution == "CentOS" 

- hosts: all
  tasks:
  - name: Install multiple packages
    apt: name='{{ item }}' state=latest 
    with_items:
      - apache2
      - git
      - make
      - gcc
    when: ansible_distribution == "Ubuntu"

- hosts: all
  tasks:
  - name: Install multiple packages
    yum: name='{{ item }}' state=latest 
    with_items:
      - httpd
      - git
      - make
      - gcc
    when: ansible_distribution == "CentOS"

---
- hosts: all_servers
  tasks:
  - name: Create multiple directories
    file: path='{{item}}' state=directory mode=775 owner=root group=root
    with_items:
    - '/mnt/dir1'
    - '/mnt/dir2'
    - '/mnt/dir3'


---
- hosts: webserver1
  tasks:
  - name: Stop multiple services
    systemd: name='{{ item }}' state=stopped
    with_items:
      - 'httpd'
      - 'docker'
      - 'ntp'


# ---------------------------------------------------------------------
#Document-block-concept
#block is useful to group multiple tasks and we can apply some opetions like become,ignore_erros and when in block level instead of task level

---
  - hosts: all
    tasks:
      - name: Installing htttpd for RedHat os family
        yum:
          name: httpd
          state: present
        when: ansible_os_family=="RedHat"
        become: yes

      - name: starting httpd for RedHat os family
        service:
          name: httpd
          state: started
        when: ansible_os_family=="RedHat"
        become: yes

      - name: Installing apache2 for Debian os family
        yum:
          name: apache2
          state: present
        when: ansible_os_family=="Debian"
        become: yes

      - name: starting apache2 for Debian os family
        service:
          name: apache2
          state: started
        when: ansible_os_family=="Debian"
        become: yes



---
  - hosts: all
    tasks:
      - block:
        - name: Installing htttpd for RedHat os family
          yum:
            name: httpd
            state: present
        - name: starting httpd for RedHat os family
          service:
            name: httpd
            state: started
        when: ansible_os_family=="RedHat"
        become: yes
      - block:
        - name: Installing apache2 for Debian os family
          yum:
            name: apache2
            state: present
        - name: starting apache2 for Debian os family
          service:
            name: apache2
            state: started
        when: ansible_os_family=="Debian"
        become: yes
      - debug:
          msg: "Succesfully completed all tasks"


# ---------------------------------------------------------------------
#Variable
---
 - hosts: localhost
   vars:
    x: 23
    my_num: 45.67
    my_name: Tia
    my_b: YES
    
   gather_facts: false
   tasks:
   - debug:
      msg:
       - "The value of x is: {{x}} and type: {{x|type_debug}}"
       - "The value of my_num: {{my_num}} and type : {{my_num|type_debug}}"
       - "The value of my_name : {{my_name}} and type: {{my_name|type_debug}}"
       - "The value of my_b is: {{my_b}} and type : {{my_b|type_debug}}"

#RESULT
Ok: [localhost] => {
    "msg": [
        "The value of x is: 23 and type: int",
        "The value of my_num: 45.67 and type : float",
        "The value of my_name : Tia and type: AnsibleUnicode",
        "The value of my_b is: True and type : bool"
    ]
}


# ---------------------------------------------------------------------
---
 - hosts: localhost
   vars:
    x: 34
   gather_facts: false
   tasks:
   - debug: var=x

---
 - hosts: localhost
   vars:
    x: 34
   gather_facts: false
   tasks:
   - name: Displaying values
     debug:
       msg:
       - "The value of x is: {{x}}"

#OUTPUT
ok: [localhost] => {
    "msg": [
        "The value of x is: 34"
    ]
}


# List
---
 - hosts: localhost
   vars:
    x: 34
    pakgs: ['vim','nano','httpd','nginx']
   gather_facts: false
   tasks:
   - debug: var=pakgs

#OUTPUT
ok: [localhost] => {
    "pakgs": [
        "vim",
        "nano",
        "httpd",
        "nginx"
    ]
}


#OR = same result

# List
---
 - hosts: localhost
   vars:
    x: 34
    pakgs:
    - 'vim'
    - 'nano'
    - 'httpd'
    - 'nginx'
   gather_facts: false
   tasks:
   - debug: var=pakgs

#OUTPUT
ok: [localhost] => {
    "pakgs": [
        "vim",
        "nano",
        "httpd",
        "nginx"
    ]
}


# Dictionary or map
---
 - hosts: localhost
   vars:
    x: 34
    web_servers: {'Linux': 'httpd', 'ubuntu': 'apache2'}
    web_servers:
     'Linux': 'httpd'
     'ubuntu': 'apache2'
   gather_facts: false
   tasks:
   - debug: var=web_servers.get('Linux')

# ---------------------------------------------------------------------
#
- Get bash version
- register into variable (it is to store output into a variable)
# 

---
 - hosts: localhost
   gather_facts: false
   tasks:
   - shell: "bash --version"
     register: bash_ver
   - debug: var=bash_ver

---
 - hosts: localhost
   gather_facts: false
   tasks:
   - shell: "bash --version |head -1 |awk -F' ' '{print$4}' |awk -F'(' '{print$1}'"
     register: bash_version
   - debug: var=bash_version

#OUTPUT
"stdout": "5.0.17",

# ---------------------------------------------------------------------

# Running multiple shell commands in Ansible playbook
---
 - hosts: localhost
   gather_facts: false
   tasks:
   - name: Touch delete.sh file
     shell: |
        mkdir ~/tia/testing ansible
        touch ~/tia/testing ansible.txt
        apt update -y
        useradd tom
        usermod -aG docker tom

# ---------------------------------------------------------------------

#Loops
---
  - hosts: localhost
    gather_facts: false
    become: yes
    tasks:
      - yum:
         name: "{{item}}"
         state: absent
        loop:
          - gettext-devel
          - openssl-devel
          - perl-CPAN
          - perl-devel
          - zlib-devel

---
  - hosts: localhost
    gather_facts: false
    become: yes
    tasks:
      - yum:
         name: "{{item}}"
         state: yes
        loop:
          - wget
          - curl
          - git
          - httpd
          - tree

# Arithmetic OPerators
---
 - name: Play for Arithmetic OPerators
   hosts: localhost
   gather_facts: false
   vars:
    x: 56
    y: 34
   tasks:
   - name: Displaying values
     debug:
       msg:
       - "The value of x is: {{x}}"
       - "The value of y is: {{y}}"
       - "{{x}} + {{y}} = {{x+y}}"
       - "{{x}} - {{y}} = {{y-x}}"
       - "{{x}} * {{y}} = {{y*x}}"
       - "{{x}} / {{y}} = {{x/y}}"
       - "{{x}} % {{y}} = {{x%y}}"

#RESULT
ok: [localhost] => {
    "msg": [
        "The value of x is: 56",
        "The value of y is: 34",
        "56 + 34 = 90",
        "56 - 34 = -22",
        "56 * 34 = 1904",
        "56 / 34 = 1.6470588235294117",
        "56 % 34 = 22"
    ]
}



#Working with Gather facts variables or setupt module variables
---
 - hosts: all
   tasks:
   - debug:  
      msg:
       - "The os distribution is: {{ansible_distribution}}"
       - "THe os name is: {{ansible_system}}"
       - "The os family is: {{ansible_os_family}}"
       - "THe mount points are :{{ansible_mounts}}"


#Tags in Ansible
---
  - name: Play with 5 tasks
    hosts: localhost
    gather_facts: false
    tasks:
      - debug:
          msg: "This is a first task"
        tags:
          - first
          - common
          - always
      - debug:
          msg: "This is a second task"
        tags:
          - second
          - never
      - debug:
          msg: "This is a third task"
        tags:
          - third
          - common
          - never
      - debug:
          msg: "This is a fourth task"
        tags:
          - fourth
          - never
      - debug:
          msg: "This is a fifth task"
        tags:
          - fifth
          - never

ansible-playbook play.yml --tags first #run first tags
ansible-playbook play.yml --tags first,second #run first and second tags
ansible-playbook play.yml --tags first,second,third #run first and second tags

#When condition
---
  - name: Simple play to install multiple pkgs
    hosts: web_servers
    gather_facts: true
    become: yes
    tasks:
      - name: Installing webserver on RedHat family
        yum:
          name: httpd
          state: present
        when: ansible_os_family=="RedHat"
      - name: Installing webserver on Debian family
        apt:
          name: apache2
          state: present
        when: ansible_os_family=="Debian"
      - name: Installing java on RedHat family
        yum:
          name: java-1.8.0-openjdk
          state: present
        when: ansible_os_family=="RedHat"
      - name: Installing java on Debian family
        apt:
          name: openjdk-8-jdk
          state: present
        when: ansible_os_family=="Debian"

#install_webserver_RedHat.yml
---
 - name: Installing webserver on RedHat family
   yum:
    name: httpd
    state: present

#install_webserver_Debian.yml
---
 - name: Installing webserver on Debian family
   apt:
    name: apache2
    state: present

#install_java_Debian.yml
---
  - name: Installing java on Debian family
    apt:
      name: openjdk-8-jdk
      state: present

#install_java_RedHat.yml
---
 - name: Installing java on RedHat family
   yum:
    name: java-1.8.0-openjdk
    state: present

#Simple play to install multiple using import task
---
  - name: Simple play to install multiple pkgs
    hosts: web_servers
    gather_facts: true
    become: yes
    tasks:
      - import_tasks: install_webserver_RedHat.yml
        when: ansible_os_family=="RedHat"
      - import_tasks: install_webserver_Debian.yml
        when: ansible_os_family=="Debian"
      - include_tasks: install_java_RedHat.yml
        when: ansible_os_family=="RedHat"
      - include_tasks: install_java_Debian.yml
        when: ansible_os_family=="Debian"

---
  - name: Simple play to install multiple pkgs
    hosts: web_servers
    gather_facts: true
    become: yes
    tasks:
      - include_tasks: install_webserver_{{ansible_os_family}}.yml
      - include_tasks: install_java_{{ansible_os_family}}.yml

#Document-comparison-operators
---
  - name: WOrking with comparison operators
    hosts: localhost
    gather_facts: false
    vars:
      x: 6
      y: 10
      p: 'hi'
      q: 'bye'
      r: 'bye'

    tasks:
      - debug:
          msg:
            - "THe value of x is: {{x}} and The value of y is: {{y}}"
            - "x == y: {{ x == y }}"
            - "x != y: {{ x != y }}"
            - "x < y : {{ x < y}}"
            - "x > y : {{x > y}}"
            - "x <= y: {{ x <= y }}"
            - "x >= y: {{ x >= y }}"
            - "Below are for strings:"
            - "p= {{p}}  q={{q}} r={{r}}"
            - "p == q: {{ p == q }}"
            - "p != q: {{ p != q }}"
            - "q == r: {{ q == r }}"

#RESULT
ok: [localhost] => {
    "msg": [
        "THe value of x is: 6 and The value of y is: 10",
        "x == y: False",
        "x != y: True",
        "x < y : True",
        "x > y : False",
        "x <= y: True",
        "x >= y: False",
        "Below are for strings:",
        "p= hi  q=bye r=bye",
        "p == q: False",
        "p != q: True",
        "q == r: True"
    ]
}

#1.Document-concepts-of-handlers
---
  - hosts: localhost
    gather_facts: false
    become: yes
    tasks:
      - name: Install httpd
        yum:
          name: httpd
          state: present
        notify:
          - start httpd #notify will triggle handlers when there is a change
    handlers:
      - name: start httpd 
        service:
          name: httpd
          state: started # restart if only there is a change


#Document-install-and-configure-tomcat

---
  - name: Install and configure tomcat
    hosts: localhost
    gather_facts: false
    vars:
      req_java: java-1.8.0-openjdk
      set_java: jre-1.8.0-openjdk
      req_tomcat_ver: 9.0.26
      #{req_tomcat_ver.split('.')[0]}} = to get the first num which is 7
      #tomcat-{{req_tomcat_ver.split('.')[0]}}=tomcat-9
      tomcat_url: http://mirrors.estointernet.in/apache/tomcat/tomcat-{{req_tomcat_ver.split('.')[0]}}/v{{req_tomcat_ver}}/bin/apache-tomcat-{{req_tomcat_ver}}.tar.gz
      tomcat_port: 8090
    become: yes
    tasks:
      - name: Updating repos
        yum:
          name: "*"
          state: latest
      - name: Installing required java
        yum:
          name: "{{req_java}}"
          state: present
      - name: Setting default java
        alternatives:
          name: java
          link: /usr/bin/java
          path: /usr/lib/jvm/{{set_java}}/bin/java
      - name: Downloading required tomcat
        get_url:
          url: "{{tomcat_url}}"
          dest: /usr/local
      - name: Extracting downloaded tomcat
        unarchive:
          src: "/usr/local/apache-tomcat-{{req_tomcat_ver}}.tar.gz"
          dest: /usr/local
          remote_src: yes
      - name: Renaming tocmcat home
        command: mv /usr/local/apache-tomcat-{{req_tomcat_ver}} /usr/local/latest
      - name: Replacing default port with required port
        template:
          src: server.xml.j2
          dest: /usr/local/latest/conf/server.xml
      - name: Starting tomcat
        shell:  nohup /usr/local/latest/bin/startup.sh &

#Document-working-with-vars
---
 - hosts: localhost
   vars:
    x: 23
    my_num: 45.67
    my_name: Tia
    my_b: YES
    
   gather_facts: false
   tasks:
   - debug:
      msg:
       - "The value of x is: {{x}} and type: {{x|type_debug}}"
       - "THe value of my_num: {{my_num}} and type : {{my_num|type_debug}}"
       - "The value of my_name : {{my_name}} and type: {{my_name|type_debug}}"
       - "THe value of my_b is: {{my_b}} and type : {{my_b|type_debug}}"


#Docuemnt-membership-operators
---
  - name: This is about membership operators
    hosts: localhost
    gather_facts: false
    vars:
      x: [3, 4, 5]
      y: 5
    tasks:
      - debug:
          msg:
            - "The list or sequence x is: {{x}} and y value is: {{y}}"
            - "y  in x: {{ y in x}}"
            - "10 in x: {{ 10 in x }}"
            - "20 not in x: {{ 20 not in x }}"
            - " y not x:  {{ y not in x }

#RESULT
ok: [localhost] => {
    "msg": [
        "The list or sequence x is: [3, 4, 5] and y value is: 5",
        "y  in x: True",
        "10 in x: False",
        "20 not in x: True",
        " y not x:  False"
    ]
}


#Document-test-operators
---
  - name: This is about test operators
    hosts: localhost
    gather_facts: false
    vars:
      x: 40
      my_name: 'ansible'
      my_path: '/home/ansadmin/my_ansible_nprod/member_ship_op.yml'
      my_link_path: '/home/ansadmin/my_ansible_nprod/operators.yml'
    tasks:
      - debug:
          msg:
            - "x is defined:   {{ x is defined }}"
            - "y is defined:   {{ y is defined }}"
            - "z is undefined: {{ z is undefined }}"
            - "my_name is lower: {{my_name is lower}}"
            - "my_name is upper: {{my_name is upper}}"
            - "my_name is string: {{my_name is string}}"
            - "x is divisibleby 2: {{x is divisibleby 2}}"
            - "x is even: {{ x is even }}"
            - "x is odd: {{ x is odd }}"
            - "x is number: {{ x is number}}"
            - "The given path is: {{my_path}}"
            - "my_path is file:   {{my_path is file}}"
            - "my_path is directory: {{my_path is directory}}"
            - "my_path is exists:   {{my_path is exists}}"
            - "my_link_path is link  {{my_link_path is link }}"

#RESULT
ok: [localhost] => {
    "msg": [
        "x is defined:   True",
        "y is defined:   False",
        "z is undefined: True",
        "my_name is lower: True",
        "my_name is upper: False",
        "my_name is string: True",
        "x is divisibleby 2: True",
        "x is even: True",
        "x is odd: False",
        "x is number: True",
        "The given path is: /home/ansadmin/my_ansible_nprod/member_ship_op.yml",
        "my_path is file:   False",
        "my_path is directory: False",
        "my_path is exists:   False",
        "my_link_path is link  False"
    ]
}

#Document-error-hanlding-with-block-rescue-always
#This is like try, and except block in python. If the first block fails, the second block will run which is the rescure.
---
  - hosts: localhost
    gather_facts: false
    tasks:
      - block:
        - name: Finding files in /home/ansadmin/tomcat8
          command: "ls /home/ansadmin/tomcat8"
          register: tomcat8_out
          ignore_errors: yes
        rescue:
          - debug:
             msg: "The given path: /home/ansadmin/tomcat8 is not a validpath"
        always:
          - debug:
             msg: "THis will always executes"

---
  - hosts: localhost
    gather_facts: false
    vars:
      x: 15
      y: 9
    tasks:
      - debug:
          msg: "The larger number of {{x}} and {{y}} is: {{x}}"
        when: x > y
      - debug:
          msg: "The large number of {{x}} and {{y}} is: {{y}}"
        when: y > x

ok: [localhost] => {
    "msg": "The larger number of 15 and 9 is: 15"
}


#Document-install-httpd-apche
---
  - name: Simple play to install httpd
    hosts: localhost
    gather_facts: true
    #become: yes
    tasks:
      - name: Installing httpd using yum
        yum:
          name: httpd
          state: present
        when: ansible_distribution != "Ubuntu"
      - name: Istalling apache2 using apt
        apt:
          name: apache2
          state: present
        when: ansible_distribution == "Ubuntu"


#Document-practice-on-arithmetic-operatos
---
 - name: Practice on Arithmetic Operators
   hosts: localhost
   gather_facts: false
   vars:
    x: 45
    y: "{{x+5}}"
   tasks:
   - debug:
       msg:
       - "The value of x is: {{x}}"
       - "The value of y is: {{y}}"

ok: [localhost] => {
    "msg": [
        "The value of x is: 45",
        "The value of y is: 50"
    ]
}
===================================================
---
 - name: Practice on Arithmetic Operators
   hosts: localhost
   gather_facts: false
   vars_prompt:
    - name: x
      prompt: Please enter x value
      private: no
    - name: y
      prompt: Enter y value
      private: no
   vars:
     a: 56
   tasks:
   - debug:
       msg:
       - "The value of x is: {{x}}"
       - "The value of y is: {{y}}"
       - "THe additon of {{x}} and {{y}} is {{x|int +y|int}}"
       - "The {{a}} - {{y}} = {{a-y|int}}"

ok: [localhost] => {
    "msg": [
        "The value of x is: 5",
        "The value of y is: 8",
        "THe additon of 5 and 8 is 13",
        "The 56 - 8 = 48"
    ]
}
=========================================
---
 - name: Practice on Arithmetic Operators
   hosts: localhost
   gather_facts: false
   vars_files:
    - my_vars.yml
   tasks:
   - debug:
       msg:
       - "The value of x is: {{x}}"
       - "The value of y is: {{y}}"
=========================================

#Document-find-largest-number-using-when
---
  - name: simple usage of inline conditional statement ( if else)
    hosts: localhost
    gather_facts: false
    vars:
      x: 15
      y: 9
    tasks:
      - debug:
          msg: "The larger number of {{x}} and {{y}} is: {{x}}"
        when: x > y
      - debug:
          msg: "The large number of {{x}} and {{y}} is: {{y}}"
        when: y > x

#OUTPUT
ok: [localhost] => {
    "msg": "The larger number of 15 and 9 is: 15"
}

#Document-usage-of-inline-conditional-statement
---
  - name: simple usage of inline conditional statement ( if else)
    hosts: localhost
    gather_facts: false
    vars:
      x: 155
      y: 19
      larger: "{{ x if ( x > y) else (y)}}"
    tasks:
      - debug:
          msg: "The larger number of {{x}} and {{y}} is: {{larger}}"

#OUTPUT
ok: [localhost] => {
    "msg": "The larger number of 155 and 19 is: 155"
}


#Data Structures/ Data Collections
#List
---
 - hosts: localhost
   vars:
    x: 34
    pakgs1: ['vim','nano','httpd','nginx']
   tasks:
   - debug: var=pakgs1

k: [localhost] => {
    "pakgs1": [
        "vim",
        "nano",
        "httpd",
        "nginx"
    ]
}

#List
---
 - hosts: localhost
   vars:
    x: 34
    pakgs2:
    - 'vim'
    - 'nano'
    - 'httpd'
    - 'nginx'
   tasks:
   - debug: var=pakgs2

ok: [localhost] => {
    "pakgs2": [
        "vim",
        "nano",
        "httpd",
        "nginx"
    ]
}

#Map
---
 - hosts: localhost
   vars:
    x: 34
    web_servers1: {'Linux': 'httpd', 'ubuntu': 'apache2'}
   tasks:
   - debug: var=web_servers1

ok: [localhost] => {
    "web_servers1": {
        "Linux": "httpd",
        "ubuntu": "apache2"
    }
}

---
 - hosts: localhost
   vars:
    x: 34
    web_servers2:
     'Linux': 'httpd'
     'ubuntu': 'apache2'
   tasks:
   - debug: var=web_servers2

ok: [localhost] => {
    "web_servers2": {
        "Linux": "httpd",
        "ubuntu": "apache2"
    }
}

#Document-filters-and-methods-of-ansible
---
  - hosts: localhost
    gather_facts: false
    vars:
      x: "ThiS IS abOut Ansible FilTERS AND mETHODS"
      y: "56"
      z: [4,5,6,38,0]

    tasks:
      - debug:
          msg:
            - "{{x|lower}}"
            - "{{x|upper}}"
            - "{{x|title}}"
            - "{{x.lower()}}"
            - "{{x.upper()}}"
            - "{{y|int}}"
            - "The max from z is: {{z|max}}"
            - "THe min from z is: {{z|min}}"
            - "{{x.split()}}"

#RESULT
ok: [localhost] => {
    "msg": [
        "this is about ansible filters and methods",
        "THIS IS ABOUT ANSIBLE FILTERS AND METHODS",
        "This Is About Ansible Filters And Methods",
        "this is about ansible filters and methods",
        "THIS IS ABOUT ANSIBLE FILTERS AND METHODS",
        "56",
        "The max from z is: 38",
        "THe min from z is: 0",
        [
            "ThiS",
            "IS",
            "abOut",
            "Ansible",
            "FilTERS",
            "AND",
            "mETHODS"
        ]
    ]
}


#Working with command line arguments
---
 - hosts: localhost
   vars:
    x: 45
    my_name: "Narendra"
   vars_prompt:
    - name: user_name
      prompt: Enter your user name 
      private: no #Do not display the value in the cli
    - name: password
      prompt: Enter your password 
      private: yes
   gather_facts: false
   tasks:
   - debug:
      msg: "The username is: {{user_name}} and password is: {{password}}" 

ok: [localhost] => {
    "msg": "The username is: tia and password is: 12345"
}

#Document-finding-os-distribution-and-os-name-with-gatherfacts
---
 - hosts: all
   tasks:
   - debug:  
      msg:
       - "The os distribution is: {{ansible_distribution}}"
       - "THe os name is: {{ansible_system}}"
       - "The os family is: {{ansible_os_family}}"
       - "THe mount points are :{{ansible_mounts}}"

#RESULT
ok: [localhost] => {
    "msg": [
        "The os distribution is: Ubuntu",
        "THe os name is: Linux",
        "The os family is: Debian",

```

```yml
#Document-with-out-facts
 - name: Finding os distribution and os name 
   hosts: all
   gather_facts: false
   tasks:
   - name: FInding os distribution
     shell: "cat /etc/os-release  | awk -F =  'NR==1 {print $2 }' | awk '{print $1}' | tr '\"' ' '"
     register: os_dist #store the output of the command
   - name: Finding os name
     shell: "uname"
     register: os_name #store the output of the command
   - debug:
      msg:
       - "The os distribution name is: {{os_dist.stdout}}"
       - "THe os name: {{os_name.stdout}}"

#RESULT
ok: [localhost] => {
    "msg": [
        "The os distribution name is:  Ubuntu ",
        "THe os name: Linux"
    ]
}


#Error Handling part
---
  - hosts: localhost
    gather_facts: fasle
    tasks:
      - command: "ls /home"
        register: home_out
      - debug: var=home_out
      - command: "ls /tmp"
        register: tmp_out
      - debug: var=tmp_out

---
  - hosts: localhost
    gather_facts: fasle
    tasks:
      - command: "ls /homeghghfdhrfg"
        register: home_out #the playbook will run because we ignore the error
        ignore_errors: yes
      - debug: var=home_out
      - command: "ls /tmp"
        register: tmp_out
      - debug: var=tmp_out

---
  - hosts: localhost
    gather_facts: fasle
    become: yes
    tasks:
      - name: starting nginx
        service:
          name: nginx
          state: started
        ignore_errors: yes
      - name: starting httpd
        service:
          name: httpd
          state: started

---
  - hosts: localhost
    gather_facts: false
    tasks:
    #  - command: "ls /home"
    #    register: out
    #    failed_when: out.rc==0
    #  - debug: var=out
      - command: "ls /home"
        register: out
      - fail:
          msg: "Failed because rc is 0"
        when: out.rc==0

#Ansible block and rescue for error handling with examples
---
 - name: Ansible Blocks
   hosts: server1
   gather_facts: false

   tasks:
     - name: List usr directory content
       command: "ls -l /usr/"
       become: yes

     - name: List root partition content
       command: "ls -l /root/"
       become: yes

     - name: List ansible user's home directory content
       command: "ls -l ~/"

     - name: List bin diretcory content
       command: "ls -l /bin/"
       become: yes

---
 - name: Ansible Blocks
   hosts: server1
   gather_facts: false

   tasks:
     - block:
        - name: List usr directory content
          command: "ls -l /usr/"

        - name: List root partition content
          command: "ls -l /root/"

        - name: List bin directory content
          command: "ls -l /bin/"
       become: yes

     - name: List ansible user's home directory content
       command: "ls -l ~/"

---
 - name: Ansible Blocks
   hosts: localhost
   gather_facts: false

   tasks:
     - block:
        - name: List home directory content
          command: "ls -l ~/"

        - name: Failing intentionally
          command: "ls -l /tmp/does-not-exist"
       

       rescue:
        - name: Rescue block (perform recovery)
          debug:
            msg: "Something went wrong, cleaning up.."
       ignore_errors: yes

       always:
        - name: This will execute always
          debug:
            msg: "I will execute even in failure scenario"