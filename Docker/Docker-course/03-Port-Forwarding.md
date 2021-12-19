# Port Forwarding in Docker

### What is Port Forwarding in Docker?
- It helps us to access an application running inside a docker container
- When you run a docker container, Your containers will be on one network call private accelety network and docker engine on another network same as you host machine
- The default behavior here is that whatever is running inside the container cannot be access from the host for security concern


### Enable IPv4 forwarding
Port forwarding might be disable on docker host and we need to enable first. Add the below snippy code to `/etc/sysctl.conf`
```
net.ipv4.ip_forward=1
```

**restarted the network service and validated the setting**
```
systemctl restart network
sysctl net.ipv4.ip_forward
```

### Port Forwarding types in Docker
We have 3 types of port forwarding in docker
- Not port forwarding 
- Free port forwarding 
- Binding port forwarding 

**1. Not port forwarding**

The container will not be accessible from outside.
```
docker run -d nginx
```

**2. Free port forwarding**

In this case, docker will automatically assign a random range from  `30000-65535`
```
docker run -d -P nginx
docker run -d -P leonardtia/devops-pro-repos:covid19
```

```
docker ps
http://<ID>:32770/
http://10.0.0.94:32770/
```

**1. Binding port forwarding**

**NB:** To bind a port, the port most  be expose in the docker file
In this case, we can specify a particular port that we want to use.
```
docker run -d -p 8888:80 nginx
docker run -d -p 8889:80 leonardtia/devops-pro-repos:covid19
```

```
docker ps
http://<ID>:8888/
http://10.0.0.94:8889/
```

### What is the difference between -p (lowercase) and  -P (uppercase)?
**-P (uppercase)** will expose the container to a random port
**-p (lowercase)** will expose the container to a specific port


### What is the difference between binding port forwarding and free port forwarding?
*free port forwarding* will expose the container to a random port while *binding port forwarding* will expose the container to a specific port.


### Port Fowarding Example 1
![](/images/Port-Fowarding-Example-1.JPG)

### Port Fowarding Example 2
![](/images/Port-Fowarding-Example-2.JPG)

### Port Fowarding Example 3
![](/images/Port-Fowarding-Example-3.JPG)


