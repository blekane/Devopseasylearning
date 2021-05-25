### Create a chart structure
```
helm create [chart name]
helm create my-first-chart
```

### Helm lint
* Before deploying into kubernetes cluster, check the syntax first. You most navigate into the directory that content the chart first
* Examine a chart for possible issues
```
helm lint ./[chart folder name]/
helm lint ./my-first-release/
```

### Check how you manifest will looks like after Helm install 
* * This command will show all the manifest file with values from the value file
```
helm install --dry-run --debug ./[chart folder name]/ --generate-name
helm install --dry-run --debug ./[chart folder name] --generate-name

helm install --dry-run --debug ./my-first-chart/ --generate-name
helm install --dry-run --debug ./my-first-chart --generate-name
```

### Helm install command
```
helm install [release name] [chart folder name] -n [namespace]
helm install [release name] ./chart folder name/ -n [namespace]
helm install my-release my-first-chart -n v10
helm install my-release ./my-first-chart/ -n v10
```

### Overwrite the service type to from ClusterIP to NodePort 
* This is usefull if we want to install the default chart and test it. This will just display the welcome page of Nginx
* Set command allows us to overwrite values at the command line

```yml
service:
  type: ClusterIP
  port: 80
```
```
helm install nginx ./[chart folder name]/ --set service.type=NodePort -n [namespace]
helm install nginx ./my-first-chart/ --set service.type=NodePort -n v11
```
```
helm install [release name] ./[chart folder name]/ --set service.type=NodePort -n [namespace]
helm install [release name] ./[chart folder name]/ --set service.type=NodePort -n [namespace] -f values-nonprod.yaml

helm install jenkins ./my-chart/ --set service.type=NodePort -n cicd 
helm install jenkins ./my-chart/ --set service.type=NodePort -n cicd -f values-nonprod.yaml

```

### List charts or releases in the namespace
```
helm ls -n [namespace name]
helm ls -n metric
helm list
helm list -q

# list all the releases
helm list -A
```

### To list the status of the release
helm status [release name] -n [namespace name]
helm status nginx -n v12


### To see all information about the release
```
helm get all [release name] -n [namespace name] |less
helm get all my-release -n v12 |less
```

### To see all information about kubernetes manifest
```
helm get manifest [release name] -n [namespace name] |less
helm get manifest my-release -n v12 |less
```

### To all the values that overwrite through the CLI while runing helm install
```
helm get values [release name] -n [namespace name] 
helm get values my-release -n v12 
```

### To see all the values 
```
helm get values [chart name] -n [namespace name] 
helm show values my-first-chart -n v12
```

### Helm show commands ()
```
helm show help
helm show [command]
```
```
# show all information of the chart
helm show all [CHART]   
helm show all my-first-chart -n v12 |less

# show the chart's definition
helm show chart [CHART] 
helm show chart my-first-chart -n v12

# show the chart's README      
helm show readme [CHART]       
helm show readme my-first-chart -n v12

# show the chart's values
helm show values [CHART]       
helm show values my-first-chart -n v12 |less
```

### To see the releases history
```
helm history [release name] -n v12
helm history my-release
```

### To upgrade a release
```
helm upgrade [release name] [chart name]
helm upgrade nginx my-first-chart
```

### To rollback a release
```
helm rollback [release name] [release revirson]
helm rollback nginx 1
```

### To zip all the chart folder and store it maybe in S3
```
helm package [chart folder name]
helm package [chart folder name] --force
helm package my-first-chart --force
```


### Uninstall a chart
```
helm uninstall [release name] -n v8
helm uninstall my-first-chart -n v8
```

### Remove Helm 
```
yum remove helm -y
apt-get remove helm -y
```

### List all repository
```
helm repo list
```

### Update helm repository
```
helm repo update
```
### List chart in the namespace
```
helm ls -n [namespace name]
helm ls -n metric
helm list
helm list -q

# list all the releases
helm list -A
```
*  kube-state-metrics-1.2.3 (chart name + version)
* chart name = kube-state-metrics
* chart version = 1.2.3

### Helm show commands ()
```
helm show help
helm show [command]
```
```
helm show all [CHART]          show all information of the chart
helm show chart [CHART]        show the chart's definition
helm show readme [CHART]       show the chart's README
helm show values [CHART]       show the chart's values
```

* If the was downloaded from helm hub, use the folowing commands:
```
helm show all [REPOSITORY][CHART]   
helm show chart [REPOSITORY][CHART]       
helm show readme [REPOSITORY][CHART]          
helm show values [REPOSITORY][CHART] 

helm show all bitnami/kube-state-metrics
helm show chart bitnami/kube-state-metrics
helm show values bitnami/kube-state-metrics
helm show readme bitnami/kube-state-metrics
```


### Installing kube-state-metrics package
* [kube-state-metrics](https://artifacthub.io/packages/helm/bitnami/kube-state-metrics)
* It collects data from the kube API service about objects like pods, nodes, deploymentand configmaps
* It help you view and monitor the momery and CPU usage
* search for `kube-state-metrics` in helm hub
```
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
kubectl create ns metric
helm install my-release bitnami/kube-state-metrics -n metric
```
* Port foward to access the logs on the browser
```
kubectl port-forward --namespace metric svc/my-release-kube-state-metrics 9100:8080 -n metric
```
* Get information about the chart
```
helm show all bitnami/kube-state-metrics
helm show chart bitnami/kube-state-metrics
helm show values bitnami/kube-state-metrics
helm show readme bitnami/kube-state-metrics
```







