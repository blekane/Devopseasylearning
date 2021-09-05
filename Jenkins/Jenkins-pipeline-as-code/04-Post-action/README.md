##  Post Action in Jenikinsfile

**Post:**
- This helps execute some logic after all stages are executed.
- It can be very helpful to notify the team about the status of the build such as sending **out notification**.

**We have 6 post build condition:**
- **Started:** this will execute only if the build started.
- **Always:** this will always execute no matter if the build failed or succeed.
- **Success:** this will execute only if the build succeeded.
- **Failure:** this will execute only if the build failed.
- **Changed:** only run if the current Pipeline run has a different status from the previously completed
- **Unstable:** this will execute only if the build is unstable. An example is to fialed the copy an artifact to a remote server.


```groovy
pipeline {
    agent any
    stages {
        stages('Example') {
            steps {
               echo 'Hello World' 
            }
        }
    }
    post {
        always {
            echo 'I will always say Hello again!'
        }
    }
}
```

```groovy
pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
              echo "Cloning the source code........" 
            }
        }
        stage('compile') {
            steps {
               echo "Compiling the application........" 
            }
        }
        stage('build') {
            steps {
               echo "Building the application........"
            }
        }
        stage('test') {
            steps {
              echo "Testing the application........" 
            }
        }
        stage('package') {
            steps {
               echo "Packaging the application........"
            }
        }
        stage('deploy') {
            steps {
               echo "Deploying the application........"
            }
        }
    }
    post {
        always {
            echo "This will always execute no matter if the build failed or succeed"
        }
        success {
            echo "This will execute only if the build succeeded"
        }
        failure {
            echo "This will execute only if the build failed"
        }
        unstable {
            echo "This will execute only if the build is unstable"
        }
    }
}
```