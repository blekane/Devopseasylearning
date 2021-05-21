## Install a default chart
We will use the default chart here
```
helm create devopseasylearning-chart-for-testing
helm install [release name] ./[chart folder name]/ -n [namespace]
helm install demo ./devopseasylearning-chart-for-testing/ -n default
helm uninstall demo -n default
```

## Install and delete a release with a default chart
**1- Test before installing**
```
helm install --dry-run --debug ./mychart/ --name jenkins-test --namespace cicd

helm install --dry-run --debug ./mychart/ --name jenkins-test --namespace cicd --set fullnameOverride=jenkins-test

helm install --dry-run --debug ./mychart/ --name jenkins-test --namespace cicd --set fullnameOverride=jenkins-test -f values.yaml
```
**2- Install the release**

The pod will have the chart name here 

**POD:** jenkins-test-`mychart`-5c4d795dd4-r4j95
```
helm install ./mychart/ --name jenkins-test 
helm install ./mychart/ --name jenkins-test --namespace cicd
```
The pod will not have the chart name here because we overwrite it

**POD:** jenkins-test-7cd597bfb8-ck9vz
```
helm install ./mychart/ --name jenkins-test --set fullnameOverride=jenkins-test
helm install ./mychart/ --name jenkins-test --set fullnameOverride=jenkins-test --namespace cicd
```

**2- Delete the release with Helm3**

If we delete a release with `helm uninstall jenkins-test` with `--purge`, will not be able to install the it with the same release name. It is a good idea to use `helm uninstall jenkins-test --purge` do delete a release with the release name in the cluster
```
helm uninstall jenkins-test 
helm del --purge jenkins-test
helm delete jenkins-test --purge
helm uninstall jenkins-test --purge 
```

**3- Delete the release with Helm3**

If we delete a release with `helm delete jenkins-test` with `--purge`, will not be able to install the it with the same release name. It is a good idea to use `helm delete jenkins-test --purge` do delete a release with the release name in the cluster
```
helm delete jenkins-test
helm del --purge jenkins-test
helm delete jenkins-test --purge
helm delete jenkins-test --purge 
```

### Install a default chart
```
helm install [release name] ./[chart folder name]/ -n [namespace]
helm install demo ./mychart/ -n default
helm uninstall demo -n default
```