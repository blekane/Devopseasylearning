 {{- $relname := .Release.Name -}}
 {{- with .Values.tags }}
 Machine Type: {{ .machine | default "NA" | quote }}
 Rack ID: {{ .rack | quote }}
 Storage Type: {{ .drive | upper | quote }}
 Video Card: {{ .vcard | quote }}
 Release: {{ $relname }}
 {{- end }}
 
 
 helm install --dry-run --debug vartest ./mychart
 
 ~~~~~~~~~~~~~~
 
 LangUsed: |-
   {{- range $index, $topping := .Values.LangUsed }}
   - {{ $index }} : {{ $topping }}
   {{- end }} 
 
 
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 
 tags:
   machine: frontdrive
   rack: 4c
   drive: ssd
   vcard: 8g
   
 
 tags: 
   {{- range $key, $value := .Values.tags }}
   {{ $key }} : {{ $value }}
   {{- end }} 

 ### Global Variables
[Built in Variables](https://helm.sh/docs/chart_template_guide/builtin_objects/)



 labels:
   helm.sh/chart: "{{ $.Chart.Name }}-{{ $.Chart.Version }}"
   app.kubernetes.io/instance: "{{ $.Release.Name }}"
   app.kubernetes.io/version: "{{ $.Chart.AppVersion }}"
   app.kubernetes.io/managed-by: "{{ $.Release.Service }}"