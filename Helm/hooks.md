## Overview: What are Helm Hooks?
[Helm hooks examples in Kubernetes for beginners](https://www.golinuxcloud.com/kubernetes-helm-hooks-examples/)

Hooks perform a single action at a specified point during the release life cycle. 

Hooks are not **directly applied to the Kubernetes environment** during standard processing. Instead, Hooks run in a separate pod inside of your Kubernetes cluster. The value specified in the `helm.sh/hook` annotation determines when the hook should be rendered. This makes it possible to perform operations at specific points during the release life cycle.

## Hook Annotation Values
Helm hooks have several annotation values that are used to specify when a hook should be executed. Overall, there are nine places where a hook could be called.

**pre-install**

Executes after templates are rendered, but before any resources are created in Kubernetes

**post-install**

Executes after all resources are loaded into Kubernetes

**pre-delete**

Executes on a deletion request before any resources are deleted from Kubernetes

**post-delete**	

Executes on a deletion request after all of the release's resources have been deleted

**pre-upgrade**	

Executes on an upgrade request after templates are rendered, but before any resources are updated

**post-upgrade**

Executes on an upgrade request after all resources have been upgraded

**pre-rollback**

Executes on a rollback request after templates are rendered, but before any resources are rolled back

**post-rollback**

Executes on a rollback request after all resources have been modified

**test**
	
Executes when the Helm test subcommand is invoked 

- [Example Test](https://helm.sh/docs/topics/chart_tests/)
```yml
{{- if .Values.mariadb.enabled }}
apiVersion: v1
kind: Pod
metadata:
  name: "{{ .Release.Name }}-credentials-test"
  annotations:
    "helm.sh/hook": test
spec:
  containers:
    - name: {{ .Release.Name }}-credentials-test
      image: {{ template "wordpress.image" . }}
      imagePullPolicy: {{ .Values.image.pullPolicy | quote }}
      {{- if .Values.securityContext.enabled }}
      securityContext:
        runAsUser: {{ .Values.securityContext.runAsUser }}
      {{- end }}
      env:
        - name: MARIADB_HOST
          value: {{ template "mariadb.fullname" . }}
        - name: MARIADB_PORT
          value: "3306"
        - name: WORDPRESS_DATABASE_NAME
          value: {{ default "" .Values.mariadb.db.name | quote }}
        - name: WORDPRESS_DATABASE_USER
          value: {{ default "" .Values.mariadb.db.user | quote }}
        - name: WORDPRESS_DATABASE_PASSWORD
          valueFrom:
            secretKeyRef:
              name: {{ template "mariadb.fullname" . }}
              key: mariadb-password
      command:
        - /bin/bash
        - -ec
        - |
            mysql --host=$MARIADB_HOST --port=$MARIADB_PORT --user=$WORDPRESS_DATABASE_USER --password=$WORDPRESS_DATABASE_PASSWORD
  restartPolicy: Never
{{- end }}
```

**Example:**
[Helm hooks examples in Kubernetes for beginners](https://www.golinuxcloud.com/kubernetes-helm-hooks-examples/)


