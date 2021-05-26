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
This is going to give us the manifest file with the values from the the values file. 
```
helm get manifest [release name] -n [namespace name] |less
helm get manifest my-release -n v12 |less
```

### To see the notes
```
helm get notes [release name] -n [namespace name] 
helm get values my-release -n v12 
```

### To all the values that we overwrite through the CLI while runing helm install
```
helm get values [release name] -n [namespace name] 
helm get values my-release -n v12 
```

This will be the result if we didn't passed any value through the CLI while doing the deployment.
```
root@ubuntu:~# helm get values demo
USER-SUPPLIED VALUES:
null
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

### Helm show commands ()
```
helm show help
helm show [command]
```
```
# show all information of the chart
helm show all [CHART]   
helm show all my-first-chart -n v12 |less
helm show all mychart
```
```
# show the chart's definition
helm show chart [CHART] 
helm show chart my-first-chart -n v12
helm show chart mychart
```
```
# show the chart's README      
helm show readme [CHART]       
helm show readme my-first-chart -n v12
helm show readme mychart
```
```
# show the chart's values
helm show values [CHART]       
helm show values my-first-chart -n v12 |less
helm show values mychart
```

