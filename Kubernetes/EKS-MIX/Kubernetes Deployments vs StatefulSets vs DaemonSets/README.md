## Deployments vs StatefulSets vs DaemonSets [here](https://medium.com/stakater/k8s-deployments-vs-statefulsets-vs-daemonsets-60582f0c62d4) and [here](https://www.youtube.com/watch?v=7Tnm9hRyoYU)

## Understanding StatefulSets in Kubernetes [here](https://www.youtube.com/watch?v=zj6r_EEhv6s)

## Github [here](https://github.com/kahootali/counter-app/tree/master/kubernetes)


kubectl apply -f daemonset.yaml
```yml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: counter-app
spec:  
  selector:
    matchLabels:
      app: counter
  template:
    metadata:
      name: counter-app
      labels:
        app: counter
    spec:
      tolerations: 
      - effect: NoSchedule
        operator: Exists
      containers:
      - name: counter
        image: "kahootali/counter:1.1"
        volumeMounts:
        - name: counter
          mountPath: /app/
      volumes:
      - name: counter
        persistentVolumeClaim:
          claimName: counter
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: counter
spec:
  accessModes:
  - ReadWriteMany
  resources:
    requests:
      storage: 50Mi
  storageClassName: efs
  ```



kubectl apply -f deployment.yaml
kubectl scale deployment counter --replicas=2
```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: counter
spec:
  replicas: 1
  selector:
    matchLabels:
      app: counter
  template:
    metadata:
      labels:
        app: counter
    spec:
      containers:
      - name: counter
        image: "kahootali/counter:1.1"
        volumeMounts:
        - name: counter
          mountPath: /app/
      volumes:
      - name: counter
        persistentVolumeClaim:
          claimName: counter
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: counter
spec:
  accessModes:
  - ReadWriteMany
  resources:
    requests:
      storage: 50Mi
  storageClassName: efs
```



kubectl apply -f statefulset.yaml
kubectl scale statefulsets counter --replicas=3
```yml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: counter
spec:
  serviceName: "counter-app"
  selector:
    matchLabels:
      app: counter
  replicas: 1 
  template:
    metadata:
      labels:
        app: counter
    spec:      
      containers:
      - name: counter
        image: "kahootali/counter:1.1"  
        volumeMounts:
        - name: counter
          mountPath: /app/      
  volumeClaimTemplates:
  - metadata:
      name: counter
    spec:
      accessModes: [ "ReadWriteMany" ]
      storageClassName: efs
      resources:
        requests:
          storage: 50Mi
```