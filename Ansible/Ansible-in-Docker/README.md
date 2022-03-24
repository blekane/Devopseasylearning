## Setup Ansible Environment with Docker
![](/images/ansible-in-docker.JPG)


```Dockerfile
FROM ubuntu:16.04

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:Passw0rd' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
```

```Dockerfile
FROM centos:centos7

RUN yum update -y && yum -y install openssh-server openssh-clients
RUN mkdir /var/run/sshd
RUN echo 'root:Passw0rd' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
```


## Use:
1. Run the container:
```
docker run -d --name [container name] leonardtia/ubuntu-ssh-enabled:latest
```
2. Identify the Internal IP
```
docker inspect [container-id or name]
```
3. SSH
Username: root
Password: Passw0rd
```
ssh <container-ip>
```

## Create a compose for Ansible
```yml
version: "3"
services:
    ansible01:
      container_name: ansible_01_tia
      image: leonardtia/ubuntu-ssh-enabled:latest
      networks:
      - ansible

    ansible02:
      container_name: ansible_02_tia
      image: leonardtia/ubuntu-ssh-enabled:latest
      networks:
      - ansible

    ansible03:
      container_name: ansible_03_tia
      image: leonardtia/ubuntu-ssh-enabled:latest
      networks:
      - ansible

    ansible04:
      container_name: ansible_04_tia
      image: leonardtia/ubuntu-ssh-enabled:latest
      networks:
      - ansible
networks:
    ansible:
      driver: bridge

```

## Install sshpass on Docker host
```
pt-get update -y
apt-get install -y sshpass
```
## Get the IP address of container
docker-compose ps
docker inspect ansible_01_tia |grep IPAddress
docker inspect ansible_02_tia |grep IPAddress
docker inspect ansible_03_tia |grep IPAddress
docker inspect ansible_04_tia |grep IPAddress

172.31.0.3
172.31.0.2
172.31.0.4
172.31.0.5

## Create the inventory file
cat > tia_inventory
```yml
target1 ansible_host=172.18.0.2 ansible_ssh_pass=Passw0rd
target2 ansible_host=172.18.0.3 ansible_ssh_pass=Passw0rd
target3 ansible_host=1172.18.0.4 ansible_ssh_pass=Passw0rd
target4 ansible_host=172.18.0.5 ansible_ssh_pass=Passw0rd
```

ansible target1 -m ping -i tia_inventory

## Issue (Can I bypass host key checking in Ansible?)
```yml
root@DEL-Ubunt:~/tia# ansible target1 -m ping -i tia_inventory
target1 | FAILED! => {
    "msg": "Using a SSH password instead of a key is not possible because Host Key checking is enabled and sshpass does not support this.  Please add this host's fingerprint to your known_hosts file to manage this host."
}
```
1. Can I bypass host key checking in Ansible? [here](https://devops.stackexchange.com/questions/725/can-i-bypass-host-key-checking-in-ansible)
2. This is typically done by setting the following value in `ansible.cfg`:

/etc/ansible/ansible.cfg
```
[defaults]
host_key_checking = False
```