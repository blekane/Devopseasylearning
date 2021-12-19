### How to install docker on ubuntu
```
sudo apt-get update
apt-get remove docker docker-engine docker.io
apt install docker.io
systemctl start docker
systemctl enable docker
docker --version
```

```
install docker
sudo apt-get update && \
    sudo apt-get install docker.io -y
```

### Docker Installation on Centos 7
```sh
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

# this will download the script package to install docker
curl -fsSL https://get.docker.com -o get-docker.sh
# this will install the package
sudo sh get-docker.sh

sudo systemctl enable docker
sudo systemctl start docker
sudo docker run hello-world
sudo docker run docker/whalesay cowsay hello-world!
```

OR

```
yum install docker-ce
```

OR

```
yum install -y device-mapper-persistent-data lvm2 device-mapper yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce
systemctl start docker
systemctl enable docker
```

### Docker Installation on AWS Ubuntu Instance
```
sudo su -
Or
sudo -i
apt-get update
apt-get install docker.io
```

### Docker Installation on AWS CentOs EC2 Instance
```
sudo su -
Or
sudo -i
```
```
yum -y update
yum -y install docker
```

**To start the service**
```
service docker start
Or 
systemctl start docker.service
```
**To check the version**
```
docker --version 
```
