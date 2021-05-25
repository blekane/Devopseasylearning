### Helm Public Respository
This is where we have some public chart. It is the same like docker hub
[Helm Public Respository](https://artifacthub.io/)

## Install jenkins from helm hub
[Jenkins stable repo](https://artifacthub.io/packages/helm/jenkinsci/jenkins)

**Get Repo Info**
helm repo add jenkins https://charts.jenkins.io
helm repo update

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
helm install --dry-run --debug ./[chart folder name]/ --name [release name]
helm install --dry-run --debug ./mychart/ --name demo
```

### Install a default chart
```
helm install [release name] ./[chart folder name]/ -n [namespace]
helm install demo ./mychart/ -n default
helm uninstall demo -n default
```

### Add a configmap
vim configmap.yml
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: mychart-configmap
data:
  myvalue: "Sample Config Map"
```

## Add a configmap name with built in variables
[Built in Variables](https://helm.sh/docs/chart_template_guide/builtin_objects/)

**name = demo**
```
helm install --dry-run --debug ./mychart/ --name demo
```
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}
data:
  myvalue: "Sample Config Map"
```

**name = name: demo-configmap**
```
helm install --dry-run --debug ./mychart/ --name demo
```
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  myvalue: "Sample Config Map"
```

**name: mychart-0.1.0**
```
helm install --dry-run --debug ./mychart/ --name demo
```
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Chart.Name }}-{{ .Chart.Version }}
data:
  myvalue: "Sample Config Map"
```

**name: mychart-0.1.0-configmap**
```
helm install --dry-run --debug ./mychart/ --name demo
```
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Chart.Name }}-{{ .Chart.Version }}-configmap
data:
  myvalue: "Sample Config Map"
```

**name: demo-default-0.1.0-configmap**
```
helm install --dry-run --debug ./mychart/ --name demo 
```
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-{{ .Release.Namespace }}-{{ .Chart.Version }}-configmap
data:
  myvalue: "Sample Config Map"
```

### Custom Values Example 

```yml
replicaCount: 1
image:
  repository: leonardtia/devops-test-repo
  tag: covid19
  pullPolicy: IfNotPresent
```
We have a default image tag already which is covid19. 
```
helm install --dry-run --debug ./mychart/ --name demo |grep example
```
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  myvalue: "Sample Config Map"
  example1: {{ .Values.replicaCount }}
  example2: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
```

**Result**
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: demo-configmap
data:
  myvalue: "Sample Config Map"
  example1: 1
  example2: "leonardtia/devops-test-repo:covid19"
```

## Custom Values Eample With default tag as chart version

```yml
replicaCount: 1
image:
  repository: leonardtia/devops-test-repo
  tag: covid19
  pullPolicy: IfNotPresent
```

This will use the the `chart version as default` tag if the tag is not specify in the values file
```
helm install --dry-run --debug ./mychart/ --name demo |grep example
```
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  myvalue: "Sample Config Map"
  example1: {{ .Values.replicaCount }}
  example2: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
```

**Result**
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: demo-configmap
data:
  myvalue: "Sample Config Map"
  example1: 1
  example2: "leonardtia/devops-test-repo:1.0"
```

## Custom Values Eample Without default tag as jenkins-nonoprod

```yml
replicaCount: 1
image:
  repository: leonardtia/devops-test-repo
  tag: 
  pullPolicy: IfNotPresent
```

This will use the `jenkins-nonoprod` as default tag if the tag is not specify in the values file
```
helm install --dry-run --debug ./mychart/ --name demo |grep example
```
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  myvalue: "Sample Config Map"
  example1: {{ .Values.replicaCount }}
  example2: "{{ .Values.image.repository }}:{{ .Values.image.tag | default "jenkins-nonoprod" }}"
```

**Result**
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: demo-configmap
data:
  myvalue: "Sample Config Map"
  example1: 1
  example2: "leonardtia/devops-test-repo:jenkins-nonoprod"
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