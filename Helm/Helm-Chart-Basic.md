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
