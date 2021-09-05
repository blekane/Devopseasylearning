
## Pipeline structure
```groovy
pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
              echo "Cloning the source code........" 
            }
        }
        stage('Compile') {
            steps {
               echo "Compiling the application........" 
            }
        }
          stage('Test') {
            steps {
              echo "Testing the application........" 
            }
        }
        stage('Build') {
            steps {
               echo "Building the application........"
            }
        }
        stage('Package') {
            steps {
               echo "Packaging the application........"
            }
        }
        stage('Docker-build') {
            steps {
               echo "Biulding docker image........"
            }
        }
        stage('Docker-push') {
            steps {
               echo "Pushing docker image into AWS ECR or docker hub........"
            }
        }
        stage('Deploy') {
            steps {
               echo "Deploying the application into Kubernetes........"
            }
        }
    }
}


OR

node {
    stage('Checkout') {
      echo "Cloning the source code........"  
    }
    stage('Compile') {
      echo "Compiling the application........"  
    }
    stage('Test') {
      echo "Testing the application........"
    }
    stage('Build') {
      echo "Building the application........"
    }
    stage('Package') {
      echo "Packaging the application........"
    }
    stage('Docker-build') {
      echo "Biulding docker image........"
    }
    stage('Deploy') {
      echo "Deploying the application into Kubernetes........"
    }
}
```


## Pipeline structure with post nofication

**NB:** This will help us to send out email or Slack notifications

```groovy
pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
              echo "Cloning the source code........" 
            }
        }
        stage('Compile') {
            steps {
               echo "Compiling the application........" 
            }
        }
          stage('Test') {
            steps {
              echo "Testing the application........" 
            }
        }
        stage('Build') {
            steps {
               echo "Building the application........"
            }
        }
        stage('Package') {
            steps {
               echo "Packaging the application........"
            }
        }
        stage('Docker-build') {
            steps {
               echo "Biulding docker image........"
            }
        }
        stage('Docker-push') {
            steps {
               echo "Pushing docker image into AWS ECR or docker hub........"
            }
        }
        stage('Deploy') {
            steps {
               echo "Deploying the application into Kubernetes........"
            }
        }
        
    }
    post {
        success {
            echo 'Finished with status: SUCCESS ===> GOOD JOB GUYS!'
        }

        failure {
            echo 'Finished with status: FAILED ===> Please check the console output to fix this job IMMEDIATELY ===> THANKS.'
        }
        unstable {
            echo 'Finished with status: UNSTABLE ===> Please check the console output to fix this job IMMEDIATELY ===> THANKS.' 
        }
    }        
}










