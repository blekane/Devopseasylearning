## Multibranch Pipeline job configuration
* [Create Multibranch Pipeline with Git](https://www.youtube.com/watch?v=tuxO7ZXplRE&t=1s)

* [Trigger Jenkins Build automatically](https://www.youtube.com/watch?v=CmwTPxdx24Y)

* [Code link](https://github.com/leonardtia1/pipeline-groovy-test.git)
```
.* 

.*(dev|dev1|dev2|qa|).*

^dev1|dev2|dev3|qa1|qa2.*$

^prod1|prod2.*$
```

### Access to all the jobs in the folder and sub folder
```
name: "ecommerce-microservices-subfolders"
pattern: "^ecommerce-microservices/.*"
```

### Access to only ecommerce-microservices 
* User in here can only delete ecommerce-microservices folder. He cannot do anything else
* This is not good for assigning permission
```
name: "ecommerce-microservices"
pattern: "^*ecommerce-microservices*"
```

### All jobs
```
name: all-jobs
pattern: .*
```

### Recover Jenkins from back
kubectl cp jenkins_backup.tar -n cicd jenkins-sandbox-744fb6fbd4-85htq:/var/jenkins_home/jobs
tar -vxf jenkins_backup.tar -C /var/jenkins_home/jobs
rm -rf jenkins_backup.tar