### What is Kind?
Kind is a tool use to run Kebernets in Docker container.

### What do we need to install Kind
* Golang tool
* Docker tools
* And kubectl

### Installing kubectl
```sh
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.9/2020-08-04/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv kubectl /usr/local/bin/
kubectl
```
**Ubuntu**
```sh
apt  install curl -y
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.9/2020-08-04/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv kubectl /usr/local/bin/
kubectl
```
### Docker installation
```sh
#! /bin/bash

# Uninstall old versions

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

**Ubuntu**
```sh
sudo apt-get update && \
    sudo apt-get install docker.io -y
```

### Golang tool installation
* [Download golang](https://golang.org/dl/)
```sh
wget https://golang.org/dl/go1.15.7.linux-amd64.tar.gz
tar -xvzf go1.15.7.linux-amd64.tar.gz -C /usr/local
cd /usr/local/go/bin/
echo 'export PATH=$PATH:/usr/local/go/bin' >> /etc/profile # or vim /etc/profile and paste
source /etc/profile
go version
```

### Install Kind
* [Kind setup Github page](https://github.com/kubernetes-sigs/kind)
```
GO111MODULE="on" go get sigs.k8s.io/kind@v0.9.0
find / -name kind
cd /root/go/bin/
cp kind /usr/local/bin/kind
kind version
```

### Create a one node cluster
```
kind create cluster --name valero 
```

### Create a one node cluster k8 v1.19.1
```
kind create cluster --name velero --image kindest/node:v1.19.1
```

### Create cluster using conifig file with kind
* [Create cluster with kind](https://kind.sigs.k8s.io/docs/user/quick-start)
```yml
# a cluster with 1 control-plane nodes and 2 workers
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
- role: worker
```

```yml
# a cluster with 3 control-plane nodes and 3 workers
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: control-plane
- role: control-plane
- role: worker
- role: worker
- role: worker
```

### Create a cluster
* This will create one node cluster with the default name `kind` if --name is not provide
```
kind create cluster
```

* This will create one node cluster kind-2
```
kind create cluster --name kind-2
```

* This will create a default cluster call kind if the cluster name is not specify using the conifig file
```
kind create cluster --config [conifig file].yml 
kind create cluster --config kind.yml
```

* This will create cluster call my-cluster
```
kind create cluster --name my-cluster --config [conifig file].yml
kind create cluster --name my-cluster --config kind.yml
``` 

### check cluster
```
kind get clusters 
kubectl get no
```

### Delete a cluster
```
kind delete cluster --name [cluster name]
kind delete cluster --name my-cluster
```

* This will delete the default cluster call kind
```
kind delete cluster 
```

### Install kubens on CentOs
* [links](https://github.com/ahmetb/kubectx/releases)
```
wget https://github.com/ahmetb/kubectx/releases/download/v0.9.1/kubens_v0.9.1_linux_x86_64.tar.gz
tar -zxvf kubens_v0.9.1_linux_x86_64.tar.gz
mv kubens /usr/local/bin/
kubens
```

### Install kubectx on CentOs
* [link](https://centos.pkgs.org/7/harbottle-main-x86_64/kubectx-0.6.3-1.el7.harbottle.x86_64.rpm.html)
```
wget https://harbottle.gitlab.io/harbottle-main/7/x86_64/harbottle-main-release.rpm
rpm -Uvh harbottle-main-release.rpm
yum install kubectx -y
kubectx
```

**kubectx and kubens on Ubuntu**
```sh
wget https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx
wget https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens
chmod +x kubectx kubens
sudo mv kubens kubectx /usr/local/bin

kubectx --help
kubens --help

### Switch between clunster
kind get clusters or kubectx
kubectx [cluster name] 
kubectx my-cluster

### Create a Pod
```
kubectl run my-first-pod --image stacksimplify/kubenginx:1.0.0 --generator=run-pod/v1
kubectl get po
```

### Expose Pod as a Service
```
kubectl expose pod my-first-pod  --type=NodePort --port=80 --name=my-first-service
kubectl get svc
```

### connect into a node
docker exec -it [node name] bash
docker exec -it kind-worker2 bash

