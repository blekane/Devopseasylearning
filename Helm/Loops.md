## Loops in Helm chart
**Values file**
```yml
LangUsed:
  - Python
  - Ruby
  - Java
  - Scala
```
The below code will loop through all the languages to use, quotes them and put all of them in the title format.

```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: demo-configmap
data:
LangUsed1: |-
  {{- range .Values.LangUsed }}
  - {{ . | title | quote }}
  {{- end }}  

LangUsed2: |-
{{- toYaml .Values.LangUsed | nindent 2 }}

LangUsed3: 
{{- toYaml .Values.LangUsed | nindent 2 }}
```

**Result:**
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: demo-configmap
data:
LangUsed1: |-
  - "Python"
  - "Ruby"
  - "Java"
  - "Scala"  

LangUsed2: |-
  - Python
  - Ruby
  - Java
  - Scala
  
LangUsed3:
  - Python
  - Ruby
  - Java
  - Scala
```