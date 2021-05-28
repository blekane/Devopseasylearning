### Helm Public Respository
This is where we have some public chart. It is the same like docker hub
[Helm Public Respository](https://artifacthub.io/)

## Install jenkins from helm hub
[Jenkins stable repo](https://artifacthub.io/packages/helm/jenkinsci/jenkins)

**Get Repo Info**
```
helm repo add jenkins https://charts.jenkins.io
helm repo update
```

**Install Chart**
```
helm install [RELEASE_NAME] jenkins/jenkins [flags]
helm install jenkins jenkins/jenkins -n default

helm list
kubectl get po
```

**Upgrade Chart**
```
helm upgrade [RELEASE_NAME] jenkins/jenkins [flags]
helm upgrade jenkins jenkins/jenkins -n default
```

**Uninstall Chart**
```
helm uninstall [RELEASE_NAME] [flags]
helm uninstall jenkins  -n default
```

**Show Configuration files**
```
helm show values jenkins/jenkins
```

### Search Chart from hub through CLI
**Get all charts**
```
helm search hub
```
**Search a specify chart (This will list all )**
```
helm search hub mysql
helm search hub jenkins
```

## List and update the repository

**List all repository that you added from helm hub**
```
helm repo list
```
**Update a repository and download the latest chart changes from helm hub**
```
helm repo update
```

### Create a chart folder
This will create a default chart folder structure
```
helm create [char name]
helm create mychart
```

### Check how you manifest will looks like after Helm install 
* This command will show all the manifest file with values from the value file with `helm 3`

```
helm install --dry-run --debug ./[chart folder name] --generate-name
helm install --dry-run --debug ./[chart folder name]/ --generate-name
helm install --dry-run --debug ./mychart --generate-name
helm install --dry-run --debug ./mychart/ --generate-name
```

* This command will show all the manifest file with values from the value file with `helm 2`
```
helm install [release name] --dry-run --debug ./[chart folder name]/ 
helm install demo --dry-run --debug ./mychart/
```

### Install a default chart
```
helm install [release name] ./[chart folder name]/ -n [namespace]
helm install demo ./mychart/ -n default
helm uninstall demo -n default
```






































## Comment in helm
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  example1: {{/* quote .Values.replicaCount */}}
  example1: {{/* .Values.replicaCount | quote */}}
  example1: "{{/* .Values.replicaCount */}}"

  example2: {{ .Values.image.tag | quote }}
  example2: {{ quote .Values.image.tag }}
  example2: "{{ .Values.image.tag }}"
  
  example3: {{ .Values.image.tag | upper }}
  example3: {{ upper .Values.image.tag }}
```
**Result**
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: jenkins-test-configmap
data:
  example1: 
  example1: 
  example1: ""

  example2: "covid19"
  example2: "covid19"
  example2: "covid19"
  
  example3: COVID19
  example3: COVID19
```