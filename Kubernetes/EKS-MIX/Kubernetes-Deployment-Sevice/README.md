# Deployments with YAML

### 4 top level  items in K8 manifest file
```yaml
apiVersion: 
kind: 
metadata:
spec:
``` 

###  Create Frontend Deployment & NodePort Service
- Write the Deployment template for backend-restapp Application
- Write the NodePort service template for backend-restapp Application
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
          image: leonardtia/devops-pro-repos:contactform
          ports:
          - containerPort: 8080
```

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-backend-service
  labels: 
    app: backend-restapp
    tier: backend
spec:
  selector:
    app: backend-restapp
  ports:
    - name: http
      port: 8080
      targetPort: 8080
```

###  Create Frontend Deployment & NodePort Service
- Write the Deployment template for frontend httpd Application
- Write the NodePort service template for frontend httpd Application
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend-nginxapp
  labels:
    app: frontend-nginxapp
    tier: frontend
spec:
  replicas: 3
  selector:
    matchLabels:
      app: frontend-nginxapp
  template:
    metadata:
      labels:
        app: frontend-nginxapp
        tier: frontend
    spec:
      containers:
        - name: frontend-nginxapp
          image: httpd
          ports:
          - containerPort: 80
```

```yaml
apiVersion: v1
kind: Service
metadata:
  name: frontend-nginxapp-nodeport-service
  labels:
    app: frontend-nginxapp
    tier: frontend
spec:
  type: NodePort
  selector:
    app: frontend-nginxapp
  ports:
    - name: http
      port: 80
      targetPort: 80
      nodePort: 31234
```


### Create deployment Definition file
-  **Create a file:** cat > my-deployment.yaml (ctrl+d to save)

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp3-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp3
  template: 
    metadata: 
      name: myapp3-pod
      labels: 
        app: myapp3         
    spec:
      containers: 
        - name: myapp-container
          image: httpd
          ports:
            - containerPort: 80
```

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp3-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp3
  template: 
    metadata: 
      name: myapp3-pod
      labels: 
        app: myapp3         
    spec:
      containers: 
        - name: myapp-container
          image: tomcat
          ports:
            - containerPort: 8080
```

### Create Deployment
```
kubectl apply -f my-deployment.yaml
kubectl get deploy
kubectl get rs
kubectl get po
```

### Create service Definition file
-  **Create a file:** cat > my-service.yaml (ctrl+d to save)
```yaml
apiVersion: v1
kind: Service
metadata:
  name: deployment-nodeport-service
spec:
  type: NodePort 
  selector: 
    app: myapp3
  ports: 
    - name: http
      port: 80
      targetPort: 80
      nodePort: 31233
```

```yaml
apiVersion: v1
kind: Service
metadata:
  name: deployment-nodeport-service
spec:
  type: NodePort 
  selector: 
    app: myapp3
  ports: 
    - name: http
      port: 8080
      targetPort: 8080
      nodePort: 31233
```

### Create NodePort Service
```
kubectl apply -f my-service.yaml
```

### List Service
```
kubectl get svc
```

### Get Public IP
```
kubectl get nodes -o wide
```

### Get all object created
```
kubectl get all
```

### Access Application
```
http://<Worker-Node-Public-IP>:31233 (for httpd application)
http://<Worker-Node-Public-IP>:31233/contactform (for tomcat application)
```

## Generate a deployment files
```
kubectl create deployment --image=nginx nginx --replicas=4 --dry-run=client -o yaml > nginx-deployment.yaml

kubectl create -f nginx-deployment.yaml
kubectl get deployment
kubectl get deployment
```

## See the deployment of nginx before creating
```
kubectl run nginx --image=nginx --dry-run -o yaml
kubectl run nginx --image=nginx --dry-run=client -o yaml > deploy.yml
```
```yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx
  name: nginx
spec:
  containers:
  - image: nginx
    name: nginx
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
```

