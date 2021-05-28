
## Include, Template and Helpers Functions

## EXAMPLE 1
**Helpers function in _helpers.tpl**
```yml
{{- define "mychart.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}
```
**Values file**

```
fullnameOverride: " "
```

**Deployment file**
```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "mychart.fullname" . }}
```
OR

```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ template "mychart.fullname" . }}
```

**RESULT**

The deployment name will be the chart folder name and the release name because we didn't override the full name through the CLI.
```
helm install demo  --dry-run --debug ./mychart/
```
```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: demo-mychart
```

## EXAMPLE 2
**Helpers function in _helpers.tpl**
```yml
{{- define "mychart.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}
```
**Values file**

If we don't set any value for `fullnameOverride` in the values file, we can set in through the command line while we are deploying the application with `fullnameOverride=nginx` for instance so that the name will change in the whole template to `ngnix` instead of **the chart folder name and the release name** such as `demo-mychart`
```
fullnameOverride: " "
```

**Deployment file**
```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "mychart.fullname" . }}-test
```
OR

**Deployment file**
```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ template "mychart.fullname" . }}-test
```

**RESULT**

The deployment name will not be the chart folder name and the release name because it was overwritten through the CLI
```
helm install jenkins-test --dry-run --debug ./mychart/  --set fullnameOverride=nginx
```

```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-test
```

## EXAMPLE 3
**Helpers function in _helpers.tpl**
```yml
{{- define "mychart.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}
```
**Values file**

If we set any value for `fullnameOverride`, we have 2 options here. We can just deploy the application without overwritting the full name because it was set already in the value file or we can still change it through the CLI if we want to overiwrite the default vaule in the values file.
```
fullnameOverride: "nginx"
```

**Deployment file**
```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "mychart.fullname" . }}-test
```

OR 

```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ template "mychart.fullname" . }}-test
```

**RESULT 1**

The deployment name will not be the chart folder name and the release name because it was overwritten through the CLI
```
helm install jenkins-test --dry-run --debug ./mychart/
```

```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-test
```

**RESULT 2**

The deployment name will not be the chart folder name and the release name because it was overwritten through the CLI
```
helm install jenkins --dry-run --debug ./mychart/  --set fullnameOverride=jenkins
```

```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: jenkins-test
```

## EXAMPLE 4
We can define another template and include it in our template or use it in other location. It works like **function** in other programing languages where you can define a block of code and use it as needed in you code.

Let create a configmap and add another template in

```
vim configmap.yml
```
```yml
{{- define "mychart.systemlabels" -}}
labels:
  drive: ssd
  machine: frontdrive
  rack: 4c
  vcard: 8g
{{- end }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
{{- include "mychart.systemlabels" . | nindent 2 }}
```
**RESULT WITH INCLUDE**
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: jenkins-configmap
  labels:
    drive: ssd
    machine: frontdrive
    rack: 4c
    vcard: 8g
```

```
vim configmap.yml
```
```yml
{{- define "mychart.systemlabels" -}}
labels:
  drive: ssd
  machine: frontdrive
  rack: 4c
  vcard: 8g
{{- end }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
{{- template "mychart.systemlabels" }}
```
**RESULT WITH TEMPLATE**
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: jenkins-configmaplabels:
  drive: ssd
  machine: frontdrive
  rack: 4c
  vcard: 8g
```


## EXAMPLE 5

Let create a configmap and add another template from the helpers file.

```
vim configmap.yml
```
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
{{- include "mychart.systemlabels" . | nindent 2 }}
```

```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
{{- include "mychart.systemlabels" }}
```

This is what is recommanded. To added the function on templates in the helpers file and `include` it in the man template.
```
vim _helpers.tpl
```
```yml
{{- define "mychart.systemlabels" -}}
labels:
  drive: ssd
  machine: frontdrive
  rack: 4c
  vcard: 8g
{{- end }}
```

**RESULT WITH INCLUDE**
```
helm install jenkins-test --dry-run --debug ./mychart/
```
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: jenkins-test-configmap
  labels:
    drive: ssd
    machine: frontdrive
    rack: 4c
    vcard: 8g
```

**RESULT WITH TEMPLATE**
```
helm install jenkins-test --dry-run --debug ./mychart/
```
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: jenkins-test-configmap
  labels:
    drive: ssd
    machine: frontdrive
    rack: 4c
    vcard: 8g
```

## EXAMPLE 6
If the template have the build in objects like `.Release.Name`, `.Chart.AppVersion`, add the `.` or `$` so that it the build in objects can be read. 

**NB:** `$` is more recommanded to read build in objects or env variables.

```
{{- template "mychart.systemlables" . }}
   
{{- template "mychart.systemlables" $ }}
```
```
vim _helpers.tpl
```
```yml
{{- define "mychart.systemlabels" }}
  labels:
    drive: ssd
    machine: frontdrive
    rack: 4c
    vcard: 8g
    app.kubernetes.io/instance: "{{ $.Release.Name }}"
    app.kubernetes.io/version: "{{ $.Chart.AppVersion }}"
    app.kubernetes.io/managed-by: "{{ $.Release.Service }}"
{{- end }}
```   

```
vim configmap.yml
```
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
{{- include "mychart.systemlabels" $ | nindent 2 }}
```
OR 

```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
{{- include "mychart.systemlabels" . | nindent 2 }}
```
OR

```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
{{- template "mychart.systemlabels" . }}
```
OR

```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
{{- template "mychart.systemlabels" $ }}
```

**RESULT**
```yml
kind: ConfigMap
metadata:
  name: jenkins-test-configmap
  labels:
    drive: ssd
    machine: frontdrive
    rack: 4c
    vcard: 8g
    app.kubernetes.io/instance: "jenkins-test"
    app.kubernetes.io/version: "1.0"
    app.kubernetes.io/managed-by: "Tiller"
```

### What is the difference between template and include function in helm chart?
The **include** function allows you to bring in another template, and then pass the results to other helm functions while **template** alows you to bring another template but you cannot pass the results to other helm functions.

**NB:** include is recommanded to import a template into the main template because we can have a proper indentation with pipe function in different file. 

With `template`, we might not know exactly where the template with be import base on indentation and we might run into an issue with `yaml` syntax.

```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
{{- include "mychart.systemlabels" . | nindent 2 }}
```

```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
{{- template "mychart.systemlabels" }}
```
This will gie you an error if you use another helm function with template.
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
{{- template "mychart.systemlabels" . | nindent 2 }}
```

**We will have the wrong indentation here with template**
```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "mychart.fullname" . }}
  labels:
{{ include "mychart.labels" . | indent 4 }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app.kubernetes.io/name: {{ include "mychart.name" . }}
      app.kubernetes.io/instance: {{ .Release.Name }}
  template:
    metadata:
      labels:
        app.kubernetes.io/name: {{ include "mychart.name" . }}
        app.kubernetes.io/instance: {{ .Release.Name }}
    spec:
    {{- with .Values.imagePullSecrets }}
      imagePullSecrets:
        {{- toYaml . | nindent 8 }}
    {{- end }}
      serviceAccountName: {{ template "mychart.serviceAccountName" . }}
      securityContext:
        {{- toYaml .Values.podSecurityContext | nindent 8 }}
      containers:
        - name: {{ .Chart.Name }}
          securityContext:
            {{- toYaml .Values.securityContext | nindent 12 }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          imagePullPolicy: {{ .Values.image.pullPolicy }}
          # {{- template "mychart.systemlabels" $ }}
          ports:
            - name: http
              containerPort: 80
              protocol: TCP
          livenessProbe:
            httpGet:
              path: /
              port: http
          readinessProbe:
            httpGet:
              path: /
              port: http
          resources:
            {{- toYaml .Values.resources | nindent 12 }}
      {{- with .Values.nodeSelector }}
      nodeSelector:
        {{- toYaml . | nindent 8 }}
      {{- end }}
    {{- with .Values.affinity }}
      affinity:
        {{- toYaml . | nindent 8 }}
    {{- end }}
    {{- with .Values.tolerations }}
      tolerations:
        {{- toYaml . | nindent 8 }}
    {{- end }}
```
**RESULT**
```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: jenkins-test-mychart
  labels:
    app.kubernetes.io/name: mychart
    helm.sh/chart: mychart-0.1.0
    app.kubernetes.io/instance: jenkins-test
    app.kubernetes.io/version: "1.0"
    app.kubernetes.io/managed-by: Tiller
spec:
  replicas: 1
  selector:
    matchLabels:
      app.kubernetes.io/name: mychart
      app.kubernetes.io/instance: jenkins-test
  template:
    metadata:
      labels:
        app.kubernetes.io/name: mychart
        app.kubernetes.io/instance: jenkins-test
    spec:
      serviceAccountName: jenkins-test-mychart
      securityContext:
        {}
        
      containers:
        - name: mychart
          securityContext:
            {}
            
          image: "nginx:stable"
          imagePullPolicy: IfNotPresent
  # labels:
  #   drive: ssd
  #   machine: frontdrive
  #   rack: 4c
  #   vcard: 8g
  #   app.kubernetes.io/instance: "jenkins-test"
  #   app.kubernetes.io/version: "1.0"
  #   app.kubernetes.io/managed-by: "Tiller"
          ports:
            - name: http
              containerPort: 80
              protocol: TCP
          livenessProbe:
            httpGet:
              path: /
              port: http
          readinessProbe:
            httpGet:
              path: /
              port: http
          resources:
            {}
```


**We will have the rigth indentation here with include**
```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "mychart.fullname" . }}
  labels:
{{ include "mychart.labels" . | indent 4 }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app.kubernetes.io/name: {{ include "mychart.name" . }}
      app.kubernetes.io/instance: {{ .Release.Name }}
  template:
    metadata:
      labels:
        app.kubernetes.io/name: {{ include "mychart.name" . }}
        app.kubernetes.io/instance: {{ .Release.Name }}
    spec:
    {{- with .Values.imagePullSecrets }}
      imagePullSecrets:
        {{- toYaml . | nindent 8 }}
    {{- end }}
      serviceAccountName: {{ template "mychart.serviceAccountName" . }}
      securityContext:
        {{- toYaml .Values.podSecurityContext | nindent 8 }}
      containers:
        - name: {{ .Chart.Name }}
          securityContext:
            {{- toYaml .Values.securityContext | nindent 12 }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          imagePullPolicy: {{ .Values.image.pullPolicy }}
          # {{- include "mychart.systemlabels" $ | nindent 8 }}
          ports:
            - name: http
              containerPort: 80
              protocol: TCP
          livenessProbe:
            httpGet:
              path: /
              port: http
          readinessProbe:
            httpGet:
              path: /
              port: http
          resources:
            {{- toYaml .Values.resources | nindent 12 }}
      {{- with .Values.nodeSelector }}
      nodeSelector:
        {{- toYaml . | nindent 8 }}
      {{- end }}
    {{- with .Values.affinity }}
      affinity:
        {{- toYaml . | nindent 8 }}
    {{- end }}
    {{- with .Values.tolerations }}
      tolerations:
        {{- toYaml . | nindent 8 }}
    {{- end }}
  ```

**RESULT**
  ```yml
  apiVersion: apps/v1
kind: Deployment
metadata:
  name: jenkins-test-mychart
  labels:
    app.kubernetes.io/name: mychart
    helm.sh/chart: mychart-0.1.0
    app.kubernetes.io/instance: jenkins-test
    app.kubernetes.io/version: "1.0"
    app.kubernetes.io/managed-by: Tiller
spec:
  replicas: 1
  selector:
    matchLabels:
      app.kubernetes.io/name: mychart
      app.kubernetes.io/instance: jenkins-test
  template:
    metadata:
      labels:
        app.kubernetes.io/name: mychart
        app.kubernetes.io/instance: jenkins-test
    spec:
      serviceAccountName: jenkins-test-mychart
      securityContext:
        {}
        
      containers:
        - name: mychart
          securityContext:
            {}
            
          image: "nginx:stable"
          imagePullPolicy: IfNotPresent
        
          # labels:
          #   drive: ssd
          #   machine: frontdrive
          #   rack: 4c
          #   vcard: 8g
          #   app.kubernetes.io/instance: "jenkins-test"
          #   app.kubernetes.io/version: "1.0"
          #   app.kubernetes.io/managed-by: "Tiller"
          ports:
            - name: http
              containerPort: 80
              protocol: TCP
          livenessProbe:
            httpGet:
              path: /
              port: http
          readinessProbe:
            httpGet:
              path: /
              port: http
          resources:
            {}
```