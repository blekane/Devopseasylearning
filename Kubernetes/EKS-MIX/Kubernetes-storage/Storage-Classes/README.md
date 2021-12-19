## Storage Classes [here](https://kubernetes.io/docs/concepts/storage/storage-classes/#provisioner)


- It is the volume for the cluster. It is the entire volume that kubernetes is going to used
- it doesn't have anything to with nodes virtual machine
- local storage class is used if you are running kubernetes in `kind, minuke`


### Get storage classes
```
kubectl get storageclass