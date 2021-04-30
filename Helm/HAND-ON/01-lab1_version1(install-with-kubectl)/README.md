### Create a namespace
kubectl create namespace v1

### Install application using kubectl
* vim frontend.yaml
```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
spec:
  replicas: 1
  selector:
    matchLabels:
      app: frontend 
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
      - image: phico/frontend:1.0
        imagePullPolicy: Always
        name: frontend
        ports:
        - name: frontend
          containerPort: 4200
```

* frontend-service.yaml
```yml
apiVersion: v1
kind: Service
metadata:
  labels:
    name: frontend
  name: frontend
spec:
  ports:
    - protocol: "TCP"
      port: 80
      targetPort: 4200
  selector:
    app: frontend
```

* ingress.yaml
```yml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: guestbook-ingress
spec:
  rules:
  - host: frontend.minikube.local
    http:
      paths:
      - path: /
        backend:
          serviceName: frontend
          servicePort: 80
  - host: backend.minikube.local
    http:
      paths:
      - path: /
        backend:
          serviceName: backend
          servicePort: 80
```
* Deploy manifests
```
kubectl apply -f frontend.yaml -n v1
kubectl apply -f frontend-service.yaml -n v1
kubectl apply -f ingress.yaml -n v1
```
```
kubectl apply -f frontend.yaml -n v1
kubectl apply -f frontend-service.yaml --validate=false -n v1
kubectl apply -f ingress.yaml --validate=false -n v1
```

* Check
```
kubectl get po -n v1
kubectl get deploy -n v1
kubectl get svc -n v1 -o wide
kubectl get ingress -n v1
```
* Clean up
kubectl delete ns v1
kubectl get all

### Use script to install manifests
```sh
#!/bin/bash
kubectl create namespace v1
kubectl apply -f frontend.yaml -n v1
kubectl apply -f frontend-service.yaml -n v1
kubectl apply -f ingress.yaml -n v1
kubectl get all -n v1
```

```
#!/bin/bash
kubectl create namespace v1 
kubectl apply -f frontend.yaml -n v1 --validate=false
kubectl apply -f frontend-service.yaml -n v1 --validate=false
kubectl apply -f ingress.yaml -n v1 --validate=false
kubectl get all -n v1 --validate=fals
```

### Use script to Remode manifests
```sh
#!/bin/bash
kubectl delete -f frontend.yaml -n v1
kubectl delete -f frontend-service.yaml -n v1
kubectl delete -f ingress.yaml -n v1
kubectl get all -n v1
```