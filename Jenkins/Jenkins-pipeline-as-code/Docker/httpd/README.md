
# Building an image with simple steps


### Checkout from VCS
NB: don't forget to change `master` to `main` or if the branch is `main` while generating the pipeline syntax.
```
checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'GitHub-Credentials', url: 'https://github.com/leonardtia1/dockerfile.git']]])
```
![](/images/jenkins25.JPG)


### Checkout stage
```groovy
pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                 checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'GitHub-Credentials', url: 'https://github.com/leonardtia1/dockerfile.git']]]) 
            }
        }
    }
}
```


### Check the code in the workspace and the workspace URL
```groovy
pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                 checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'GitHub-Credentials', url: 'https://github.com/leonardtia1/dockerfile.git']]]) 
            }
        }
         stage('Info') {
            steps {
                echo "The job name is: ${JOB_NAME}"
                echo "The workspace is: ${WORKSPACE}"
            }   
        }
    }
}
```

```
The workspace is: /var/lib/jenkins/workspace/test

root@tia-Predator-G3-605:~# cd /var/lib/jenkins/workspace/test
root@tia-Predator-G3-605:/var/lib/jenkins/workspace/test# ls
Dockerfile  
README.md
```

### Adding some ENV
```groovy
pipeline {
    agent any
    environment {
        REPOSITORY='leonardtia/devops-test-repo'
        TAG='addressbook'

    }
    stages {
        stage('Checkout') {
            steps {
                 checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'GitHub-Credentials', url: 'https://github.com/leonardtia1/dockerfile.git']]]) 
            }
        }
        stage('Workspace Info') {
            steps {
                echo "The job name is: ${JOB_NAME}"
                echo "The workspace is: ${WORKSPACE}"
            }   
        }
        stage('ENV Info') {
            steps {
                echo "The job the image fill url: ${REPOSITORY}:${TAG}-${BUILD_NUMBER}"
            }   
        }
    }
}
```

```
The job the image fill url: leonardtia/devops-test-repo:addressbook-48
```

### Building the docker image

You will get this error message the first time because we need to add jenkins user in the docker group and give all the users within the docker group to run all command without password
```
Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get http://%2Fvar%2Frun%2Fdocker.sock/v1.24/images/json: dial unix /var/run/docker.sock: connect: permission denied
```

* Install `CloudBees Docker Build and Publish` plugin
* Add a user Jenkins to a docker group `usermod -aG docker jenkins`
* Change the permissions of docker socket to be able to connect to the docker daemon `chmod 666 /var/run/docker.sock`
* The dockerfile should be in VCS

```
cat /etc/passwd |grep jenkins
cat /etc/group |grep docker
id jenkins

sudo usermod -aG docker jenkins
chmod 777 /var/run/docker.sock

sudo vim /etc/sudoers
%docker ALL=(ALL) NOPASSWD: ALL

sudo systemctl restart docker
```

```groovy
pipeline {
    agent any
    environment {
        REPOSITORY='leonardtia/devops-test-repo'
        TAG='addressbook'

    }
    stages {
        stage('Checkout') {
            steps {
                 checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'GitHub-Credentials', url: 'https://github.com/leonardtia1/dockerfile.git']]]) 
            }
        }
        stage('Workspace Info') {
            steps {
                echo "The job name is: ${JOB_NAME}"
                echo "The workspace is: ${WORKSPACE}"
            }   
        }
        stage('ENV Info') {
            steps {
                echo "The job the image fill url: ${REPOSITORY}:${TAG}-${BUILD_NUMBER}"
            }   
        }
        stage('Docker Build') {
            steps {
                sh '''
                 #!/bin/bash
                 cd ${WORKSPACE}
                 ls -la
                 docker images
                 sudo docker build -t ${REPOSITORY}:${TAG}-${BUILD_NUMBER} .
                 docker images
                ''' 
            }   
        }
    }
}
```

### Run the image to create a container

**We need to open ports on the server**

1. Centos
```
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --zone=public --add-port=8080/tcp --permanent
firewall-cmd --reload
```

2. Ubuntu
ufw enable
ufw allow 80/tcp
ufw allow 8080/tcp
ufw reload

```groovy
pipeline {
    agent any
    environment {
        REPOSITORY='leonardtia/devops-test-repo'
        TAG='covid19'
        CONTAINER_PORT='80'
    }
    stages {
        stage('Checkout') {
            steps {
                 checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'GitHub-Credentials', url: 'https://github.com/leonardtia1/dockerfile.git']]]) 
            }
        }
        stage('Workspace Info') {
            steps {
                echo "The job name is: ${JOB_NAME}"
                echo "The workspace is: ${WORKSPACE}"
            }   
        }
        stage('ENV Info') {
            steps {
                echo "The job the image fill url: ${REPOSITORY}:${TAG}-${BUILD_NUMBER}"
            }   
        }
        stage('Docker Build') {
            steps {
                sh '''
                 #!/bin/bash
                 cd ${WORKSPACE}
                 ls -la
                 docker images
                 docker build -t ${REPOSITORY}:${TAG}-${BUILD_NUMBER} .
                 docker images
                ''' 
            }   
        }
        stage('Run-Image') {
            steps {
                sh '''
                 #!/bin/bash
                 docker images
                 docker run \
                    -d \
                    -p 80${BUILD_NUMBER}:${CONTAINER_PORT} \
                    --name=${TAG}-$BUILD_NUMBER \
                    ${REPOSITORY}:${TAG}-$BUILD_NUMBER
                docker ps
                ''' 
            }
        }   
    }
}
```

```
docker run -d -p 8068:80 --name=covid19-68 leonardtia/devops-test-repo:covid19-68
```


### Get the application URL
```groovy
pipeline {
    agent any
    environment {
        REPOSITORY='leonardtia/devops-test-repo'
        TAG='covid19'
        CONTAINER_PORT='80'
        HOST_NAME_OR_IP='http:10.0.0.10'
        registryCredential = 'docker-hub'
        dockerImage = ''
    }
    stages {
        stage('Checkout') {
            steps {
                 checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'GitHub-Credentials', url: 'https://github.com/leonardtia1/dockerfile.git']]]) 
            }
        }
        stage('Workspace Info') {
            steps {
                echo "The job name is: ${JOB_NAME}"
                echo "The workspace is: ${WORKSPACE}"
            }   
        }
        stage('ENV Info') {
            steps {
                echo "The job the image fill url: ${REPOSITORY}:${TAG}-${BUILD_NUMBER}"
            }   
        }
        stage('Docker Build') {
            steps {
                sh '''
                 #!/bin/bash
                 cd ${WORKSPACE}
                 ls -la
                 docker images
                 docker build -t ${REPOSITORY}:${TAG}-${BUILD_NUMBER} .
                 docker images
                ''' 
            }   
        }
        stage('Run-Image') {
            steps {
                sh '''
                 #!/bin/bash
                 docker images
                 docker run \
                    -d \
                    -p 80${BUILD_NUMBER}:${CONTAINER_PORT} \
                    --name=${TAG}-${BUILD_NUMBER} \
                    ${REPOSITORY}:${TAG}-${BUILD_NUMBER}
                docker ps
                ''' 
            }
        }
        stage('App URL') {
            steps {
                sh '''
                 #!/bin/bash
                 echo "Use this URL to access you application: ${HOST_NAME_OR_IP}:80${BUILD_NUMBER}"
                ''' 
            }
        }      
    }
}
```



# Building an image with advance steps without post action


### Building Docker images

1. Create a docker hub credential first in Jenkins
![](/images/jenkins26.JPG)


2. Install `CloudBees Docker Build and Publish` plugin
![](/images/jenkins27.JPG)

3. Install `Docker Pipeline` plugin
![](/images/jenkins28.JPG)



```groovy
pipeline {
    agent any
    environment {
        TAG='covid19'
        CONTAINER_PORT='80'
        HOST_NAME_OR_IP='http:10.0.0.10'
        registry = 'leonardtia/devops-test-repo'
        registryCredential = 'Docker-Hub-Credentials'
        dockerImage = ''
    }
    stages {
        stage('Checkout') {
            steps {
                 checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'GitHub-Credentials', url: 'https://github.com/leonardtia1/dockerfile.git']]]) 
            }
        }
        stage('Building The Image') {
            steps {
                script {
                    dockerImage = docker.build registry + ":${TAG}-${BUILD_NUMBER}"
                }
            } 
        }      
    }
}
```

### Runing The Image
```groovy
pipeline {
    agent any
    environment {
        TAG='covid19'
        CONTAINER_PORT='80'
        HOST_NAME_OR_IP='http:10.0.0.10'
        registry = 'leonardtia/devops-test-repo'
        registryCredential = 'Docker-Hub-Credentials'
        dockerImage = ''
    }
    stages {
        stage('Checkout') {
            steps {
                 checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'GitHub-Credentials', url: 'https://github.com/leonardtia1/dockerfile.git']]]) 
            }
        }
        stage('Building The Image') {
            steps {
                script {
                    dockerImage = docker.build registry + ":${TAG}-${BUILD_NUMBER}"
                }
            }   
        }
        stage('Runing The Image') {
            steps {
                sh '''
                 #!/bin/bash
                 docker images
                 docker run \
                    -d \
                    -p 80${BUILD_NUMBER}:${CONTAINER_PORT} \
                    --name=${TAG}-${BUILD_NUMBER} \
                    ${registry}:${TAG}-${BUILD_NUMBER}
                docker ps
                ''' 
            }
        }
    }
}
```

### Pushing Image To Docker Hub
```groovy
pipeline {
    agent any
    environment {
        TAG='covid19'
        CONTAINER_PORT='80'
        HOST_NAME_OR_IP='http:10.0.0.10'
        registry = 'leonardtia/devops-test-repo'
        registryCredential = 'Docker-Hub-Credentials'
        dockerImage = ''
    }
    stages {
        stage('Checkout') {
            steps {
                 checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'GitHub-Credentials', url: 'https://github.com/leonardtia1/dockerfile.git']]]) 
            }
        }
        stage('Building The Image') {
            steps {
                script {
                    dockerImage = docker.build registry + ":${TAG}-${BUILD_NUMBER}"
                }
            }   
        }
        stage('Runing The Image') {
            steps {
                sh '''
                 #!/bin/bash
                 docker images
                 docker run \
                    -d \
                    -p 80${BUILD_NUMBER}:${CONTAINER_PORT} \
                    --name=${TAG}-${BUILD_NUMBER} \
                    ${registry}:${TAG}-${BUILD_NUMBER}
                docker ps
                ''' 
            }
        }
        stage('Pushing Image To Docker Hub') {
            steps {
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }      
    }
}
```

### Remove Unused docker image and get the App URL
```groovy
pipeline {
    agent any
    environment {
        TAG='covid19'
        CONTAINER_PORT='80'
        HOST_NAME_OR_IP='http:10.0.0.10'
        registry = 'leonardtia/devops-test-repo'
        registryCredential = 'Docker-Hub-Credentials'
        dockerImage = ''
    }
    stages {
        stage('Checkout') {
            steps {
                 checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'GitHub-Credentials', url: 'https://github.com/leonardtia1/dockerfile.git']]]) 
            }
        }
        stage('Building The Image') {
            steps {
                script {
                    dockerImage = docker.build registry + ":${TAG}-${BUILD_NUMBER}"
                }
            }   
        }
        stage('Runing The Image') {
            steps {
                sh '''
                 #!/bin/bash
                 docker images
                 docker run \
                    -d \
                    -p 80${BUILD_NUMBER}:${CONTAINER_PORT} \
                    --name=${TAG}-${BUILD_NUMBER} \
                    ${registry}:${TAG}-${BUILD_NUMBER}
                docker ps
                ''' 
            }
        }
        stage('Pushing Image To Docker Hub') {
            steps {
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Remove Unused docker image') {
            steps {
                sh "docker rmi --force ${registry}:${TAG}-$BUILD_NUMBER"
                sh "docker images"
                sh "docker ps"
            }
        }
        stage('App URL') {
            steps {
                sh '''
                 #!/bin/bash
                 echo "Use this URL to access you application: ${HOST_NAME_OR_IP}:80${BUILD_NUMBER}"
                ''' 
            }
        }      
    }
}
```

### Add post actions
NB: If you are not able to receive notifications, generate a new jenkins webhook and update the token in Jenkins.
```groovy
pipeline {
    agent any
    environment {
        TAG='covid19'
        CONTAINER_PORT='80'
        HOST_NAME_OR_IP='http:10.0.0.10'
        registry = 'leonardtia/devops-test-repo'
        registryCredential = 'Docker-Hub-Credentials'
        dockerImage = ''
    }
    stages {
        stage('Checkout') {
            steps {
                 checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'GitHub-Credentials', url: 'https://github.com/leonardtia1/dockerfile.git']]]) 
            }
        }
        stage('Building The Image') {
            steps {
                script {
                    dockerImage = docker.build registry + ":${TAG}-${BUILD_NUMBER}"
                }
            }   
        }
        stage('Runing The Image') {
            steps {
                sh '''
                 #!/bin/bash
                 docker images
                 docker run \
                    -d \
                    -p 80${BUILD_NUMBER}:${CONTAINER_PORT} \
                    --name=${TAG}-${BUILD_NUMBER} \
                    ${registry}:${TAG}-${BUILD_NUMBER}
                docker ps
                ''' 
            }
        }
        stage('Pushing Image To Docker Hub') {
            steps {
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Remove Unused docker image') {
            steps {
                sh "docker rmi --force ${registry}:${TAG}-$BUILD_NUMBER"
                sh "docker images"
                sh "docker ps"
            }
        }
        stage('App URL') {
            steps {
                sh '''
                 #!/bin/bash
                 echo "Use this URL to access you application: ${HOST_NAME_OR_IP}:80${BUILD_NUMBER}"
                ''' 
            }
        }      
    }
    post {
        success {
            slackSend baseUrl: 'https://hooks.slack.com/services/',
            channel: 'pipeline-test', 
            color: '#BDFFC3', 
            message: 'Project Name : ' + JOB_NAME + ' \n Build Status : Build number ' + currentBuild.displayName + ' finished with status: SUCCESS ===> GOOD JOB GUYS! \n Description : ' + currentBuild.description + '\n Build URL : ' + BUILD_URL, 
            teamDomain: 'Devops easy learning', 
            tokenCredentialId: 'Slack-Token-For-Incoming-Webhooks'
        }
        failure {
            slackSend baseUrl: 'https://hooks.slack.com/services/',
            channel: 'pipeline-test', 
            color: '#FF9FA1', 
            message: 'Project Name : ' + JOB_NAME + ' \n Build Status : Build number ' + currentBuild.displayName + ' finished with status: FAILED ===> Please check the console output to fix this job IMMEDIATELY ===> THANKS. \n Description : ' + currentBuild.description + '\n Build URL : ' + BUILD_URL, 
            teamDomain: 'Devops easy learning', 
            tokenCredentialId: 'Slack-Token-For-Incoming-Webhooks'
        }
        unstable {
            slackSend baseUrl: 'https://hooks.slack.com/services/',
            channel: 'pipeline-test', 
            color: '#FFFE89', 
            message: 'Project Name : ' + JOB_NAME + ' \n Build Status : Build number ' + currentBuild.displayName + ' finished with status: UNSTABLE ===> Please check the console output to fix this job IMMEDIATELY ===> THANKS. \n Description : ' + currentBuild.description + '\n Build URL : ' + BUILD_URL, 
            teamDomain: 'Devops easy learning', 
            tokenCredentialId: 'Slack-Token-For-Incoming-Webhooks'
        }
        
    }
}
```