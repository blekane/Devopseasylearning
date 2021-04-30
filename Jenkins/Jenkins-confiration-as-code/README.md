### 
* [Jenkins config as code](https://github.com/jenkinsci/configuration-as-code-plugin)


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