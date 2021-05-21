## Function
[Sprig Function Documentation](http://masterminds.github.io/sprig/)

[Template Functions and Pipelines](https://helm.sh/docs/chart_template_guide/functions_and_pipelines/)


## Upper and Quote function
[Template Functions and Pipelines](https://helm.sh/docs/chart_template_guide/functions_and_pipelines/)

**upper:** This will take the value from the value file and put it in `uppercase`

**quote:** This will take the value from the value file and put it in `quote`
```
helm install --dry-run --debug ./mychart/ --name jenkins-test |grep example
```
```yml
replicaCount: 1
image:
  repository: leonardtia/devops-test-repo
  tag: covid19
  pullPolicy: IfNotPresent
```
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  example1: {{ quote .Values.replicaCount }}
  example1: {{ .Values.replicaCount | quote }}
  example1: "{{ .Values.replicaCount }}"

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
  example1: "1"
  example1: "1"
  example1: "1"

  example2: "covid19"
  example2: "covid19"
  example2: "covid19"
  
  example3: COVID19
  example3: COVID19
```