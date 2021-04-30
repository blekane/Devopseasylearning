### 4 top level  items in K8 manifest file
```yaml
apiVersion: 
kind: 
metadata:
spec:
```  
### Types of Kubernetes Objects
- Pod 
- ReplicaSet
- Deployment 
- Service and many more

# Required Fields
In the .yaml file for the Kubernetes object you want to create, you'll need to set values for the following fields:
- **apiVersion**: Which version of the Kubernetes API you're using to create this object
- **kind**: What kind of object you want to create (Pod, ReplicaSet, Deployment, Service etc.)
- **metadata**: Data that helps identify the object, including a name string, UID, and optional namespace
- **spec**: What state you desire for the object

### apiVersion  REF
- [Service API Reference](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.18/#service-v1-core)



### Pod declare manifest file template
**NB:** This is just for testing. It recommend to create the deployment. We do not create a pod in the real world. We jut create a deployment and the service because the deployment will automatically the pod.

```yaml
apiVersion: v1 # K8 API version
kind: Pod  # Type of object that you want to create K8
metadata: 
  name: myapp-pod # the name of the port
  labels: # to filter objects (We can define multiple value key pair) 
    app: myapp # to filter our application in the future   
    tier: front-end # application tier type (front end, backend etc.)    
spec:
  containers: 
    - name: myapp # the name  of the container
      image: nginx # Image name to pull from the registry
      ports:
        - containerPort: 80 # the port inside the container
```

## Pod declaration manifest file will one container
-  **Create a file:** cat > myapp-pod.yml (ctrl+d to save)
```yml
```yaml
apiVersion: v1
kind: Pod 
metadata:
  name: myapp-pod 
  labels: 
    app: myapp   
    tier: front-end     
spec:
  containers: 
    - name: myapp 
      image: nginx
      ports:
        - containerPort: 80 
```

### Pod declare manifest file will multiple containers
-  **Create a file:** cat > myapp-pod.yml (ctrl+d to save)

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-app-pod
  labels:
    app: my-app
    type: front-end
spec:
  containers:
    - name: nginx-container
      image: nginx
      ports:
        - containerPort: 80
    - name: my-web-app
      image: leonardtia/devops-pro-repos:contactform
      ports:
        - containerPort: 8080
```
### Service declaration manifest file template
```yaml
apiVersion: v1 # Type of object that you want to create K8
kind: Service # Type of object that you want to create K8
metadata:
  name: myapp-pod-nodeport-service # the name of the service
  labels:
    app: front-end
spec:
  type: NodePort # or LoadBalancer # ExternalName # ClusterIp
  selector: # to define where to send the traffic
    app: myapp # to send  the traffic only to pods that matches this label defined in the pod definition file
  ports: 
    - name: http
      port: 80 # Service Port (When you create a service, it create a service port same as Container Port)
      targetPort: 80 # Container Port
      nodePort: 31231 # NodePort to access our app from the browser 
      # The default node port range for Kubernetes is 30000 - 32767
      # if we don't specify it, K8 will choose a random port from 30000 - 32767
```
- **Access the Application using Public IP**
```
http://<node1-public-ip>:<Node-Port>
http://<node1-public-ip>:31231
http://<node1-public-ip>:31231/addressbook
```

### Service declaration manifest file
-  **Create a file:** cat > myapp-pod-nodeport-service.yml (ctrl+d to save)

```yaml
apiVersion: v1
kind: Service
metadata:
  name: myapp-pod-nodeport-service 
  labels:
    app: front-end
spec:
  type: NodePort 
  selector: 
    app: myapp
  ports: 
    - name: http
      port: 80 
      targetPort: 80 # This port most be open on the SG in AWS
      nodePort: 31231  
```

```yaml
apiVersion: v1
kind: Service
metadata:
  name: myapp-pod-nodeport-service 
  labels:
    app: front-end
spec:
  type: NodePort 
  selector: 
    app: myapp
  ports: 
    - name: tomcat
      port: 8080 
      targetPort: 8080 # This port most be open on the SG in AWS
      nodePort: 31238  
```

### Create a pod, service and so on
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


### Get all Objects in default namespace
```
kubectl get all
```

### Create a service
```
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

### Delete a pod
```
kubectl delete pod <pod name>
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