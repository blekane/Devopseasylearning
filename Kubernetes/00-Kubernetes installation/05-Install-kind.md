### What is Kind?
Kind is a tool use to run Kebernets in Docker container.

### What do we need to install Kind
* Golang tool
* Docker tools
* And kubectl


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
kind create cluster --name first-cluster 
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

### Switch between clunster
kind get clusters or kubectx
kubectx [cluster name] 
kubectx my-cluster

### Create a Pod
```
kubectl run my-first-pod --image nginx 
kubectl get po
```

### connect into a node
docker exec -it [node name] bash
docker exec -it kind-worker2 bash

