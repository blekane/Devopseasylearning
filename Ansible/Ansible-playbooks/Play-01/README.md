


```yaml
---
- hosts: app
  become: yes
  become_user: root
  become_method: sudo
  tasks:
  - name: Installation of httpd
    yum: name=httpd state=present
 
  - name: Ensure group 'admins' exists
    group: name=admins state=present
 
  - name: Ensure group 'developers' exists
    group: name=developers state=present
 
  - name: Create user tom on the target servers
    user: name=tom comment=jhon group=admins uid=1050
 
  - name: Add the user 'james' with a bash shell, appending the group 'admins' and 'developers' to the user's groups
    user: name=james shell=/bin/bash groups=admins,developers append=yes



---
- name: Transfer and execute a script on myservers.
  hosts: myservers
  user: root
  sudo: yes
  tasks:
     - name: Transfer the script from /etc/ansible
       copy: src=useradd.sh dest=/tmp mode=0777 # 0777 is the permission
 
     - name: Execute the script on the target servers
       command: sh /tmp/useradd.sh
      # the script file test.sh most be in /etc/ansible




---
- hosts: app
  become: yes
  become_user: root
  become_method: sudo
 
  tasks:
  - name: "shut down CentOS 7 systems"
    command: /sbin/shutdown -t now
    when:
      - ansible_facts['distribution'] == "CentOS"
      - ansible_facts['distribution_major_version'] == "7"


---
- hosts: all
  tasks:
  - name: create a file
    file: path=/tmp/file_1 state=touch owner=ansadmin mode='0644'
 
  - name: create a directory
    file: path=/tmp/finance state=directory owner=ansadmin mode='0777'


---
- hosts: all
  tasks:
  - name: remove a file
    file: path=/tmp/file_1 state=absent

# Forcing users to create a password on first login
---
- hosts: all
  become: yes
  become_user: root
  become_method: sudo
 
  tasks:
  - name: Add new user
    user:
     name="{{item}}"
     password=$1$gZ0cD2Vf$HzaKPE4.KvJVZPv9Qdg4A.
     state=present
    with_items:
     - tom
     - john
 
  - name: Expire password for tom
    shell: passwd --expire tom
  - name: Expire password for john
    shell: passwd --expire john


# Forcing users to create a password on first login
---
- hosts: all
  become: yes
  become_user: root
  become_method: sudo
 
  tasks:
  - name: Create a group admin
    group: name=admins state=present
  - name: Create a group developers
    group: name=developers state=present
 
  - name: Add new user
    user:
     name="{{item}}"
     password=$1$gZ0cD2Vf$HzaKPE4.KvJVZPv9Qdg4A.
     state=present
     password_lock=yes
     shell=/bin/nologin
     groups=admins,developers append=yes
    with_items:
     - tom
     - john
 
  - name: Expire password for tom
    shell: passwd --expire tom
  - name: Expire password for john
    shell: passwd --expire john


#Forcing users to create a password on first login
- name: Create user with locked password
  user:
    name: tuvok
    comment: "Tuvok"
 
- name: Unlock password and set it to empty
  command: passwd -d tuvok
 
- name: Expire password
  command: chage -d 0 tuvok


---
- hosts: all
  become: yes
  become_user: root
  become_method: sudo
 
  tasks:
  - name: Create user with locked password
    user:
      name: john
      comment: "john paul"
 
  - name: Unlock password and set it to empty
    command: passwd -d john
 
  - name: Expire password
    command: chage -d 0 john


# Creating users with passwords
- name: Create a user with hashed password
  user:
    name: kjaneway
    comment: "Kathryn Janeway"
    password: $6$RV7f88WJHCuZxb.t$aczWN9g22e4LqoycW687iq4LYMMOZY6ST/ClOCYa165RY56j.L7KLQTLhEDsOIyux4RSfUKRY67iLIXGwHFYO1

#Loop to add several users at the same time
- name: add several users
  user:
    name: "{{ item }}"
    state: present
    groups: "wheel"
  loop:
     - testuser1
     - testuser2

#LOOPS IN ANSIBLE
- name: Install Packages
  apt: name={{ item }} state=latest
  with_items:
     - vim
     - git
     - curl  


---
- hosts: web_servers
  become: true
  tasks:
  - name: Install Package
    yum: name=vim,git state=latest


---
- hosts: web_servers
  become: true
  tasks:
  - name: Create multiple directories
  file: path={{item}} state=directory
  with_items:
  - '/home/ansible/vn1'
  - '/home/ansible/vn2'
  - '/home/ansible/vn3'


#You can also use an array variable to define your items:
---
- hosts: all
  become: true
  vars:
     packages: [ 'vim', 'git', 'curl' ]
  tasks:
     - name: Install Package
       apt: name={{ item }} state=latest
       with_items: "{{ packages }}"

#Ansible: Run multiple commands using command module and with_items
- name: install an apple
    command: "{{item}}"
    with_items:
     - tar -xvzf /tmp/apple.tar.gz creates=/tmp/apple
     - /tmp/apple/install.sh --default creates=/etc/apple
     - rm -rf /tmp/apple

#To update the server
---
- hosts: all
  become: true
  tasks:
     - name: Update apt-cache 
       apt: update_cache=yes



---
- hosts: db
  become: yes
  become_user: root
  become_method: sudo
  tasks:
  - name: Installation of httpd
    yum: name=httpd state=present
 
  - name: Installation of httpd
    service: name=httpd state=started
 
  - name: Ensure group 'admins' exists
    group: name=admins state=present
 
  - name: Ensure group 'developers' exists
    group: name=developers state=present
 
  - name: Create user tom on the target servers
    user: name=tom comment=jhon group=admins uid=1050
 
  - name: Add the user 'james' with a bash shell, appending the group 'admins' and 'developers' to the user's groups
    user: name=james shell=/bin/bash groups=admins,developers append=yes


#!/bin/bash
 
yum -y install git
 
groupadd hr
groupadd manager
 
useradd -u 1059 -G hr john
useradd -s /bin/bash -c "temy paul" -G hr,manager temy


---
- hosts: db
  become: yes
  become_user: root
  become_method: sudo
  tasks:
  - name: Transfer the script from /etc/ansible
    copy: src=useradd.sh dest=/tmp mode=0777 # 0777 is the permission
 
  - name: Execute the script on the target servers
    command: sh /tmp/useradd.sh
      # the script file test.sh most be in /etc/ansible


---
- hosts: db
  become: yes
  become_user: root
  become_method: sudo
 
  tasks:
  - name: "install git"
    yum: name=git state=present
    
    when: (ansible_facts['distribution'] == "CentOS" and ansible_facts['distribution_major_version'] == "6") or
          (ansible_facts['distribution'] == "CentOS" and ansible_facts['distribution_major_version'] == "7")
 
tasks:
  - name: "shut down Debian flavored systems"
    command: /sbin/shutdown -t now
    when: ansible_facts['os_family'] == "Debian
 
 
---
- name: Remove Git and tree
  hosts: all
  tasks:
    - name: Remove Git and tree CentOS  Server
      yum: name=git,tree  state=absent
      become: yes
      when: ansible_os_family == "RedHat"
 
    - name: Remove Git and tree Ubuntu Server
      apt: name=git,tree state=absent
      become: yes
      when: ansible_os_family == "Debian"

---
- hosts: db
  become: yes
  become_user: root
  become_method: sudo
 
  tasks:
  - name: "install git"
    yum: name=git state=absent
    
    when: (ansible_facts['distribution'] == "CentOS" and ansible_facts['distribution_major_version'] == "6") 


---
- name: install Git and tree
  hosts: all
  tasks:
    - name: Install Git and tree CentOS  Server
      yum: name=git,tree  state=present
      become: yes
      when: ansible_distribution == "CentOS" and ansible_distribution_major_version < '7' or ansible_distribution == "CentOS" and ansible_distribution_major_version >= '7'
 
    - name: Install Git and tree Ubuntu Server
      apt: name=git,tree state=present
      become: yes
      when: ansible_distribution == "Ubuntu" and ansible_distribution_major_version >= '18'

---
- hosts: db
  become: yes
  become_user: root
  become_method: sudo
 
  tasks:
  - name: Add new user
    user:
     name="{{item}}"
     password=$1$gZ0cD2Vf$HzaKPE4.KvJVZPv9Qdg4A.
     state=present
    with_items:
     - tom
     - john
     - emeric
     - paul
 
  - name: Expire password for tom
    shell: passwd --expire tom
  - name: Expire password for john
    shell: passwd --expire john
  - name: Expire password for emeric
    shell: passwd --expire emeric
  - name: Expire password for paul
    shell: passwd --expire paul

- name: add several users
  user:
    name: "{{ item }}"
    state: present
    groups: "wheel"
  loop:
     - testuser1
     - testuser2
 
- name: Install Packages
  apt: name={{ item }} state=latest
  with_items:
     - vim
     - git
     - curl 
     - tree
 
---
- hosts: web_servers
  become: true
  tasks:
  - name: Install Package
    yum: name=vim,git state=latest
 
---
- hosts: web_servers
  become: true
  tasks:
  - name: Create multiple directories
  file: path={{item}} state=directory
  with_items:
  - '/home/ansible/vn1'
  - '/home/ansible/vn2'
  - '/home/ansible/vn3'
 
 
---
- hosts: all
  become: true
  tasks:
     - name: Update apt-cache 
       apt: update_cache=yes
 
---
- hosts: all
  become: true
  tasks:
     - name: Update apt-cache 
       yum: update_cache=yes



---
- hosts: localhost
  tasks:
  - name: create docker image and push it to dockerhub
    command: "{{item}}"
    with_items:
     - docker build -t web-app:1.0 /home/ansadmin/artifact
     - docker tag web-app:1.0 leonardtia/web-app:1.0
     - docker push leonardtia/web-app:1.0
     - docker rmi -f leonardtia/web-app:1.0
     - docker rmi -f web-app:1.0
     - docker rmi -f tomcat:latest
 
OR
 
---
- hosts: localhost
  tasks:
  - name: creating docker image
    command: docker build -t web-app:1.0 /home/ansadmin/artifact
 
  - name: tagging the image
    command: docker tag web-app:1.0 leonardtia/web-app:1.0
 
  - name: pushing the image to docker hub
    command: docker push leonardtia/web-app:1.0
 
  - name: removing the tag image from ansible host
    command: docker rmi -f leonardtia/web-app:1.0
 
  - name: removing web-app image from ansible host
    command: docker rmi -f web-app:1.0
 
  - name: removing the base image tomcat from ansible host
    command: docker rmi -f tomcat:latest
 


From tomcat
Maintainer Tia
ADD https://linux-devops-course.s3.amazonaws.com/warfiles/pebble.war /usr/local/tomcat/webapps
CMD "catalina.sh" "run"
EXPOSE 8080


# install Tomcat
---
- hosts: all
  become: true
  become_user: root
  tasks:
  - name: Install tomcat
    yum: name=tomcat state=present
  - name: Start tomcat
    service: name=tomcat state=started
  - name: Deploy war file
    get_url: url=https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war dest=/usr/share/tomcat/webapps
    notify: restart tomcat
  handlers:
  - name: restart tomcat
    service: name=tomcat state=restarted


#Playbook without variable on CentOs
---
- hosts: all
  become: true
  become_user: root
  tasks:
  - name: Install httpd
    yum: name=httpd state=present
 
  - name: Deploy index.html file
    copy: src=/home/ansadmin/index.html  dest=/var/www/html
    notify: restart httpd
  handlers:
  - name: restart httpd
    service: name=httpd state=started

#Playbook with variable
---
- hosts: all
  become: true
  become_user: root
  vars:
   src_path: /home/ansadmin
   dest_path: /var/www/html
  tasks:
  - name: Install httpd
    yum: name=httpd state=present
 
  - name : Deploy index.html file
    copy: src={{src_path}}/index.html  dest={{dest_path}}
    notify: restart httpd
  handlers:
  - name: restart httpd
    service: name=httpd state=started

#Playbook with variables
---
- hosts: all
  become: true
  become_user: root
  vars:
   src_path: /home/ansadmin
   dest_path: /var/www/html
  tasks:
  - name: Install httpd
    yum: name=httpd state=present
 
  - name : Deploy index1.html file
    copy: src={{src_path}}/index1.html  dest={{dest_path}}
  - name : Deploy index2.html file
    copy: src={{src_path}}/index2.html  dest={{dest_path}}
  - name : Deploy index3.html file
    copy: src={{src_path}}/index3.html  dest={{dest_path}}
    notify: restart httpd
  handlers:
  - name: restart httpd
    service: name=httpd state=started

#To install httpd on Ubuntu and RHEL using when statement.
---
- hosts: all
  become: true
  become_user: root
  tasks:
  - name: Update apt-get repo and cache
    apt: update_cache=yes
    when: ansible_distribution == "Debian" 
  - name: Install Apache2
    apt: name=apache2 state=latest
    when: ansible_distribution == "Debian"
    notify: restart apache2
    when: ansible_distribution == "Debian"
  
  - name: Install httpd
    yum: name=httpd state=present
    when: ansible_os_family == "RedHat"
    notify: restart httpd
    when: ansible_os_family == "RedHat"
 
  - name: Deploy index.html file
    copy:
      content: "This is to test httpd from CentOs server"
      dest: /var/www/html/index.html
    when: ansible_os_family == "RedHat"
    notify: restart httpd
    when: ansible_os_family == "RedHat"
 
  - name: Deploy index.html file
    copy:
      content: "This is to test Apache2 from Ubuntu server"
      dest: /var/www/html/index.html
    when: ansible_distribution == "Debian"
    notify: restart apache2
 
  handlers:
  - name: restart apache2
    service: name=apache2 state=restarted
    when: ansible_distribution == "Debian"
 
  - name: restart httpd
    service: name=httpd state=started
    when: ansible_os_family == "RedHat"


#To remove httpd
---
- hosts: all
  become: true
  become_user: root
  tasks:
  - name: Remove Apache2
    apt: name=apache2 state=absent
    when: ansible_distribution == "Debian"
 
  - name: Remove httpd
    yum: name=httpd state=absent
    when: ansible_os_family == "RedHat"

#To install httpd on Ubuntu and RHEL using block.
- hosts: all
  become: true
  become_user: root
  tasks:
    - block:
      - name: Update apt-get repo and cache
        apt: update_cache=yes 
      - name: Install Apache2
        apt: name=apache2 state=latest
        notify: restart apache2
      
      - name: Deploy index.html file
        copy:
          content: "This is the test Apache2 from Ubuntu or Debian server"
          dest: /var/www/html/index.html
        notify: restart apache2
      when: ansible_distribution == "Debian"
 
    - block:      
      - name: Install httpd
        yum: name=httpd state=present
        notify: restart httpd
      - name: Deploy index.html file
        copy:
          content: "This is the test httpd from CentOs or RHEL server"
          dest: /var/www/html/index.html
        notify: restart httpd
      when: ansible_os_family == "RedHat"
 
  handlers:
  - name: restart apache2
    service: name=apache2 state=restarted
    when: ansible_distribution == "Debian"
 
  - name: restart httpd
    service: name=httpd state=restarted
    when: ansible_os_family == "RedHat"

```

## Variables
```yml
- hosts: all
  vars:
    greeting: Hello world! 

  tasks:
  - name: Ansible Basic Variable Example
    debug:
      msg: "{{ greeting }}"


- hosts: all
  vars:
    continents:
      - Africa
      - Asia
      - South America
      - North America
      - Europe
      
  tasks:
  - name: Ansible List variable Example
    debug:
      msg: "{{ continents [1] }}"


- hosts: all
  vars:
    continents: [Africa, Asia, South America, North America, Europe]

  tasks:
  - name: Ansible array variables example
    debug: 
      msg: "{{ item }}"
    with_items:
      - "{{ continents }}"



hosts: switch_f01

vars:
   http_port: 8080
   default_gateway: 
   vlans:
      id: 10
      port: 20

 tasks:
   name: Configure default gateway
   system_configs:
   default_gateway_ip: “{{ default_gateway  }}“


   name: Label port on vlan 10
   vlan_config:
	vlan_id: “{{ vlans[‘id’]  }}“
     port_id: 1/1/ {{ vlans[‘port’]  }}


---
- hosts: all
  vars:
    - username: sammy
    - home: /home/sammy
  tasks:
    - name: print variables
      debug:
        msg: "Username: {{ username }}, Home dir: {{ home }}"
```