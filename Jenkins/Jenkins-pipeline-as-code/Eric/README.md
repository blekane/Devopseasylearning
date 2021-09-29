### Set up jenkins user so that hee can build a docker image on master
```sh
sudo groupadd docker
#sudo usermod -aG docker $USER
sudo usermod -aG docker jenkins
chmod 777 /var/run/docker.sock
echo -e 'jenkins  ALL=(ALL)  NOPASSWD:  ALL' > /etc/sudoers.d/jenkins
su - jenkins
```

### Set up jenkins user so that hee can build a docker image on nodes
```sh
sudo groupadd docker
sudo useradd jenkins
sudo usermod -aG docker jenkins
chmod 777 /var/run/docker.sock
echo -e 'jenkins  ALL=(ALL)  NOPASSWD:  ALL' > /etc/sudoers.d/jenkins
passwrd jenkins
su - jenkins
```

```groovy
pipeline {
    agent any
     parameters {
        string(defaultValue: "", description: 'supply the branch for the docker image', name: 'branch')
        string(defaultValue: "", description: 'supply the repository ', name: 'repo')
        string(defaultValue: "", description: 'images name  ', name: 'image')
        string(defaultValue: "", description: 'docker repository name   ', name: 'repository')
        string(defaultValue: "", description: 'image tag  ', name: 'tag')
    }
    stages {
        stage('cloning the repo') {
            steps {
                sh '''
                rm -rf ./*
                git clone -b ${branch} ${repo}
                // git clone -b main https://github.com/leonardtia1/dockerfile.git
                '''
            }
        }
        stage('building the image') {
            steps {
                sh '''
                sudo docker rmi -f ${repository}/${image}:${tag} || true 
                cd Docker-Jobs-
                sudo docker build -t ${repository}/${image}:${tag} .
                '''
            }
        }
    }
}
```


```groovy
pipeline {
    agent any
     parameters {
        string(defaultValue: "", description: 'supply the branch for the docker image', name: 'branch')
        string(defaultValue: "", description: 'supply the repository ', name: 'repo')
        string(defaultValue: "", description: 'images name  ', name: 'image')
        string(defaultValue: "", description: 'docker repository name   ', name: 'repository')
        string(defaultValue: "", description: 'image tag  ', name: 'tag')
    }
    stages {
        stage('cloning the repo') {
            steps {
                sh '''
                rm -rf ./*
                git clone -b ${branch} ${repo}
                '''
            }
        }
        stage('building the image') {
            steps {
                sh '''
                #sudo docker rmi -f ${repository}/${image}:${tag} || true 
                A=$(ls)
                cd ${A}
                sudo docker build -t ${repository}/$image:${tag} .
                '''
            }
        }
    }
}
```

### Problems
1. Tree team
    - Choice: devops, deeloper and tester
2. Multiple users
    - string: user name or ID
3. Multiple application
    - Choice: client, api, db
4. Two docker repo (nexus and dockerhub)
    - choice: nexus, dockerhub, and both
5. Multiple branches
    - string: a user can use any branch here
6. repo nome
    - choice: klm, jnlp
7. tags
    - string
8. Notification

```groovy
pipeline {
    agent any
     parameters {
           choice(name: 'team', choices: ['devops', 'developer', 'tester'], description: 'Select your team')
           string(defaultValue: "", description: 'Enter your last_name', name: 'name')
           choice(name: 'app', choices: ['client', 'api', 'db'], description: 'Select an app')
           choice(name: 'registry', choices: ['nexus', 'dockerhub', 'nexusdockerhub'], description: 'Select a registry')
           string(defaultValue: "", description: 'supply a github repository', name: 'github')
           string(defaultValue: "", description: 'supply the branch for the docker image', name: 'branch')
           choice(name: 'repository', choices: ['klm', 'jnlp'], description: 'Select a repository')
           string(defaultValue: "", description: 'supply a tag ', name: 'tag')
    }
    stages {
        stage('cloning the repo') {
            steps {
                sh '''
                ls
                '''
            }
        }
        stage('building the image') {
            steps {
                sh '''
               ls
                '''
            }
        }
    }
}
```

### Stages
1. Clone
2. Validate if the Dockerfile exist
3. Valide credentials
5. Tag
6. Validate the image
7. push the image
8. notify



```groovy
pipeline {
    agent any
     parameters {
           choice(name: 'team', choices: ['devops', 'developer', 'tester'], description: 'Select your team')
           string(defaultValue: "", description: 'Enter your last_name', name: 'name')
           choice(name: 'app', choices: ['client', 'api', 'db'], description: 'Select an app')
           choice(name: 'registry', choices: ['nexus', 'dockerhub', 'nexusdockerhub'], description: 'Select a registry')
           string(defaultValue: "", description: 'supply a github repository', name: 'github')
           string(defaultValue: "", description: 'supply the branch for the docker image', name: 'branch')
           choice(name: 'repository', choices: ['klm', 'jnlp'], description: 'Select a repository')
           string(defaultValue: "", description: 'supply a tag ', name: 'tag')
    }
    stages {
        stage('cloning the repository') {
            steps {
                sh '''
                rm -rf *
                git clone -b $(branch} ${github}
                '''
            }
        }
        stage('building the image') {
            steps {
                sh '''
               ls
                '''
            }
        }
    }
}

// Validate if the Dockerfile exist

pipeline {
    agent any
     parameters {
           choice(name: 'team', choices: ['devops', 'developer', 'tester'], description: 'Select your team')
           string(defaultValue: "", description: 'Enter your last_name', name: 'name')
           choice(name: 'app', choices: ['client', 'api', 'db'], description: 'Select an app')
           choice(name: 'registry', choices: ['nexus', 'dockerhub', 'nexusdockerhub'], description: 'Select a registry')
           string(defaultValue: "", description: 'supply a github repository', name: 'github')
           string(defaultValue: "", description: 'supply the branch for the docker image', name: 'branch')
           choice(name: 'repository', choices: ['klm', 'jnlp'], description: 'Select a repository')
           string(defaultValue: "", description: 'supply a tag ', name: 'tag')
    }
    stages {
        stage('Cloning the repository') {
            steps {
                sh '''
                rm -rf *
                git clone -b ${branch} ${github}
                '''
            }
        }
        stage('Validate if the Dockerfile exist') {
            steps {
                sh '''
                A=$(ls)
                cd ${A}
                ls
                cat Dockerfile
                '''
            }
        }
        stage('building the image') {
            steps {
                sh '''
                ls
                '''
            }
        }
    }
}

// Build the image
pipeline {
    agent any
     parameters {
           choice(name: 'team', choices: ['devops', 'developer', 'tester'], description: 'Select your team')
           string(defaultValue: "", description: 'Enter your last_name', name: 'name')
           choice(name: 'app', choices: ['client', 'api', 'db'], description: 'Select an app')
           choice(name: 'registry', choices: ['nexus', 'dockerhub', 'nexusdockerhub'], description: 'Select a registry')
           string(defaultValue: "", description: 'supply a github repository', name: 'github')
           string(defaultValue: "", description: 'supply the branch for the docker image', name: 'branch')
           choice(name: 'repository', choices: ['klm', 'jnlp'], description: 'Select a repository')
           string(defaultValue: "", description: 'supply a tag ', name: 'tag')
    }
    stages {
        stage('Cloning the repository') {
            steps {
                sh '''
                rm -rf *
                git clone -b ${branch} ${github}
                '''
            }
        }
        stage('Validate if the Dockerfile exist') {
            steps {
                sh '''
                A=$(ls)
                cat ${A}/Dockerfile
                '''
            }
        }
        stage('Building the docker image') {
            steps {
                sh '''
                A=$(ls)
                cd ${A}
                ls
                cat Dockerfile
                echo $team
                echo $name
                echo $app
                echo $repository
                echo $tag
                '''
            }
        }
        stage('building the image') {
            steps {
                sh '''
                ls
                '''
            }
        }
    }
}


pipeline {
    agent any
     parameters {
           choice(name: 'team', choices: ['devops', 'developer', 'tester'], description: 'Select your team')
           string(defaultValue: "", description: 'Enter your last_name', name: 'name')
           choice(name: 'app', choices: ['client', 'api', 'db'], description: 'Select an app')
           choice(name: 'registry', choices: ['nexus', 'dockerhub', 'nexusdockerhub'], description: 'Select a registry')
           string(defaultValue: "", description: 'supply a github repository', name: 'github')
           string(defaultValue: "", description: 'supply the branch for the docker image', name: 'branch')
           choice(name: 'repository', choices: ['klm', 'jnlp'], description: 'Select a repository')
           string(defaultValue: "", description: 'supply a tag ', name: 'tag')
    }
    stages {
        stage('Cloning the repository') {
            steps {
                sh '''
                rm -rf *
                git clone -b ${branch} ${github}
                '''
            }
        }
        stage('Validate if the Dockerfile exist') {
            steps {
                sh '''
                A=$(ls)
                cat ${A}/Dockerfile
                '''
            }
        }
        stage('Building the docker image') {
            steps {
                sh '''
                A=$(ls)
                cd ${A}
                ls
                cat Dockerfile
                echo $team
                echo $name
                echo $app
                echo $repository
                echo $tag
                sudo  docker rmi -f ${team}_${name}_${app}_${repository}:${tag} || true 
                sudo docker build -t ${team}_${name}_${app}_${repository}:${tag} .
                '''
            }
        }
        stage('building the image') {
            steps {
                sh '''
                ls
                '''
            }
        }
    }
}
```




















pipeline {
    agent any
     parameters {


           choice(name: 'team', choices: ['devops', 'developer', 'tester'], description: 'Select your team')
           string(defaultValue: "", description: 'Enter your last_name', name: 'name')
           choice(name: 'app', choices: ['client', 'api', 'db'], description: 'Select an app')
           choice(name: 'registry', choices: ['nexus', 'dockerhub', 'nexusdockerhub'], description: 'Select a registry')
           string(defaultValue: "", description: 'supply a github repository', name: 'github')
           string(defaultValue: "", description: 'supply the branch for the docker image', name: 'branch')
           choice(name: 'repository', choices: ['klm', 'jnlp'], description: 'Select a repository')
           string(defaultValue: "", description: 'supply a tag ', name: 'tag')

    }

    stages {
        stage('clone') {
            steps {
                sh '''
                rm -rf ./*
                git clone -b $branch  $github
               
                '''
            }
        }


        stage('validate dockerfile') {
            steps {
                sh '''
                A=$(ls)
               cat $A/Dockerfile
                '''
            }
        }

         stage('Build') {
            steps {
                sh '''
                A=$(ls)
               cat $A/Dockerfile
                cd $A
               sudo  docker rmi -f ${team}_${name}_${app}_${repository}:${tag} || true 
               sudo docker build -t ${team}_${name}_${app}_${repository}:${tag} .
               echo $team
               echo $name
              echo  $app
              echo  $repository
              echo $tag
                '''
            }
        }


    }





}