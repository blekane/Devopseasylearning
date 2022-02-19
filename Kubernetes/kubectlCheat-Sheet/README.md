### References
- **kubectl Cheat Sheet:** https://kubernetes.io/docs/reference/kubectl/cheatsheet/

https://kubernetes.io/docs/reference/kubectl/cheatsheet/

### Check if the scheduller is installed
- This command will inspect the Kubernetes control plane environment installed on the system (etcd-master, sheduller, kube-proxy, kube-controller-manager-master, kube-apiserver-master and on)
```
kubectl -n kube-system get pods
```

### To do a pause, you need to put a taint on the node.
```
kubectl taint nodes <node name> key=value1:NoSchedule
```

### To unpause the node in question, you need to remove the taint previously set.
```
kubectl taint nodes <node name> key:NoSchedule-
```
### Drain a node. If you don't want to touch daemonsets you will need this option --ignore-daemonsets.
- **Note:** This will migrate all kubernetes workload from the node. The pods present on the node will be rescheduled to other worker nodes.
```
kubectl drain <node name> --ignore-daemonsets
kubectl drain node01 --ignore-daemonsets
```

### To undo the kubectl drain, you'll need to use the command kubectl uncordon.
```
kubectl uncordon <node name>
kubectl uncordon node01
```

### Taint a node
```
kubectl taint nodes <node name> key=value:taint-effect
kubectl taint nodes node01 key=blue:NoSchedule
```

### To remove the taint on the node
```
kubectl taint nodes <node name> key:effect-
kubectl taint nodes node01 key:NoSchedule-
```

### Command to check the taint on kubernetes master
- A taint is set by default on kubernetes master so that the scheduler can not schedule pod on the master node
```
kubectl describe node <master node name> | grep -i taint
kubectl describe node controlplane | grep -i taint
Or
kubectl describe node $(hostname) | grep -i taint
```

### Add taint on kubernetes master node if it was removed
```
kubectl taint nodes <master note name> key=blue:NoSchedule
kubectl taint nodes controlplane key=blue:NoSchedule
OR
kubectl taint nodes $(hostname) key=blue:NoSchedule

# To remove the taint
kubectl taint nodes $(hostname) key=blue:NoSchedule-
```

### Set label on node01
```
kubectl label nodes node01 color=blue
# To check
kubectl get node node01 --show-labels
```

### Select pod base on label
```
kubectl get po --selector app=web-server
OR
kubectl get po --selector function=front-end
```

### Show pods label
```
kubectl get pod --show-labels
kubectl get po --show-labels -l bu=finance --no-headers |wc -l
```

### Show service label
```
kubectl get svc --show-labels
```

### Show replicaset label
```
kubectl get rs --show-labels
```

### Show deployment label
```
kubectl get deploy --show-labels
```


### Show all labels
```
kubectl get all --show-labels |less
```











### List all the node
```
kubectl get nodes
```


### Create a Pod
```
kubectl run <desired-pod-name> --image <Container-Image> --generator=run-pod/v1
kubectl run my-first-pod --image stacksimplify/kubenginx:1.0.0 --generator=run-pod/v1
kubectl run my-first-pod --image leonardtia/devops-pro-repos:contactform
kubectl run my-first-pod --image stacksimplify/kubenginx:1.0.0
```

### List pod
```
kubectl get pods
kubectl get po
kubectl get pods -o wide
```

### Create a pod service and so on
```
kubectl create -f <YAML file name>
kubectl create -f myapp-pod.yml
```

### Update the service file when we modify it
```
kubectl apply -f <YAML file name>
kubectl apply -f myapp-pod.yml
```

### Describle a specific pod 
```
kubectl describe pod <pod name>
kubectl describe pod myapp-pod |less
```


### Describle all running pods
```
kubectl describe pod 
kubectl describe pod |less
```


### Get pod definition YAML output
```
kubectl get pod <pod name or service name> -o yaml
kubectl get pod myapp-pod -o yaml
kubectl get pod myapp-pod -o yaml |less
```


### Edit the YAML file of a pod
```
kubectl edit pod <pod name>
kubectl edit pod myapp-pod
```


### Describe the Pod
```
kubectl describe pod <Pod-Name>
kubectl describe pod myapp-pod
kubectl describe pod myapp-pod |less
```


### Create a NodePort and Expose Pod as a Service
```
kubectl expose pod <Pod-Name>  --type=NodePort --port=80 --name=<Service-Name>
kubectl expose pod myapp-pod  --type=NodePort --port=80 --name=my-first-service
```


### Delete a pod
```
kubectl delete pod <pod name>
kubectl delete pod my-first-pod
```


### Get all Objects in default namespace
```
kubectl get all
```

### Create a service
```
kubectl create -f <service name>
kubectl create -f myapp-pod-nodeport-service.yml
```

### Update the service definition file
```
kubectl apply -f myapp-pod-nodeport-service.yml
```


### Get Service Info
```
kubectl get service
kubectl get svc
```


### Delete Services
```
kubectl delete svc <service name>
OR
kubectl delete service <service name>
kubectl delete svc my-first-service
```

### Delete Pod
```
kubectl delete pod my-first-pod
```


### Get YAML Output of Pod & Service
```
kubectl get service myapp-pod-nodeport-service -o yaml  
kubectl get svc myapp-pod-nodeport-service -o yaml 
kubectl get service myapp-pod-nodeport-service -o yaml |less
```

### Edit the YAML file of a service
```
kubectl edit svc <service name>
kubectl edit svc myapp-pod-nodeport-service
```