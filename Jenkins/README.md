# Jenkins 

### To print all env in jenkins
```groovy
pipeline {
    agent any
    stages {
        stage('env') {
            steps {
                sh "printenv"
            }
        }
    }
}
```