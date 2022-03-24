

```yml
---
- name: Touch delete.sh file
  shell: |
    touch /home/deploy/delete_logs.sh
    touch /home/deploy/delete_config.sh
    chmod 0755 /home/deploy/delete_logs.sh /home/deploy/delete_config.sh
  become: yes
  become_user: root
- name: Delete old logs  except the last 06 logs
  blockinfile:
    path: /home/deploy/delete_logs.sh
    block: |
      #! /bin/zsh
      ENV=$(hostname | awk -F"." '{print$2}')
      ls -ltr /home/deploy/ | grep -i ${ENV}_20 | awk '{print $NF}' > /home/deploy/logs.txt
      head -n-6  /home/deploy/logs.txt > /home/deploy/logs_del.txt
      for i in $(cat /home/deploy/logs_del.txt)
      do
      rm -rf /home/deploy/$i
      done
  become: yes
  become_user: root
- name: Run delete_logs.sh  script
  raw: /home/deploy/delete_logs.sh
  become: yes
  become_user: root
- name: remove  files
  shell: |
    rm -rf  /home/deploy/logs.txt
    rm -rf /home/deploy/logs_del.txt
    rm -rf  /home/deploy/delete_logs.sh
  become: yes
  become_user: root
- name: Delete old configs  except the last 06 logs
  blockinfile:
    path: /home/deploy/delete_config.sh
    block: |
      #! /bin/bash
      ls -ltr  /home/deploy/ | grep -i autoupgrade-zedcloud | awk '{print $NF}' > /home/deploy/configs.txt
      head -n-6 /home/deploy/configs.txt  > /home/deploy/configs_del.txt
      for j in $(cat /home/deploy/configs_del.txt)
      do
      rm -rf /home/deploy/$j
      done
  become: yes
  become_user: root
- name: Run delete_config.sh script
  raw: /home/deploy/delete_config.sh
  become: yes
  become_user: root
- name: remove  files
  shell: |
    rm -rf  /home/deploy/configs.txt
    rm -rf /home/deploy/configs_del.txt
    rm -rf  /home/deploy/delete_config.sh
  become: yes
  become_user: root



---
- name: Checking all VM type
  command: uname -a
  register: uname
  changed_when: uname.rc != 0
- name: Gather the package facts
  package_facts:
    manager: auto
  when:
    - '"azure" in uname.stdout'
- name: Create temporary directory
  tempfile:
    state: directory
  register: tempdir
  when:
    - '"azure" in uname.stdout'
    - '"mdatp" not in ansible_facts.packages'
- name: Download Azure defender
  get_url:
    url: "https://packages.microsoft.com/config/ubuntu/18.04/prod.list"
    dest: "{{ tempdir.path }}/microsoft.list"
    mode: '0755'
  when:
    - '"azure" in uname.stdout'
    - '"tempdir" is defined'
    - '"mdatp" not in ansible_facts.packages'
- name: Add Microsoft APT key
  apt_key:
    url: https://packages.microsoft.com/keys/microsoft.asc
    state: present
  when:
    - '"azure" in uname.stdout'
    - '"mdatp" not in ansible_facts.packages'
- name: Add Microsoft apt repository for MDATP Azure
  apt_repository:
    repo: deb [arch=amd64] https://packages.microsoft.com/ubuntu/18.04/prod bionic main  # yamllint disable-line rule:line-length
    update_cache: true
    state: present
    filename: /etc/apt/sources.list.d/microsoft-prod.list
  when:
    - '"azure" in uname.stdout'
    - '"mdatp" not in ansible_facts.packages'
- name: install packages
  apt:
    name:
      - mdatp
      - apt-transport-https
    state: present
  when:
    - '"azure" in uname.stdout'
    - '"mdatp" not in ansible_facts.packages'
- name: Delete content & directory
  file:
    state: absent
    path: "{{ tempdir.path }}/microsoft.list"
  when:
    - '"azure" in uname.stdout'
    - '"tempdir" is defined'
    - '"mdatp" not in ansible_facts.packages'
- name: Start Azure defender
  service:
    name: mdatp
    state: started
  when:
    - '"azure" in uname.stdout'
    - '"mdatp" not in ansible_facts.packages'




---
- name: Checking all VM type
  command: uname -a
  register: uname
  changed_when: uname.rc != 0
- name: Gather the package facts
  package_facts:
    manager: auto
  when:
    - '"aws" in uname.stdout'
- name: Create temporary directory
  tempfile:
    state: directory
  register: tempdir
  when:
    - '"aws" in uname.stdout'
    - "'awsagent' not in ansible_facts.packages"
- name: Download aws-agent
  get_url:
    url: "https://inspector-agent.amazonaws.com/linux/latest/install"
    dest: "{{ tempdir.path }}/install.sh"
    mode: '0755'
  when:
    - '"aws" in uname.stdout'
    - '"tempdir" is defined'
    - "'awsagent' not in ansible_facts.packages"
- name: Run aws-agent installation script
  raw: "{{ tempdir.path }}/install.sh"
  when:
    - '"aws" in uname.stdout'
    - '"tempdir" is defined'
    - "'awsagent' not in ansible_facts.packages"
- name: Delete content & directory
  file:
    state: absent
    path: "{{ tempdir.path }}/install.sh"
  when:
    - '"aws" in uname.stdout'
    - '"tempdir" is defined'
    - "'awsagent' not in ansible_facts.packages"
- name: Start aws-agent
  service:
    name: awsagent
    state: started
  when: '"aws" in uname.stdout'
