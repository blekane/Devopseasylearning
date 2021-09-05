## Declarative pipeline Vs Scripted Pipeline
- A declarative pipeline has a structure defined already that needs to be followed while scripting pipeline is a groovy script that does not have a structure. 

- Declarative pipeline start with the **pipeline definition** while scripted pipeline start with **node definition**

```groovy

node {
	// Scripted Pipeline Here
}
```

```groovy
pipeline {
	// Declarative Pipeline Here
}
```


### Running hello world
- **Agent** indicates that Jenkins should allocate an executor or slave to run the pipeline.
- **Stage:** it is a section of the pipeline such as build, test and so on
- **Steps:** it is the specific instruction to execute the stage.
- **Pipeline:** it is a series of tasks required to build, test and deploy an application from source control into dev, qa and prod.


### Declarative pipeline 
```groovy
pipeline {
    agent any
    stages {
        stage('Hello World') {
            steps {
                echo "Hello World"
            }
        }
        stage('Good Bye') {
            steps {
                echo "Good Bye"
            }
        }
    }
}
```

### Scripted Pipeline
```groovy
node {
    stage('Hello World') {
      echo "Hello World"  
    }
    stage('Good Bye') {
      echo "Good Bye"  
    }
}
```
