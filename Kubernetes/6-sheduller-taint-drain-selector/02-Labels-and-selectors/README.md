
## Labels, selectors and annotations in Kubernetes
- Labels and selectors are use to group and select objects in the cluster
- While labels and selectors are use to group and select objects in the cluster, annotations are use to record other details such as:
    - Phone number
    - Email 
    - Application version
    - Build information
    - Contact details

### Create a pod definition
-  **Create a file:** cat > myapp-pod.yml (ctrl+d to save)
```yaml
apiVersion: v1
kind: Pod 
metadata:
  name: myapp-pod 
  labels: 
    app: web-server   
    function: front-end     
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

### Select pod base on label
```
kubectl get po --selector app=web-server
OR
kubectl get po --selector function=front-end
```

## Create a replicaset definition with annotations
-  **Create a file:** cat > rs.yml (ctrl+d to save)
```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: myapp-rs
  annotations:
    buildversion: V1
    company-phone: 852-441-1444
    email: mtci.gmail.com 
  labels:
    app: back-end
    function: db
spec:
  template:
    metadata:
      name: myapp-pod 
      labels: 
        app: back-end
        function: db     
    spec:
      containers: 
        - name: nginx-container
          image: nginx
          ports:
            - containerPort: 80 
  replicas: 3
  selector:
    matchLabels:
        app: back-end
        function: db
```
### Select replicaset base on label
```
kubectl get rs --selector app=back-end
kubectl get rs --selector function=db
OR
kubectl get rs --selector app=back-end,function=db
```

### Show pods label
```
kubectl get pod --show-labels
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

# Examples
### We have deployed a number of PODs. They are labelled with 'tier', 'env' and 'bu'. How many PODs exist in the 'dev' environment?
```
kubectl get po --show-labels -l env=dev
kubectl get po --show-labels -l env=dev --no-headers
kubectl get po --show-labels -l env=dev --no-headers
OR
kubectl get po --show-labels -l env=dev
kubectl get po --show-labels -l env=dev --no-headers
kubectl get po -l env=dev --no-headers |wc -l
OR
kubectl get po --selector env=dev
kubectl get po --selector env=dev --no-headers
kubectl get po --selector env=dev --no-headers
```

### How many PODs are in the 'finance' business unit ('bu')?
```
kubectl get po --show-labels -l bu=finance --no-headers |wc -l
```

### How many objects are in the 'prod' environment including PODs, ReplicaSets and any other objects?
```
kubectl get all --show-labels -l env=prod
kubectl get all --show-labels -l env=prod --no-headers |wc -l
OR
kubectl get all --show-labels --selector env=prod --no-headers |wc -l
OR
kubectl get all --selector env=prod --no-headers |wc -l
```

### Identify the POD which is part of the prod environment, the finance BU and of frontend tier?
```
kubectl get pod --show-labels -l env=prod,bu=finance,tier=frontend
kubectl get pod --show-labels -l env=prod,bu=finance,tier=frontend --no-headers |wc -l
```