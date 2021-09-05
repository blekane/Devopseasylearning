
### Running a shell cammand in the pipeline
```groovy
pipeline {
    agent any
    stages {
        stage('Hello World') {
            steps {
                echo "Hello World"
            }
        }
        stage('Run shell commands') {
            steps {
               sh 'ls -la'
                 
            }
        }
    }
}
```


### Running multiple shell cammands in the pipeline
```groovy
pipeline {
    agent any
    stages {
        stage('Hello World') {
            steps {
                echo "Hello World"
            }
        }
        stage('Run shell commands') {
            steps {
               sh '''
                 echo "hello world" 
                 ls -la
                 cat /etc/*release
                 pwd
                 df -h
                 free -m
                ''' 
            }
        }
    }
}

OR

pipeline {
    agent any
    stages {
        stage('Hello World') {
            steps {
                echo "Hello World"
            }
        }
        stage('Run shell commands') {
            steps {
                echo "hello world"
                sh "ls -la"
                sh "cat /etc/*release"
                sh "pwd"
                sh "df -h"
                sh "free -m"
            }
        }
    }
}


OR

pipeline {
    agent any
    stages {
        stage('Hello World') {
            steps {
                echo "Hello World"
            }
        }
        stage('Run shell commands') {
            steps {
               sh '''
               #! /bin/bash
               echo "hello world" 
               ls -la
               cat /etc/*release
               pwd
               df -h
               free -m
                ''' 
            }
        }
    }
}
```

### Running a shell script in the pipeline

```groovy
pipeline {
    agent any
    stages {
        stage('Hello World') {
            steps {
                echo "Hello World"
            }
        }
        stage('Installing docker on CentOs 7') {
            steps {
               sh '''
                #! /bin/bash

                # Uninstall old versions
                sudo yum remove docker \\
                                docker-client \\
                                docker-client-latest \\
                                docker-common \\
                                docker-latest \\
                                docker-latest-logrotate \\
                                docker-logrotate \\
                                docker-engine

                # this will download the script package to install docker
                curl -fsSL https://get.docker.com -o get-docker.sh
                # this will install the package
                sudo sh get-docker.sh

                sudo systemctl enable docker
                sudo systemctl start docker
                sudo docker run hello-world
                sudo docker run docker/whalesay cowsay hello-world!
                ''' 
            }
        }
    }
}
```


```groovy
pipeline {
    agent any
    stages {
        stage('Hello World') {
            steps {
                echo "Hello World"
            }
        }
        stage('Checking the OS type') {
            steps {
               sh '''
                #! /bin/bash
                UBUNTU=`cat /etc/*release |grep ID_LIKE |awk -F= '{print$2}'`
                CENTOS=`cat /etc/*release |grep ID_LIKE |awk -F= '{print$2}' |awk -F" " '{print$2}' |awk -F'"' '{print$1}'`
                AWS_CENTOS=`cat /etc/*release |grep ID_LIKE |awk -F= '{print$2}' |awk -F" " '{print$3}' |awk -F'"' '{print$1}'`


                if [[ $UBUNTU == "debian" ]]
                then
                    echo "This is Ubuntu server"
                    exit 1

                elif [[ $CENTOS == "fedora" ]] 
                then
                    echo "This is CentOs server"
                    exit 2

                elif [[ $AWS_CENTOS == "fedora" ]] 
                then
                    echo "This is AWS CentOs server"
                    exit 2

                else 
                    echo ""
                    echo "Unknow Linux distribution"
                    exit 1
                fi
                ''' 
            }
        }
    }
}
```