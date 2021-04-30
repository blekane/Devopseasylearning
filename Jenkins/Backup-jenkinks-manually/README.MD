### Backup jenkins jobs manually and download it into you locall computer then uplaod into AWS S3

* Login into a pod
```
kubectl exec -it jenkins-6b89886554-wm2kd bash
```
* Move into the job folder
```
cd /var/jenkins_home/jobs
```
* Tar all jobs
```
tar -cvf jenkins_backup.tar .
```
* Copy from pod to you local Linux server. This will copy jenkins_backup.tar and put it in the current directory on a Linux server
```
kubectl cp jenkins-6b89886554-wm2kd:/var/jenkins_home/jobs/jenkins_backup.tar ./jenkins_backup.tar -n cicd
```
* Copy from a Linux server to you local Windows machine
```
mv jenkins_backup.tar /home/tia/
scp -r jenkins_backup.tar tia@10.0.0.5:/home/tia/ .
```
* Uplaod it into AWS S3 bucket
* Remove the backup from the cluster
```
kubectl exec -it jenkins-6b89886554-wm2kd bash
cd /var/jenkins_home/jobs
rm -rf jenkins_backup.tar 
```



