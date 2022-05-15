### With Statement in Helm Chart 
It is use to evaluate a condition or to read a collection of values in from the values file.

### With Statement Syntax
[Modifying scope using with](https://helm.sh/docs/chart_template_guide/control_structures/)

```yml
{{ with PIPELINE }}
  # restricted scope
{{ end }}
```

### Example 1
```yml
tags:
   machine: frontdrive
   rack: 4c
   drive: ssd
   vcard: 8g
```

```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  {{- with .Values.tags }}
  Machine Type: {{ .machine | default "NA" | quote }}
  Rack ID: {{ .rack | quote }}
  Storage Type: {{ .drive | upper | quote }}
  Video Card: {{ .vcard | quote }}
  {{- end }}
```

**Result**
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: demo-configmap
data:
  Machine Type: "frontdrive"
  Rack ID: "4c"
  Storage Type: "SSD"
  Video Card: "8g"
```

```yml
{{ with PIPELINE }}
  # restricted scope
{{ end }}
```

### Example 2
```yml
resources: 
  limits:
    cpu: 2
    memory: 4G
  requests:
    cpu: 1
    memory: 2G
```

```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
resources:
{{- toYaml .Values.resources | nindent 4 }}
```

**Result**
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: demo-configmap
data:
  Machine Type: "frontdrive"
  Rack ID: "4c"
  Storage Type: "SSD"
  Video Card: "8g"
```

### Example 3
- `toYaml`: read a bloc of code from the values file. 
- `nindent`: specify the number of space from left to right
- This will not be a valid YAML because the indentation is 0
```yml
resources: 
  limits:
    cpu: 2
    memory: 4G
  requests:
    cpu: 1
    memory: 2G
```

```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
resources:
{{- toYaml .Values.resources | nindent 0 }}
```

**Result**
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: demo-configmap
data:
resources:
limits:
  cpu: 2
  memory: 4G
requests:
  cpu: 1
  memory: 2G
```

### Example 4
- `toYaml`: read a bloc of code from the values file. 
- `nindent`: specify the number of space from left to right
- This will be a valid YAML because the indentation is 2
```yml
resources: 
  limits:
    cpu: 2
    memory: 4G
  requests:
    cpu: 1
    memory: 2G
```

```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
resources:
{{- toYaml .Values.resources | nindent 2 }}
```

**Result**
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: demo-configmap
data:
resources:
  limits:
    cpu: 2
    memory: 4G
  requests:
    cpu: 1
    memory: 2G
```


### Example 5
This is one example where resources are not defined in the values file.
```yml
resources: {} 
nodeSelector: {}
tolerations: []
affinity: {}
```

`nodeSelector, affinity, tolerations` will be execute only if they are defined in the values file. They will not be executed if they are not defined in the values file.
```yml
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
This is one example where resources are defined in the values file.

`nodeSelector, affinity, tolerations` will be execute only if they are defined in the values file. They will not be executed if they are not defined in the values file.

**Values file**
```yml
resources: 
  limits:
    cpu: 2
    memory: 4G
  requests:
    cpu: 1
    memory: 2G

nodeSelector:
  Linux: Node1

tolerations:
- key: "key1"
  operator: "Equal"
  value: "value1"
  effect: "NoSchedule"

affinity:
  podAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
      - labelSelector:
          matchExpressions:
          - key: security
            operator: In
            values:
```

```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: demo-configmap
data:
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
            {{- toYaml .Values.resources | nindent 12 }} # 12 space from left to right. This is because the resource block need to be under resources
            {{- with .Values.nodeSelector }}
      nodeSelector:
        {{- toYaml . | nindent 8 }} # 8 space from left to right 
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

**Result**
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: demo-configmap
data:
apiVersion: apps/v1
kind: Deployment
metadata:
  name: demo-mychart
  labels:
    app.kubernetes.io/name: mychart
    helm.sh/chart: mychart-0.1.0
    app.kubernetes.io/instance: demo
    app.kubernetes.io/version: "1.0"
    app.kubernetes.io/managed-by: Tiller
spec:
  replicas: map[dev:1 prod:3 qa:1]
  selector:
    matchLabels:
      app.kubernetes.io/name: mychart
      app.kubernetes.io/instance: demo
  template:
    metadata:
      labels:
        app.kubernetes.io/name: mychart
        app.kubernetes.io/instance: demo
    spec:
      serviceAccountName: demo-mychart
      securityContext:
        {}
        
      containers:
        - name: mychart
          securityContext:
            capabilities:
              drop:
              - ALL
            readOnlyRootFilesystem: true
            runAsNonRoot: true
            runAsUser: 1000
            
          image: "leonardtia/devops-test-repo:covid19"
          imagePullPolicy: IfNotPresent
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
            limits:
              cpu: 2
              memory: 4G
            requests:
              cpu: 1
              memory: 2G
            
      nodeSelector:
        Linux: Node1
        
      affinity:
        podAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchExpressions:
              - key: security
                operator: In
                values: null
        
      tolerations:
        - effect: NoSchedule
          key: key1
          operator: Equal
          value: value1
```

### Example 5 (let change the indentation and see the result)
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: demo-configmap
data:
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
            {{- toYaml .Values.resources | nindent 12 }} # 12 space from left to right. This is because the resource block need to be under resources
            {{- with .Values.nodeSelector }}
      nodeSelector:
        {{- toYaml . | nindent 8 }} # 8 space from left to right 
        {{- end }}
        {{- with .Values.affinity }}
      affinity:
        {{- toYaml . | nindent 4 }}
        {{- end }}
        {{- with .Values.tolerations }}
      tolerations:
        {{- toYaml . | nindent 0 }}
        {{- end }}
```

```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: demo-configmap
data:
apiVersion: apps/v1
kind: Deployment
metadata:
  name: demo-mychart
  labels:
    app.kubernetes.io/name: mychart
    helm.sh/chart: mychart-0.1.0
    app.kubernetes.io/instance: demo
    app.kubernetes.io/version: "1.0"
    app.kubernetes.io/managed-by: Tiller
spec:
  replicas: map[dev:1 prod:3 qa:1]
  selector:
    matchLabels:
      app.kubernetes.io/name: mychart
      app.kubernetes.io/instance: demo
  template:
    metadata:
      labels:
        app.kubernetes.io/name: mychart
        app.kubernetes.io/instance: demo
    spec:
      serviceAccountName: demo-mychart
      securityContext:
        {}
        
      containers:
        - name: mychart
          securityContext:
            capabilities:
              drop:
              - ALL
            readOnlyRootFilesystem: true
            runAsNonRoot: true
            runAsUser: 1000
            
          image: "leonardtia/devops-test-repo:covid19"
          imagePullPolicy: IfNotPresent
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
                    limits:
                      cpu: 2
                      memory: 4G
                    requests:
                      cpu: 1
                      memory: 2G
                     
      nodeSelector:
  Linux: Node1

      affinity:
    podAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
      - labelSelector:
          matchExpressions:
          - key: security
            operator: In
            values: null
    
      tolerations:
- effect: NoSchedule
  key: key1
  operator: Equal
  value: value1
```
