```yaml
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
       - "THe value of my_num: {{my_num}} and type : {{my_num|type_debug}}"
       - "The value of my_name : {{my_name}} and type: {{my_name|type_debug}}"
       - "THe value of my_b is: {{my_b}} and type : {{my_b|type_debug}}"

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

#Multiple packages installation
---
  - hosts: localhost
    gather_facts: false
    become: yes
    tasks:
      - yum:
         name: gettext-devel
         state: present
      - yum:
         name: openssl-devel
         state: present
      - yum:
         name: perl-CPAN
         state: present
      - yum:
         name: perl-devel
         state: present
      - yum:
         name: zlib-devel
         state: present

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



#1.Document-comparison-operators
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
          - start httpd
    handlers:
      - name: start httpd
        service:
          name: httpd
          state: started


#Document-install-and-configure-tomcat

---
  - name: Install and configure tomcat
    hosts: 54.242.117.70
    gather_facts: false
    vars:
      req_java: java-1.8.0-openjdk
      set_java: jre-1.8.0-openjdk
      req_tomcat_ver: 9.0.26
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
    my_name: Narendra Kumar
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

#Document-block-concept
#block is useful to group multiple tasks and we can apply some opetions like become,ignore_erros and when in block level instead of task level
---
  - hosts: web_servers
    gather_facts: true
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

#Document-error-hanlding-with-block-rescue-always
---
  - hosts: localhost
    gather_facts: false
    tasks:
      - block:
        - name: Finding files in /home/ansadmin/tomcat8
          command: "ls /home/ansadmin/tomcat8"
          register: tomcat8_out
        rescue:
          - debug:
             msg: "The given path: /home/ansadmin/tomcat8 is not a validpath"
        always:
          - debug:
             msg: "THis will always executes"

#Document-install-httpd-apche
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

#Document-data-structures
---
 - hosts: localhost
   vars:
    x: 34
    #pakgs: ['vim','nano','httpd','nginx']
    pakgs:
    - 'vim'
    - 'nano'
    - 'httpd'
    - 'nginx'
    #web_servers: {'Linux': 'httpd', 'ubuntu': 'apache2'}
    web_servers:
     'Linux': 'httpd'
     'ubuntu': 'apache2'
   gather_facts: false
   tasks:
   - debug: var=web_servers.get('Linux')

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


#input-and-outputs-of-ansible
---
 - hosts: localhost
   vars:
    x: 45
    my_name: "Narendra"
   vars_prompt:
    - name: user_name
      prompt: Enter your user name 
      private: no
    - name: password
      prompt: Enter your password 
      private: yes
   gather_facts: false
   tasks:
   - debug:
      msg: "The username is: {{user_name}} and password is: {{password}}" 

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

#Document-with-out-facts
 - name: Finding os distribution and os name 
   hosts: all
   gather_facts: false
   tasks:
   - name: FInding os distribution
     shell: "cat /etc/os-release  | awk -F =  'NR==1 {print $2 }' | awk '{print $1}' | tr '\"' ' '"
     register: os_dist
   - name: Finding os name
     shell: "uname"
     register: os_name
   - debug:
      msg:
       - "The os distribution name is: {{os_dist.stdout}}"
       - "THe os name: {{os_name.stdout}}"

