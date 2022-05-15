# Helm Template If/Else
[Helm Template If/Else](https://kb.novaordis.com/index.php/Helm_Template_If/Else)

Use `man test` command to get all the condition operators through the CLI

```
STRING1 != STRING2
the strings are not equal

INTEGER1 -eq INTEGER2
INTEGER1 is equal to INTEGER2

INTEGER1 -ge INTEGER2
INTEGER1 is greater than or equal to INTEGER2

INTEGER1 -gt INTEGER2
INTEGER1 is greater than INTEGER2

INTEGER1 -le INTEGER2
INTEGER1 is less than or equal to INTEGER2

INTEGER1 -lt INTEGER2
INTEGER1 is less than INTEGER2

INTEGER1 -ne INTEGER2
INTEGER1 is not equal to INTEGER2
```

## Function syntax
```yml
{{- if PIPELINE }}
  # Do something
{{- else if OTHER_PIPELINE }}
  # Do something else
{{- else }}
  # Default case
{{- end }}


{{- if .Values.debug }}
  # Do something
{{- else }}
  # Do something else
{{- end }}
```

## Testing Equality and Inequality of Values
```yml
{{- if eq .Values.myApp.color "blue" }}
... 
... 
... 
{{- end }}



{{- if ne .Values.myApp.color "blue" }}
... 
... 
... 
... 
{{- end }}



{{- if and (eq .Values.myApp.color "blue") (eq .Values.myApp.shape "square") }}
... 
... 
... 
... 
{{- end }}



{{- if not ... }}
... 
... 
... 
... 
{{- end }}


{{- if not .Values.myApp.something }}
... 
... 
... 
... 
{{ end }}


{{- if or .Values.myApp.config.local .Values.myApp.config.nfs }}
...
... 
... 
... 
{{- end }}


{{- if and .Values.appearance .Values.appearance.color }} 
...
... 
... 
... 
{{- end }}
```

### Example 1
Value file
```yml
myApp:
  color: blue
  shape: square
image:
  tag: covid15
```
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
{{- if eq .Values.myApp.color "blue" }}
  example1: {{ .Values.image.tag | quote }}
{{- end }}

{{- if and (eq .Values.myApp.color "blue") (eq .Values.myApp.shape "square") }}
  example2: {{ .Values.image.tag | quote }}
{{- end }}

{{- if or (eq .Values.myApp.color "blue") (eq .Values.myApp.shape "square") }}
  example3: {{ .Values.image.tag | quote }}
{{- end }}

{{- if ne .Values.myApp.color "blue" }}
  example4: {{ .Values.image.tag | quote }}
{{- end }}

OR

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  {{- if eq .Values.myApp.color "blue" }}
  example1: {{ .Values.image.tag | quote }}
  {{- end }}

  {{- if and (eq .Values.myApp.color "blue") (eq .Values.myApp.shape "square") }}
  example2: {{ .Values.image.tag | quote }}
  {{- end }}

  {{- if or (eq .Values.myApp.color "blue") (eq .Values.myApp.shape "square") }}
  example3: {{ .Values.image.tag | quote }}
  {{- end }}

  {{- if ne .Values.myApp.color "blue" }}
  example4: {{ .Values.image.tag | quote }}
  {{- end }}
```

**Result**
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: demo-configmap
data:
  example1: "covid19"
  example2: "covid19"
  example3: "covid19"
```

### Example 2
Value file
```yml
myApp:
  color: blue
  shape: square
image:
  tag: covid15
```
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
{{- if eq .Values.myApp.color "blue" }}
  example1: {{ .Values.image.tag | quote }}
{{- else if and (eq .Values.myApp.color "blue") (eq .Values.myApp.shape "square") }}
  example2: {{ .Values.image.tag | quote }}
{{- else if or (eq .Values.myApp.color "blue") (eq .Values.myApp.shape "square") }}
  example3: {{ .Values.image.tag | quote }}
{{- else if ne .Values.myApp.color "blue" }}
  example4: {{ .Values.image.tag | quote }}
{{- else }}
  example5: {{.Values.myApp.color "blue" }}
{{- end }}

OR

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  {{- if eq .Values.myApp.color "blue" }}
  example1: {{ .Values.image.tag | quote }}
  {{- else if and (eq .Values.myApp.color "blue") (eq .Values.myApp.shape "square") }}
  example2: {{ .Values.image.tag | quote }}
  {{- else if or (eq .Values.myApp.color "blue") (eq .Values.myApp.shape "square") }}
  example3: {{ .Values.image.tag | quote }}
  {{- else if ne .Values.myApp.color "blue" }}
  example4: {{ .Values.image.tag | quote }}
  {{- else }}
  example5: {{.Values.myApp.color "blue" }}
  {{- end }}
```

### Example 3
```yml
myApp:
  color: blue3
  shape: square

Environment:
  env1: nonprd1
  env2: qa1
  env3: pro1

ReplicaCount: 1
image:
  repository: leonardtia/devops-test-repo
  tag: covid19
```
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
{{- if eq .Values.Environment.env1 "nonprd" }}
  example1: {{ .Values.image.tag | quote }}
{{- else if eq .Values.Environment.env1 "qa" }}
  example2: {{ .Values.image.tag | quote }}
{{- else if eq .Values.Environment.env1 "prod" }}
  example3: {{ .Values.image.tag | quote }}
{{- else }}
  myvalue: "Sample Config Map"
  example1: {{ .Values.ReplicaCount }}
  example2: "{{ .Values.image.repository }}:{{ .Values.image.tag | default "jenkins-nonoprod" }}"
{{- end }}

OR

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  {{- if eq .Values.Environment.env1 "nonprd" }}
  example1: {{ .Values.image.tag | quote }}
  {{- else if eq .Values.Environment.env1 "qa" }}
  example2: {{ .Values.image.tag | quote }}
  {{- else if eq .Values.Environment.env1 "prod" }}
  example3: {{ .Values.image.tag | quote }}
  {{- else }}
  myvalue: "Sample Config Map"
  example1: {{ .Values.ReplicaCount }}
  example2: "{{ .Values.image.repository }}:{{ .Values.image.tag | default "jenkins-nonoprod" }}"
  {{- end }}
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


### Example 4
```yml
Environment: dev
ReplicaCount:
  dev: 1
  qa: 1
  stage: 2
  prod: 3
DevImage:
  repository: leonardtia/dev
  tag: dev-covid19
ProdImage:
  repository: leonardtia/prod
  tag: prod-covid19
QaImage:
  repository: leonardtia/qa
  tag: qa-covid19
StageImage:
  repository: leonardtia/stage
  tag: stage-covid19
``

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  {{- if eq .Values.Environment "prod" }}
    image: "{{ .Values.ProdImage.repository }}:{{ .Values.ProdImage.tag | default "jenkins-prod" }}"
    replicast: {{ .Values.ReplicaCount.prod }}
  {{- else if eq .Values.Environment "dev" }}
    image: "{{ .Values.DevImage.repository }}:{{ .Values.DevImage.tag | default "jenkins-dev" }}"
    replicast: {{ .Values.ReplicaCount.dev }}
  {{- else if eq .Values.Environment "stage" }}
    image: "{{ .Values.StageImage.repository }}:{{ .Values.StageImage.tag | default "jenkins-stage" }}"
    replicast: {{ .Values.ReplicaCount.stage }}
  {{- else if eq .Values.Environment "qa" }}
    image: "{{ .Values.QaImage.repository }}:{{ .Values.QaImage.tag | default "jenkins-qa" }}"
    replicast: {{ .Values.ReplicaCount.qa }}
  {{- else }}
    myvalue: "Replicaset Value for each Environment"
    dev: {{ .Values.ReplicaCount.dev }}
    qa: {{ .Values.ReplicaCount.qa }}
    prod: {{ .Values.ReplicaCount.prod }}
    stage: {{ .Values.ReplicaCount.stage }}
  {{- end }}

OR

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  {{- if eq .Values.Environment "prod" }}
  image: "{{ .Values.ProdImage.repository }}:{{ .Values.ProdImage.tag | default "jenkins-prod" }}"
  replicast: {{ .Values.ReplicaCount.prod }}
  {{- else if eq .Values.Environment "dev" }}
  image: "{{ .Values.DevImage.repository }}:{{ .Values.DevImage.tag | default "jenkins-dev" }}"
  replicast: {{ .Values.ReplicaCount.dev }}
  {{- else if eq .Values.Environment "stage" }}
  image: "{{ .Values.StageImage.repository }}:{{ .Values.StageImage.tag | default "jenkins-stage" }}"
  replicast: {{ .Values.ReplicaCount.stage }}
  {{- else if eq .Values.Environment "qa" }}
  image: "{{ .Values.QaImage.repository }}:{{ .Values.QaImage.tag | default "jenkins-qa" }}"
  replicast: {{ .Values.ReplicaCount.qa }}
  {{- else }}
  myvalue: "Replicaset Value for each Environment"
  dev: {{ .Values.ReplicaCount.dev }}
  qa: {{ .Values.ReplicaCount.qa }}
  prod: {{ .Values.ReplicaCount.prod }}
  stage: {{ .Values.ReplicaCount.stage }}
  {{- end }}

OR

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
{{- if eq .Values.Environment "prod" }}
  image: "{{ .Values.ProdImage.repository }}:{{ .Values.ProdImage.tag | default "jenkins-prod" }}"
  replicast: {{ .Values.ReplicaCount.prod }}
{{- else if eq .Values.Environment "dev" }}
  image: "{{ .Values.DevImage.repository }}:{{ .Values.DevImage.tag | default "jenkins-dev" }}"
  replicast: {{ .Values.ReplicaCount.dev }}
{{- else if eq .Values.Environment "stage" }}
  image: "{{ .Values.StageImage.repository }}:{{ .Values.StageImage.tag | default "jenkins-stage" }}"
  replicast: {{ .Values.ReplicaCount.stage }}
{{- else if eq .Values.Environment "qa" }}
  image: "{{ .Values.QaImage.repository }}:{{ .Values.QaImage.tag | default "jenkins-qa" }}"
  replicast: {{ .Values.ReplicaCount.qa }}
{{- else }}
  myvalue: "Replicaset Value for each Environment"
  dev: {{ .Values.ReplicaCount.dev }}
  qa: {{ .Values.ReplicaCount.qa }}
  prod: {{ .Values.ReplicaCount.prod }}
  stage: {{ .Values.ReplicaCount.stage }}
{{- end }}



