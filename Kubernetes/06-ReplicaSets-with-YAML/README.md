# ReplicaSets with YAML

### Create ReplicaSet Definition
-  **Create a file:** cat > replicaset.yaml (ctrl+d to save)

```yaml
apiVersion: apps/v1
kind: ReplicaSet #(Object to be created in K8)
metadata:
  name: myapp2-rs #(ReplicaSet name)
spec:
  replicas: 3 # 3 Pods should exist at all times.
  selector:   # Pods label should be defined in ReplicaSet label selector
    matchLabels:
      app: myapp2
  template:
    metadata:
      name: myapp2-pod
      labels:
        app: myapp2 # Atleast 1 Pod label should match with ReplicaSet NodePort Service Label Selector
    spec:
      containers:
      - name: myapp2 #(container name)
        image: nginx #(image name)
        ports:
          - containerPort: 80 #(container port)
```

```yaml
---
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: myapp-rs2 
  labels:
    app: myapp2
    type: frond-end
spec:
  template:
    metadata:
      name: myapp-pod 
      labels: 
        app: myapp2   
        tier: front-end     
    spec:
      containers: 
        - name: nginx-container
          image: nginx
          ports:
            - containerPort: 80 
  replicas: 3
  selector:
    matchLabels:
        tier: front-end  # or  app: myapp
```

### Create ReplicaSet
```
kubectl create -f replicaset.yaml
```

### List Replicasets
```
kubectl get rs
```

### List Pods
```
kubectl get pods
kubectl get pods -o wide
```

### Describe Replicasets
```
kubectl describe rs <replicaset name>
kubectl describe rs myapp2-rs
```
### Delete Pod
```
kubectl delete pod <Pod-Name>
```

### Create NodePort Service for ReplicaSet
-  **Create a file:** cat > replicaset-nodeport-servie.yml (ctrl+d to save)
```yaml
---
apiVersion: v1
kind: Service
metadata:
  name: replicaset-nodeport-service
spec:
  type: NodePort
  selector:
    app: myapp2
  ports:
    - name: nginx
      port: 80
      targetPort: 80
      nodePort: 31232  
```
### Create NodePort Service for ReplicaSet & Test
```
kubectl apply -f replicaset-nodeport-servie.yml
```

### List NodePort Service
```
kubectl get svc
```

### Get Public IP
```
kubectl get nodes -o wide
```
### Access Application
http://<Worker-Node-Public-IP>:<NodePort>
http://<Worker-Node-Public-IP>:31232


# Scaling a replicaset (we have many options):

## 1- Update the number of replicas in the mainfest file to 6 for instance
-  **Create a file:** cat > replicaset.yaml (ctrl+d to save)
```yaml
---
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: myapp-rs 
  labels:
    app: myapp2
    type: frond-end
spec:
  template:
    metadata:
      name: myapp-pod 
      labels: 
        app: myapp2   
        tier: front-end     
    spec:
      containers: 
        - name: nginx-container
          image: nginx
          ports:
            - containerPort: 80 
  replicas: 3
  selector:
    matchLabels:
        tier: front-end  # or  app: myapp
```

```yaml
---
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: myapp-rs 
  labels:
    app: myapp2
    type: frond-end
spec:
  template:
    metadata:
      name: myapp-pod 
      labels: 
        app: myapp2   
        tier: front-end     
    spec:
      containers: 
        - name: nginx-container
          image: nginx
          ports:
            - containerPort: 80 
  replicas: 6
  selector:
    matchLabels:
        tier: front-end  # or  app: myapp
```
### Create a replicaset
```
kubectl create -f my-replicaset.yaml
```

### Update the replicat with the replace command
```
kubectl replace -f <replicaset name>
kubectl replace -f my-replicaset.yaml
```

## 2- Use the kubectl scale
- This will update the number of replicas in the cluster; However, it will not update it in the definition file (my-replicaset.yaml). The number of replication will still be 3 in the manifest even though you scale to 6.
- This will scale the replicaset from the CLI without modify the file.

```
kubectl scale --replicas=6 -f <manifest file: my-replicaset.yaml>
OR
kubectl scale --replicas=6 replicaset <replicaset name>

kubectl scale --replicas=6 replicaset myapp-rs
kubectl scale --replicas=6 -f my-replicaset.yaml
```

### Check the number of replicaset in the YAML
```
kubectl get replicaset myapp-rs -o yaml
```

# Create a ReplicationController definition file
- Replication controllers and replicaset have the same purpose; however, they are not the same. Replication controllers is the older technology and replicaset is the newer technology (this is the recommended way to set replication in K8).
- The difference between replication controller and replicaset is that replication controller does not require a selector and replicaset does. Also, the API version do change
-  **Create a file:** cat > rc-definition.yml (ctrl+d to save)

```yaml
---
apiVersion: v1
kind: ReplicationController
metadata:
  name: myapp-rc
  labels:
    app: myapp2
    type: frond-end
spec:
  template:
    metadata:
      name: myapp-pod 
      labels: 
        app: myapp2   
        tier: front-end     
    spec:
      containers: 
        - name: nginx-container
          image: nginx
          ports:
            - containerPort: 80 
  replicas: 3
```
### Create ReplicationController
```
kubectl create -f rc-definition.yml
```

### Get ReplicationController
```
kubectl get replicationcontroller
```

### get ReplicationController pods
```
kubectl get pod
```

### delete replicationcontroller
```
kubectl delete replicationcontroller myapp-rc
```

### API References
- **ReplicaSet:** https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.18/#replicaset-v1-apps