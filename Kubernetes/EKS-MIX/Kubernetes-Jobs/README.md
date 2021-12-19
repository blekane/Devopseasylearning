### Jobs in Kubernetes
- It job a task in kubernetes
- A Job creates one or more Pods and will continue to retry execution of the Pods until a specified number of them successfully terminate. As pods successfully complete, the Job tracks the successful completions. When a specified number of successful completions is reached, the task (ie, Job) is complete. Deleting a Job will clean up the Pods it created.


### We have two types of job in kubernetes:
- Cron job 
- Run to completion

### Cron job  
- It schedule to run as a cron on a particular schedule
- it might be used to collect metrics
- you can schedule a pod that will come up every 10 minutes, collect metrics and dies
- it can be used to back up of the DB at a particular time (3AM for instance)

### Run to completion
- it runs only once and stop 
- You can scedule the Run to completion to restore a DB with the restore script only if the DB pod restart for install. 

### What is the difference betweem Cron job  and Run to completion job
Cron job run is a pod that starts at a conseuty interval of timen perform a specify task and die and Run to completion job is the pod that only run once, perform a specify task and stop. 


```yml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: hello
spec:
  schedule: "*/1 * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: hello
            image: busybox
            imagePullPolicy: IfNotPresent
            command:
            - /bin/sh
            - -c
            - date; echo Hello from the Kubernetes cluster
          restartPolicy: OnFailure
```