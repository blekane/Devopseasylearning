# Persistent Volume

- It not specific to a particular namespace
- An administrator can a cluster wide PersistentVolume so that any pod in the cluster can use it
- Persistent Volume Claim are namespace bound and not cluster wide. It not cluster wide like PersistentVolume
- It is the storage that an administrator request from the storage class while a pvc is the storage that the application or pod request from the PV

## Check a Persistent Volume Claim
```
kubectl get pv -n [namespace]
```


```yml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: darwin-volume
  labels:
    type: local
spec:
  storageClassName: dev
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteMany
  hostPath:
    path: "/mnt/data"
```
