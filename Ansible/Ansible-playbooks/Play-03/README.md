```yml
---
 - hosts: dev
   vars:
     salutations: Hello guys!
   tasks:
   - name: Ansible Variable Basic Usage
     debug:
       msg:  "{{ salutations }}"



---
- hosts: dev
  vars:
    students:
      - Mark
      - Melisa
      - Arthur
      - Kevin
      - Lisa
  tasks:
  - name: Ansible List variable Example
    debug:
      msg: "{{ students[2] }}"
      
      
      
---
- hosts: dev
  vars:
    students:
         - Mark: 
             city: Melbourne
             address: 0045-0987-8642
         - Angela: 
             city: Sydney
             address: 3456-7685-9087
  tasks:
    - debug:
        var: students

# command to run this playbook ansible-playbook test.yml --extra-vars "application_name=tree state=present" 
---
- hosts: dev
  become: yes
  gather_facts: false
  tasks:
    - name: Install application tree
      yum:
        name: "{{ application_name }}"
        state: "{{ state }}"
        

#Running multiple shell commands
- hosts: dev
  become: yes
  gather_facts: false
  tasks:
    - name: copy jenkins war to host machines
      copy:
        src: /home/spovedd/jenkins.war
        dest: /home/jenkins.war
    - name: creating folder structure and running jenkins in the background 
      shell: |
        mkdir -p /home/spovedd/jenkins
        mv /home/jenkins.war /home/spovedd/jenkins
        nohup java -jar /home/spovedd/jenkins/jenkins.war




```yml
- name: Create a data container
  docker_container:
    name: mydata
    image: busybox
    volumes:
      - /data

- name: Re-create a redis container
  docker_container:
    name: myredis
    image: redis
    command: redis-server --appendonly yes
    state: present
    recreate: yes
    exposed_ports:
      - 6379
    volumes_from:
      - mydata

- name: Restart a container
  docker_container:
    name: myapplication
    image: someuser/appimage
    state: started
    restart: yes
    links:
     - "myredis:aliasedredis"
    devices:
     - "/dev/sda:/dev/xvda:rwm"
    ports:
     - "8080:9000"
     - "127.0.0.1:8081:9001/udp"
    env:
        SECRET_KEY: ssssh

- name: Container present
  docker_container:
    name: mycontainer
    state: present
    image: ubuntu:14.04
    command: sleep infinity

- name: Stop a container
  docker_container:
    name: mycontainer
    state: stopped

- name: Start 4 load-balanced containers
  docker_container:
    name: "container{{ item }}"
    recreate: yes
    image: someuser/anotherappimage
    command: sleep 1d
  with_sequence: count=4

- name: remove container
  docker_container:
    name: ohno
    state: absent

- name: Syslogging output
  docker_container:
    name: myservice
    image: busybox
    log_driver: syslog
    log_options:
      syslog-address: tcp://my-syslog-server:514
      syslog-facility: daemon
      # NOTE: in Docker 1.13+ the "syslog-tag" option was renamed to "tag" for
      # older docker installs, use "syslog-tag" instead
      tag: myservice

- name: Create db container and connect to network
  docker_container:
    name: db_test
    image: "postgres:latest"
    networks:
      - name: "{{ docker_network_name }}"

- name: Start container, connect to network and link
  docker_container:
    name: sleeper
    image: ubuntu:14.04
    networks:
      - name: TestingNet
        ipv4_address: "172.1.1.100"
        aliases:
          - sleepyzz
        links:
          - db_test:db
      - name: TestingNet2

- name: Start a container with a command
  docker_container:
    name: sleepy
    image: ubuntu:14.04
    command: ["sleep", "infinity"]

- name: Add container to networks
  docker_container:
    name: sleepy
    networks:
      - name: TestingNet
        ipv4_address: 172.1.1.18
        links:
          - sleeper
      - name: TestingNet2
        ipv4_address: 172.1.10.20

- name: Update network with aliases
  docker_container:
    name: sleepy
    networks:
      - name: TestingNet
        aliases:
          - sleepyz
          - zzzz

- name: Remove container from one network
  docker_container:
    name: sleepy
    networks:
      - name: TestingNet2
    purge_networks: yes

- name: Remove container from all networks
  docker_container:
    name: sleepy
    purge_networks: yes
```