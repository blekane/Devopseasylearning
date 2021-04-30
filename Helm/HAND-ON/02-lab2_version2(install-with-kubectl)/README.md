### Use script to install manifests
```
#!/bin/bash
kubectl create namespace v11
kubectl create-f frontend.yaml -n v11
kubectl create -f frontend-configmap.yaml -n v11
kubectl create -f frontend-service.yaml -n v11
kubectl create -f backend-secret.yaml -n v11
kubectl create -f backend-service.yaml -n v11
kubectl create -f backend.yaml -n v11
kubectl create -f ingress.yaml -n v11
kubectl create -f mongodb-persistent-volume.yaml -n v11
kubectl create -f mongodb-persistent-volume-claim.yaml -n v11
kubectl create -f mongodb-secret.yaml -n v11
kubectl create -f mongodb-service.yaml -n v11
kubectl create -f mongodb.yaml -n v11
kubectl get all -n v11
```

### Use script to Remode manifests
```sh
#!/bin/bash
kubectl create namespace v11 
kubectl create -f frontend.yaml -n v11 --validate=false
kubectl create -f frontend-configmap.yaml -n v11 --validate=false
kubectl create -f frontend-service.yaml -n v11 --validate=false
kubectl create -f backend-secret.yaml -n v11 --validate=false
kubectl create -f backend-service.yaml -n v11 --validate=false
kubectl create -f backend.yaml -n v11 --validate=false
kubectl create -f ingress.yaml -n v11 --validate=false
kubectl create -f mongodb-persistent-volume.yaml -n v11 --validate=false
kubectl create -f mongodb-persistent-volume-claim.yaml -n v11 --validate=false
kubectl create -f mongodb-secret.yaml -n v11 --validate=false
kubectl create -f mongodb-service.yaml -n v11 --validate=false
kubectl create -f mongodb.yaml -n v11 --validate=false
kubectl get all -n v11
```

```
kgp
kgs
kgd
kgi
```