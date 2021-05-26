### Helm lint
It is used to test the chart for any error or syntax errors. Before deploying your chart in the Kubernetes cluster, always run a `helm lint` command to check for errors
```
helm lint [chart folder location]
helm lint ./mychart/
```

You can also moved into the chart folder and just run the `helm lint` command

```
cd mychart
helm lint 
```

### Test connection
- After install the chart, we can check if the deployment was `Succeeded` or not.
- In the template folder, we have a `test-connection.yaml` script that we can use to test if the deployment was `Succeeded` or not.
- When we test the connection, a pod will be created cluste with the container call `wget`, the image cat `busybox` and run the `wget` inside that pod. if the `exit code` of the `wget` is equal to `zero`, the test result will be `Succeeded`. Else, it will failed

### Test connection script
```yml
apiVersion: v1
kind: Pod
metadata:
  name: "{{ include "mychart.fullname" . }}-test-connection"
  labels:
    {{- include "mychart.labels" . | nindent 4 }}
  annotations:
    "helm.sh/hook": test
spec:
  containers:
    - name: wget 
      image: busybox
      command: ['wget']
      args: ['{{ include "mychart.fullname" . }}:{{ .Values.service.port }}']
  restartPolicy: Never
```
### connect to run the test
```
helm install demo ./mychart/
helm test [the release name]

helm test [the release name]
helm test demo
```

**RESULT:**
```yml
root@controlplane:~# helm test demo
NAME: demo
LAST DEPLOYED: Wed May 26 09:53:47 2021
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE:     demo-mychart-test-connection
Last Started:   Wed May 26 10:10:41 2021
Last Completed: Wed May 26 10:10:47 2021
Phase:          Succeeded
```

**Check pods**
```
demo-mychart-695c75bb4c-cgtjw   1/1     Running     0          2m29s
demo-mychart-test-connection    0/1     Completed   0          29s
```