## Install a default chart with helm 3 and helm 2
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
# Helm 2
helm install --dry-run --debug ./mychart/ --name jenkins-test --namespace cicd

helm install --dry-run --debug ./mychart/ --name jenkins-test --namespace cicd --set fullnameOverride=jenkins-test

helm install --dry-run --debug ./mychart/ --name jenkins-test --namespace cicd --set fullnameOverride=jenkins-test -f values.yaml

#helm 3
helm install --dry-run --debug ./mychart/ --generate-name --namespace cicd

helm install jenkins-test --dry-run --debug ./mychart/ --namespace cicd 

helm install jenkins-test --dry-run --debug ./mychart/ --namespace cicd --set fullnameOverride=jenkins-test

helm install --dry-run --debug ./mychart/ --name jenkins-test --namespace cicd --set fullnameOverride=jenkins-test -f values.yaml
```
**2- Install the release**

The pod will have the chart name here 

**POD:** jenkins-test-`mychart`-5c4d795dd4-r4j95
```
# Helm2
helm install ./mychart/ --name jenkins-test 
helm install ./mychart/ --name jenkins-test --namespace cicd

# Helm3
helm install jenkins-test ./mychart/ 
helm install jenkins-test ./mychart/ --namespace cicd
```
The pod will not have the chart name here because we overwrite it

**POD:** jenkins-test-7cd597bfb8-ck9vz
```
# Helm2
helm install ./mychart/ --name jenkins-test --set fullnameOverride=jenkins-test

helm install ./mychart/ --name jenkins-test --set fullnameOverride=jenkins-test --namespace cicd

# Helm3
helm install jenkins-test ./mychart/ --set fullnameOverride=jenkins-test

helm install jenkins-test ./mychart/ --set fullnameOverride=jenkins-test --namespace cicd
```

**2- Delete the release with Helm 3**

If we delete a release with `helm uninstall jenkins-test` without `--purge`, will not be able to install the it with the same release name. It is a good idea to use `helm uninstall jenkins-test --purge` do delete a release with the release name in the cluster
```
helm uninstall jenkins-test 
helm del --purge jenkins-test
helm delete jenkins-test --purge
helm uninstall jenkins-test --purge 
```

**3- Delete the release with Helm 2**

If we delete a release with `helm delete jenkins-test` without `--purge`, will not be able to install the it with the same release name. It is a good idea to use `helm delete jenkins-test --purge` do delete a release with the release name in the cluster
```
helm delete jenkins-test
helm del --purge jenkins-test
helm delete jenkins-test --purge
helm delete jenkins-test --purge 
```
