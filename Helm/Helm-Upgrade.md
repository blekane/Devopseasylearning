## Helm Upgrade command
This command is use to update a running applicaton in kubernetes cluster. You will learn how to ugrade and rollback the application using helm

### Create a default chart
```
helm create [chart name]
helm create mychart
```

### Install the Chart
```
helm install nginx-test --dry-run --debug ./mychart/ --namespace default --set fullnameOverride=nginx-test

helm install nginx-test ./mychart/ --namespace default --set fullnameOverride=nginx-test

kubectl get deploy -n default
kubectl get po -n default
```

### Upgrade Chart

Change the replicaCount to 3 in the value file and the version as well to 0.1.1 for instance

```
helm install nginx-test --dry-run --debug ./mychart/ --namespace default --set fullnameOverride=nginx-test

helm upgrade [RELEASE_NAME] [CHART_FOLDER] [flags]
helm upgrade nginx-test ./mychart/ -n default

kubectl get deploy -n default
kubectl get po -n default
```

### Uninstall Chart
```
helm uninstall [RELEASE_NAME] [flags]
helm uninstall nginx-test -n default
```

### Check the releases history
```
helm history [release name] -n default
helm history nginx-test -n default
```

### To rollback a release
```
helm rollback [release name] [release revirson]
helm rollback nginx-test 1
```