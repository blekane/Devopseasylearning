# Kubernetes  - PODs

### Get Worker Nodes Status
- Verify if kubernetes worker nodes are ready. 
```
# Get Worker Node Status
kubectl get nodes

# Get Worker Node Status with wide option
kubectl get nodes -o wide
```

### Create a Pod
- Create a Pod
```
# Template
kubectl run <desired-pod-name> --image <Container-Image>

# Replace Pod Name, Container Image
kubectl run my-first-pod --image leonardtia/devops-test-repo:httpd-17
 
### List Pods
- Get the list of pods
```
# List Pods
```
kubectl get pods
```

# Alias name for pods is po
```
kubectl get po
```

### List Pods with wide option
- List pods with wide option which also provide Node information on which Pod is running
```
kubectl get pods -o wide
```

### What happened in the backgroup when above command is run?
  1. Kubernetes created a pod
  2. Pulled the docker image from docker hub
  3. Created the container in the pod
  4. Started the container present in the pod


### Describe Pod
- Describe the POD, primarily required during troubleshooting. 
- Events shown will be of a great help during troubleshooting. 
```
# To get list of pod names
kubectl get pods

# Describe the Pod
kubectl describe pod <Pod-Name>
kubectl describe pod my-first-pod 
```

### Access Application
- Currently we can access this application only inside worker nodes. 
- To access it externally, we need to create a **NodePort Service**. 
- **Services** is one very very important concept in Kubernetes. 


### Delete Pod
```
# To get list of pod names
kubectl get pods

# Delete Pod
kubectl delete pod <Pod-Name>
kubectl delete pod my-first-pod
```

## Demo - Expose Pod with a Service
- Expose pod with a service (NodePort Service) to access the application externally (from internet)
- We can expose an application running on a set of PODs using different types of Services available in k8s. 
  - ClusterIP
  - NodePort
  - LoadBalancer (for cloud provider like AWS, Azure etc.)
**NodePort Service** 
- To access our application outside of k8s cluster, we can use NodePort service. 
- NodePort Service exposes the Service on each Worker Node's IP at a static port (nothing but NodePort). 
- NodePort Service automatically created when we are using imperative approach or kubectl to create a pod and port range 30000-32767. We do not have any option to declare a specific pod using imperative approach or kubectl.
- We can define a NodePort Service in the manifest file if we are using declarative approach to create a pod.
- NodePort Service will be open on each worker node so that we can access our application on every node in the cluster.



```
# Create  a Pod
kubectl run <desired-pod-name> --image <Container-Image> 
kubectl run my-first-pod --image nginx
kubectl run my-first-pod --image leonardtia/devops-test-repo:httpd-17

# Expose Pod as a Service
kubectl expose pod <Pod-Name>  --type=NodePort --port=80 --name=<Service-Name>
kubectl expose pod my-first-pod  --type=NodePort --port=80 --name=my-first-service

# Get Service Info
kubectl get service
kubectl get svc

# Get Public IP of Worker Nodes
kubectl get nodes -o wide
```
- **Access the Application using Public IP**
```
http://<node1-public-ip>:<Node-Port>
```

- **Important Note about: target-port**
- The target-port is the port expose in the container
- 
  - 80 for http or Apche and nginx
  - 8080 for tomcat

```
# Below command will fail when accessing the application, as service port (81) and container port (80) are different. If we want to change the service port, we most specify the target port which is the port running inside the container.
kubectl expose pod my-first-pod  --type=NodePort --port=81 --name=my-first-service2     

# Expose Pod as a Service with Container Port (--target-port)
kubectl expose pod my-first-pod  --type=NodePort --port=81 --target-port=80 --name=my-first-service3
kubectl expose pod my-first-pod  --type=NodePort --port=8090 --target-port=8080 --name=my-first-service3

# Get Service Info
kubectl get service
kubectl get svc

# Get Public IP of Worker Nodes
kubectl get nodes -o wide
```
- **Access the Application using Public IP**
```
http://<node1-public-ip>:<Node-Port>
http://<node1-public-ip>:<Node-Port>/addressbook

http://<node1-public-ip>:35489
http://<node1-public-ip>:30075/addressbook
```

## Interact with a Pod

### Verify Pod Logs
```
# Get Pod Name
kubectl get po

# Dump Pod logs
kubectl logs <pod-name>
kubectl logs my-first-pod

# Stream pod logs with -f option and access application to see logs
kubectl logs <pod-name>
kubectl logs -f my-first-pod
```
- **Important Notes**
  - Refer below link and search for **Interacting with running Pods** for additional log options
  - Troubleshooting skills are very important. So please go through all logging options available and master them.
  - **Reference:** https://kubernetes.io/docs/reference/kubectl/cheatsheet/

### Connect to Container in a POD
- **Connect to a Container in POD and execute commands**
```
# Connect to Nginx Container in a POD
kubectl exec -it <pod-name> -- /bin/bash
kubectl exec -it my-first-pod -- /bin/bash

# Execute some commands in Nginx container
ls
cd /usr/share/nginx/html
cat index.html
exit
```

## Get YAML Output of Pod & Service
### Get YAML Output
```
# Get pod definition YAML output
kubectl get pod my-first-pod -o yaml   

# Get service definition YAML output
kubectl get service my-first-service -o yaml   
```

## Clean-Up
```
# Get all Objects in default namespace
kubectl get all

# Delete Services
kubectl delete svc my-first-service
kubectl delete svc my-first-service2
kubectl delete svc my-first-service3

# Delete Pod
kubectl delete pod my-first-pod

# Get all Objects in default namespace
kubectl get all
```