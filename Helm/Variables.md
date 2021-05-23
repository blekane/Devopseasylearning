 ### Variables Syntax
 ```yml
 {{- $relname := .Release.Name -}}
 ```
`$relname` = the name of the variable

`.Release.Name` = the variable value

`:=` = special operator use to assign a variable

### Global Variables

These variables can be access everywhere within the template.

[Built in Variables](https://helm.sh/docs/chart_template_guide/builtin_objects/)

```yml
{{- $relname := .Release.Name -}}
{{- $namespace := .Release.Namespace -}}
{{- $chart_name := .Chart.Name -}}
{{- $chart_version := .Chart.Version -}}
kind: ConfigMap
metadata:
  name: demo-configmap
data:
Release: {{ $relname }}
namespace: {{ $namespace }}
chart_name: {{ $chart_name }}
chart_version: {{ $chart_version }}
  name1: {{ .Chart.Name }}-{{ .Chart.Version }}
  name1: {{ $chart_name }}-{{ $chart_version }}
```

OR 

```yml
kind: ConfigMap
metadata:
  name: demo-configmap
data:
{{- $relname := .Release.Name -}}
{{- $namespace := .Release.Namespace -}}
{{- $chart_name := .Chart.Name -}}
{{- $chart_version := .Chart.Version -}}
Release: {{ $relname }}
namespace: {{ $namespace }}
chart_name: {{ $chart_name }}
chart_version: {{ $chart_version }}
  name1: {{ .Chart.Name }}-{{ .Chart.Version }}
  name1: {{ $chart_name }}-{{ $chart_version }}
```

**RESULT**
```yml
kind: ConfigMap
metadata:
  name: demo-configmap
data:
Release: demo
namespace: dev2
chart_name: mychart
chart_version: 0.1.0
  name1: mychart-0.1.0
  name1: mychart-0.1.0
```

### Labeles
We are accessing the global variables here
```yml
kind: ConfigMap
metadata:
  name: demo-configmap
data:
labels1:
  helm.sh/chart: "{{ $.Chart.Name }}-{{ $.Chart.Version }}"
  app.kubernetes.io/instance: "{{ $.Release.Name }}"
  app.kubernetes.io/version: "{{ $.Chart.AppVersion }}"
  app.kubernetes.io/managed-by: "{{ $.Release.Service }}"
  labels2:
  {{ include "mychart.labels" . | indent 4 }}
```

**RESULT**
```yml
kind: ConfigMap
metadata:
  name: demo-configmap
data:
labels1:
  helm.sh/chart: "mychart-0.1.0"
  app.kubernetes.io/instance: "demo"
  app.kubernetes.io/version: "1.0"
  app.kubernetes.io/managed-by: "Tiller"
  labels2:
    app.kubernetes.io/name: mychart
    helm.sh/chart: mychart-0.1.0
    app.kubernetes.io/instance: demo
    app.kubernetes.io/version: "1.0"
    app.kubernetes.io/managed-by: Tiller
```





 