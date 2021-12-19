
# Resource Requirements and Limits
**Reference for Windows CPU check:** https://www.top-password.com/blog/find-number-of-cores-in-your-cpu-on-windows-10/#:~:text=Method%201%3A%20Check%20Number%20of,on%20the%20bottom%2Dright%20side.

**Default memory and cpu requested by the pod:**
The minimum amount of memory and cpu requested by the container by default is 0.5 for cpu and 256 for memory. When the scheduler wants to place the pod on the node, it uses these values to find the node that has sufficient resources.
We can modify these default values in the pod definition file if the pod will require more resources than the default values.
- cpu: 0.5 (vCPU = virtual central processing unit)
- Memory: 256Mi

### Set the resources request in the pod definition file
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
      resources:
        requests:
            memory: "1Gi"
            cpu: 1
```
### Check resources
```
kubectl describe pod <pod name> |grep -A2 -i requests
kubectl describe pod myapp-pod  |grep -A2 -i requests
```

### Set the resources request in the deployment definition file
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: backend-restapp
  labels: 
    app: backend-restapp
    tier: backend
spec:
  replicas: 3
  selector:
    matchLabels:
      app: backend-restapp
  template: 
    metadata:
      labels:
        app: backend-restapp
        tier: backend
    spec:
      containers:
        - name: backend-restapp
          image: nginx
          ports:
            - containerPort: 8080
          resources:
            requests:
                memory: "1.5Gi"
                cpu: 1
```

### Check resources
```
kubectl describe deployment <deployment> |grep -A2 -i requests
kubectl describe deployment backend-restapp |grep -A2 -i requests
Or
kubectl describe pod backend-restapp |grep -A2 -i requests
```

### vCPU and Memory limit
- Kubernetes set a resource limit that a pod can consume by default if we don’t specify it.
    - 1 vCPU per container
    - 512 Mi per container 
- We change the default limit if we do not want to by adding the limit section in the pod or deployment definition file.
- NB: a container cannot use more CPU resource than it limit; however, this in not the case for memory. The container can use more more than it limit. Kubernetes will terminate a pod if it use more momery than it limit. 

### Set the resources limit and request in the pod definition file
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
      resources:
        requests:
            memory: "1Gi"
            cpu: 1
        limits:
            memory: "2Gi"
            cpu: 2
```

### Set the resources limit and request in the deployment definition file
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: backend-restapp
  labels: 
    app: backend-restapp
    tier: backend
spec:
  replicas: 3
  selector:
    matchLabels:
      app: backend-restapp
  template: 
    metadata:
      labels:
        app: backend-restapp
        tier: backend
    spec:
      containers:
        - name: backend-restapp
          image: nginx
          ports:
            - containerPort: 8080
          resources:
            requests:
                memory: "1.5Gi"
                cpu: 1
            limits:
                memory: "2Gi"
                cpu: 2
```
### Check resources
```
kubectl describe deployment <deployment> |grep -A2 -i limits
kubectl describe deployment backend-restapp |grep -A5 -i limits
```

- **Assign CPU Resources to Containers and Pods:** https://kubernetes.io/docs/tasks/configure-pod-container/assign-cpu-resource/
- **Configure Default Memory Requests and Limits for a Namespace:** https://kubernetes.io/docs/tasks/administer-cluster/manage-resources/memory-default-namespace/

