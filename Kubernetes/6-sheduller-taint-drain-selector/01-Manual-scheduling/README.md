# Manual scheduling with no scheduller

### Check if the scheduller is installed
- This command will inspect the Kubernetes control plane environment installed on the system (etcd-master, sheduller, kube-proxy, kube-controller-manager-master, kube-apiserver-master and on)
```
kubectl -n kube-system get pods
```

### Create a pod definition
-  **Create a file:** cat > myapp-pod.yml (ctrl+d to save)
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
### Create pod
```
kubectl create -f myapp-pod.yml
```

### Check pods 
- This will be in the pending stage because there is no scheduller on the system
```
kubectl get po
kubectl get pod -o wide
```

### delete the pod. Reccreate and assigin a node to a pod
-  **Create a file:** cat > myapp-pod.yml (ctrl+d to save)
```
kubectl delete pod myapp-pod
```

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
  nodeName: node01
    - name: myapp 
      image: nginx
      ports:
        - containerPort: 80 

OR 

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
  nodeName: node01 
  ```

### Check pods 
- This will be in the running stage because there is schedule a pod to a node
```
kubectl get po
kubectl get pod -o wide
```

### This to schedule a pod on the master
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
  nodeName: master
    - name: myapp 
      image: nginx
      ports:
        - containerPort: 80 

