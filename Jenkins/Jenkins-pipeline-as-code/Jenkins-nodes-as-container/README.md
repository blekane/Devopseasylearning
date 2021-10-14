### Running docker container as jenkins nodes
- install `docker pipeline` first
- Using Docker with Pipeline [here](https://www.jenkins.io/doc/book/pipeline/docker/)

### Example 1
```groovy
pipeline {
    agent {
        docker { image 'node:14-alpine' }
    }
    stages {
        stage('Test') {
            steps {
                sh 'node --version'
            }
        }
    }
}
```


### Example 2
```groovy
pipeline {
    agent none
    options {
    buildDiscarder(logRotator(numToKeepStr: '20'))
    disableConcurrentBuilds()
    timeout (time: 10, unit: 'MINUTES')
    timestamps()
  }
  stages {
      stage ('Clone') {
          agent {
              docker { image 'bitnami/git'}
          }
          steps {
              sh 'ls -l'
          }
      }
      stage ('Build') {
          agent {
              docker { image 'maven:latest'}
          }
          steps {
              sh 'ls -l'
          }
      }
      stage ('Test') {
          agent {
              docker { image 'openjdk'}
          }
          steps {
              sh 'ls -l'
          }
      }
      stage ('Push') {
          agent {
              docker { image 'ubuntu'}
          }
          steps {
              sh 'ls -l'
          }
      }
      stage ('Deploy') {
          agent {
              docker { image 'tomcat'}
          }
          steps {
              sh 'ls -l'
          }
      }
  }
}

OR

pipeline {
    agent none
    options {
    buildDiscarder(logRotator(numToKeepStr: '20'))
    disableConcurrentBuilds()
    timeout (time: 10, unit: 'MINUTES')
    timestamps()
  }
  stages {
      stage ('Clone') {
          agent {
              docker { 
                image 'bitnami/git'
                }
          }
          steps {
              sh 'ls -l'
          }
      }
      stage ('Build') {
          agent {
              docker { 
                image 'maven:latest'
                }
          }
          steps {
              sh 'ls -l'
          }
      }
      stage ('Test') {
          agent {
              docker { 
                image 'openjdk'
                }
          }
          steps {
              sh 'ls -l'
          }
      }
      stage ('Push') {
          agent {
              docker { 
                image 'ubuntu'
                }
          }
          steps {
              sh 'ls -l'
          }
      }
      stage ('Deploy') {
          agent {
              docker { 
                image 'tomcat'
                }
          }
          steps {
              sh 'ls -l'
          }
      }
  }
}
```

### Example 2
```groovy
pipeline {
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '20'))
        disableConcurrentBuilds()
        timeout (time: 10, unit: 'MINUTES')
        timestamps()
    }
    parameters {
        string(defaultValue: "main", description: 'supply the branch for the docker image', name: 'branch')
        string(defaultValue: "develop", description: 'supply a tag ', name: 'tag')
    }
    environment {
        registry = 'leonardtia/devops-test-repo'
        registryCredential = 'Docker-Hub-Credentials'
        dockerImage = ''
    }
    stages {
        stage ('checkout') {
            agent {
                docker { image 'bitnami/git' }
            }
            steps {
                dir("${WORKSPACE}/build") {
                    checkout([
                        $class: 'GitSCM',
                        branches: [[name: "*/master"]],
                        doGenerateSubmoduleConfigurations: false,
                        extensions: [[$class: 'LocalBranch']],
                        submoduleCfg: [],
                        userRemoteConfigs: [[
                        url: 'https://github.com/leonardtia1/maven-project.git',
                        credentialsId: 'GitHub-Credentials'
                        ]]
                    ])
                }
            }
        }
        stage('Building the code') {
            agent {
                docker { image 'maven:3.8.1-adoptopenjdk-11' }
            }
            steps {
                dir("${env.WORKSPACE}/build") {
                    sh '''
                    ls 
                    pwd
                    mvn --version
                    mvn clean install package
                    '''
                }
            }
        }
        stage ('Building the image') {
            agent {
                label 'master'
            }
            steps {
                script {
                    dir("${env.WORKSPACE}/build") {
                        docker.withRegistry('','Docker-Hub-Credentials' ) {
                            dockerImage = docker.build('leonardtia/devops-test-repo'+":${tag}")
                        }
                    }

                } 
            }
        }
        stage ('Pushing the image') {
            agent {
                label 'master'
            }
            steps {
                script {
                    dir("${env.WORKSPACE}/build") {
                        docker.withRegistry('','Docker-Hub-Credentials' ) {
                            dockerImage.push()
                        }
                    }
                } 
            }
        }
        stage ('Deployment') {
           agent {
                label 'master'
            }
            steps {
                sh '''
                sudo docker run -d -P ${registry}:${tag} 
                sudo docker ps   
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


### Example 3 With Snarqube
```groovy
pipeline {
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '20'))
        disableConcurrentBuilds()
        timeout (time: 10, unit: 'MINUTES')
        timestamps()
    }
    parameters {
        string(defaultValue: "main", description: 'supply the branch for the docker image', name: 'branch')
        string(defaultValue: "develop", description: 'supply a tag ', name: 'tag')
    }
    environment {
        registry = 'leonardtia/devops-test-repo'
        registryCredential = 'Docker-Hub-Credentials'
        dockerImage = ''
    }
    stages {
        stage ('checkout') {
            agent {
                docker { image 'bitnami/git' }
            }
            steps {
                dir("${WORKSPACE}/build") {
                    checkout([
                        $class: 'GitSCM',
                        branches: [[name: "*/master"]],
                        doGenerateSubmoduleConfigurations: false,
                        extensions: [[$class: 'LocalBranch']],
                        submoduleCfg: [],
                        userRemoteConfigs: [[
                        url: 'https://github.com/leonardtia1/maven-project.git',
                        credentialsId: 'GitHub-Credentials'
                        ]]
                    ])
                }
            }
        }
        stage('Building the code') {
            agent {
                docker { image 'maven:3.8.1-adoptopenjdk-11' }
            }
            steps {
                dir("${env.WORKSPACE}/build") {
                    sh '''
                    ls 
                    pwd
                    mvn --version
                    mvn clean install package
                    '''
                }
            }
        }
        stage ('Building the image') {
            agent {
                label 'master'
            }
            steps {
                script {
                    dir("${env.WORKSPACE}/build") {
                        docker.withRegistry('','Docker-Hub-Credentials' ) {
                            dockerImage = docker.build('leonardtia/devops-test-repo'+":${tag}")
                        }
                    }

                } 
            }
        }
        stage ('Pushing the image') {
            agent {
                label 'master'
            }
            steps {
                script {
                    dir("${env.WORKSPACE}/build") {
                        docker.withRegistry('','Docker-Hub-Credentials' ) {
                            dockerImage.push()
                        }
                    }
                } 
            }
        }
        stage ('Deployment') {
           agent {
                label 'master'
            }
            steps {
                sh '''
                sudo docker run -d -P ${registry}:${tag} 
                sudo docker ps   
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






