# Persistent Volume Claim

- It a way to allocate pices of the Persistent Volume to pods and services running in kubernetes
- It is the volume that a pod need to run
- it just a directory mount on the filesystem so that containers can used to persist data.
- Persistent Volume Claim are namespace bound and not cluster bound. It not cluster wide like PersistentVolume

## Check a Persistent Volume Claim
```
kubectl get pvc -n [namespace]
```


```yml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: darwin-claim
spec:
  storageClassName: dev
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 3Gi
```

##  PVC can be attached to a pod with a specification similar to:
```yml
spec:
  volumes:
    - name: darwin-storage
      persistentVolumeClaim:
        claimName: darwin-claim
  containers:
    - name: darwin-container
      image: nginx
      ports:
        - containerPort: 80
```