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
           choice(name: 'registry', choices: ['nexus', 'dockerhub', 'ecr', 'all'], description: 'Select a registry')
           string(defaultValue: "", description: 'supply a github repository', name: 'github')
           string(defaultValue: "", description: 'supply the branch for the docker image', name: 'branch')
           choice(name: 'repository', choices: ['klm', 'jnlp'], description: 'Select a repository')
           string(defaultValue: "", description: 'supply a tag ', name: 'tag')
           choice(name: 'environment', choices: ['dev', 'qa', 'stg', 'prod'], description: 'Select the environment')
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
           choice(name: 'registry', choices: ['nexus', 'dockerhub', 'ecr', 'all'], description: 'Select a registry')
           string(defaultValue: "", description: 'supply a github repository', name: 'github')
           string(defaultValue: "", description: 'supply the branch for the docker image', name: 'branch')
           choice(name: 'repository', choices: ['klm', 'jnlp'], description: 'Select a repository')
           string(defaultValue: "", description: 'supply a tag ', name: 'tag')
           choice(name: 'environment', choices: ['dev', 'qa', 'stg', 'prod'], description: 'Select the environment')
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
           choice(name: 'registry', choices: ['nexus', 'dockerhub', 'ecr', 'all'], description: 'Select a registry')
           string(defaultValue: "", description: 'supply a github repository', name: 'github')
           string(defaultValue: "", description: 'supply the branch for the docker image', name: 'branch')
           choice(name: 'repository', choices: ['klm', 'jnlp'], description: 'Select a repository')
           string(defaultValue: "", description: 'supply a tag ', name: 'tag')
           choice(name: 'environment', choices: ['dev', 'qa', 'stg', 'prod'], description: 'Select the environment')
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
           choice(name: 'registry', choices: ['nexus', 'dockerhub', 'ecr', 'all'], description: 'Select a registry')
           string(defaultValue: "", description: 'supply a github repository', name: 'github')
           string(defaultValue: "", description: 'supply the branch for the docker image', name: 'branch')
           choice(name: 'repository', choices: ['klm', 'jnlp'], description: 'Select a repository')
           string(defaultValue: "", description: 'supply a tag ', name: 'tag')
           choice(name: 'environment', choices: ['dev', 'qa', 'stg', 'prod'], description: 'Select the environment')
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
           choice(name: 'registry', choices: ['nexus', 'dockerhub', 'ecr', 'all'], description: 'Select a registry')
           string(defaultValue: "", description: 'supply a github repository', name: 'github')
           string(defaultValue: "", description: 'supply the branch for the docker image', name: 'branch')
           choice(name: 'repository', choices: ['klm', 'jnlp'], description: 'Select a repository')
           string(defaultValue: "", description: 'supply a tag ', name: 'tag')
           choice(name: 'environment', choices: ['dev', 'qa', 'stg', 'prod'], description: 'Select the environment')
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

// Define all environment
pipeline {
    agent any
     parameters {
           choice(name: 'team', choices: ['devops', 'developer', 'tester'], description: 'Select your team')
           string(defaultValue: "", description: 'Enter your last_name', name: 'name')
           choice(name: 'app', choices: ['client', 'api', 'db'], description: 'Select an app')
           choice(name: 'registry', choices: ['nexus', 'dockerhub', 'ecr', 'all'], description: 'Select a registry')
           string(defaultValue: "", description: 'supply a github repository', name: 'github')
           string(defaultValue: "", description: 'supply the branch for the docker image', name: 'branch')
           choice(name: 'repository', choices: ['klm', 'jnlp'], description: 'Select a repository')
           string(defaultValue: "", description: 'supply a tag ', name: 'tag')
           choice(name: 'environment', choices: ['dev', 'qa', 'stg', 'prod'], description: 'Select the environment')
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
        stage('Pushing to Nexus') {
            when {
                expression { params.registry == 'nexus' }
            }
            steps {
                sh '''
                ls
                '''
            }
        }
        stage('Pushing to Docker Hub') {
            when {
                expression { params.registry == 'dockerhub' }
            }
            steps {
                sh '''
                ls
                '''
            }
        }
        stage('Pushing to ECR') {
            when {
                expression { params.registry == 'dockerhub' }
            }
            steps {
                sh '''
                ls
                '''
            }
        }
        stage('Pushing Nexus, Docker Hub and ECR') {
            when {
                expression { params.registry == 'all' }
            }
            steps {
                sh '''
                ls
                '''
            }
        }
        stage('building the image') {
            steps {
                sh '''
                ls -l
                '''
            }
        }
    }
}


// Build command for each environment
```groovy
pipeline {
    agent any
     parameters {
           choice(name: 'team', choices: ['devops', 'developer', 'tester'], description: 'Select your team')
           string(defaultValue: "", description: 'Enter your last_name', name: 'name')
           choice(name: 'app', choices: ['client', 'api', 'db'], description: 'Select an app')
           choice(name: 'registry', choices: ['nexus', 'dockerhub', 'ecr', 'all'], description: 'Select a registry')
           string(defaultValue: "", description: 'supply a github repository', name: 'github')
           string(defaultValue: "", description: 'supply the branch for the docker image', name: 'branch')
           choice(name: 'repository', choices: ['klm', 'jnlp'], description: 'Select a repository')
           string(defaultValue: "", description: 'supply a tag ', name: 'tag')
           choice(name: 'environment', choices: ['dev', 'qa', 'stg', 'prod'], description: 'Select the environment')
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
        stage('Pushing to Nexus') {
            when {
                expression { 
                    params.registry == 'nexus' 
                }
            }
            steps {
                sh '''
                ls
                '''
            }
        }
        stage('Pushing to Docker Hub') {
            when {
                expression { 
                    params.registry == 'dockerhub' 
                }
            }
            steps {
                sh '''
                ls
                '''
            }
        }
        stage('Pushing to ECR') {
            when {
                expression { 
                    params.registry == 'dockerhub' 
                }
            }
            steps {
                sh '''
                ls
                '''
            }
        }
        stage('Pushing Nexus, Docker Hub and ECR') {
            when {
                expression { 
                    params.registry == 'all' 
                }
            }
            steps {
                sh '''
                ls
                '''
            }
        }
        stage('building the image') {
            steps {
                sh '''
                ls -l
                '''
            }
        }
    }
}




// Pure test for each environment 

pipeline {
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '20'))
        disableConcurrentBuilds()
        timeout (time: 10, unit: 'MINUTES')
        timestamps()
    }
    environment {

        AWS_ACCOUNT_ID="YOUR_ACCOUNT_ID_HERE"
        AWS_DEFAULT_REGION="CREATED_AWS_ECR_CONTAINER_REPO_REGION" 
        IMAGE_REPO_NAME="ECR_REPO_NAME"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"

        registry = 'leonardtia/devops-test-repo'
        registryCredential = 'Docker-Hub-Credentials'
        dockerImage = ''
    }
    parameters {
        choice(name: 'team', choices: ['devops', 'developer', 'tester'], description: 'Select your team')
        string(defaultValue: "", description: 'Enter your last_name', name: 'name')
        choice(name: 'app', choices: ['client', 'api', 'db'], description: 'Select an app')
        choice(name: 'registry', choices: ['nexus', 'dockerhub', 'ecr', 'all'], description: 'Select a registry')
        string(defaultValue: "", description: 'supply a github repository', name: 'github')
        string(defaultValue: "", description: 'supply the branch for the docker image', name: 'branch')
        choice(name: 'repository', choices: ['klm', 'jnlp'], description: 'Select a repository')
        string(defaultValue: "", description: 'supply a tag ', name: 'tag')
        choice(name: 'environment', choices: ['dev', 'qa', 'stg', 'prod'], description: 'Select the environment')
    }
    stages {
        stage('Cloning the repository') {
            steps {
                sh '''
                ls
                '''
            }
        }
        stage('Validate if the Dockerfile exist') {
            steps {
                sh '''
                ls
                '''
            }
        }
        stage('Building the docker image') {
            steps {
                 sh '''
                 ls
                 '''
            }   
        }
        stage('Pushing to Nexus') {
            when {
                expression { 
                    params.registry == 'nexus' 
                }
            }
            steps {
                sh '''
                ls
                '''
            }
        }
        stage('Pushing to Docker Hub') {
            when {
                expression { 
                    params.registry == 'dockerhub' 
                }
            }
            steps {
                script {
                    sh '''
                    ls
                    '''
                }
            }
        }
        stage('Pushing to ECR') {
            when {
                expression { 
                    params.registry == 'dockerhub' 
                }
            }
            steps {
                script {
                    sh '''
                    ls
                    '''
                }  
            }
        }
        stage('Pushing to Nexus, Docker Hub and ECR') {
            when {
                expression { 
                    params.registry == 'all' 
                }
            }
            steps {
                script {
                    sh '''
                    ls
                    '''
                }
                script {
                    sh '''
                    ls
                    '''
                }
                script {
                    sh '''
                    ls
                    '''
                }  
            }
        }
        stage('Deploying to DEV') {
            when {
                expression { 
                    params.environment == 'dev' 
                }
            }
            steps {
                script {
                    sh '''
                    echo "Deploy to Developmnet environment"
                    '''
                }  
            }
        }
        stage('Deploying to QA') {
            when {
                expression { 
                    params.environment == 'qa' 
                }
            }
            steps {
                script {
                    sh '''
                    echo "Deploy to QA environment"
                    '''
                }  
            }
        }
        stage('Deploying to STG') {
            when {
                expression { 
                    params.environment == 'stg' 
                }
            }
            steps {
                script {
                    sh '''
                    echo "Deploy to STG environment"
                    '''
                }  
            }
        }
        stage('Deploying to PROD') {
            when {
                expression { 
                    params.environment == 'prod' 
                }
            }
            steps {
                script {
                    sh '''
                    echo "Deploy to STG environment"
                    '''
                }  
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
    } 
}



pipeline {
    agent {
        label 'master'
    }
    options {
    buildDiscarder(logRotator(numToKeepStr: '20'))
    disableConcurrentBuilds()
    timeout (time: 10, unit: 'MINUTES')
    timestamps()
  }
  environment {

        AWS_ACCOUNT_ID="YOUR_ACCOUNT_ID_HERE"
        AWS_DEFAULT_REGION="CREATED_AWS_ECR_CONTAINER_REPO_REGION" 
        IMAGE_REPO_NAME="ECR_REPO_NAME"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"

        registry = 'leonardtia/devops-test-repo'
        registryCredential = 'Docker-Hub-Credentials'
        dockerImage = ''
    }
    parameters {
        choice(name: 'team', choices: ['devops', 'developer', 'tester'], description: 'Select your team')
        string(defaultValue: "", description: 'Enter your last_name', name: 'name')
        choice(name: 'app', choices: ['client', 'api', 'db'], description: 'Select an app')
        choice(name: 'registry', choices: ['nexus', 'dockerhub', 'ecr', 'all'], description: 'Select a registry')
        string(defaultValue: "https://github.com/leonardtia1/dockerfile.git", description: 'supply a github repository', name: 'repository')
        string(defaultValue: "main", description: 'supply the branch for the docker image', name: 'branch')
        choice(name: 'project', choices: ['klm', 'jnlp'], description: 'Select the project name')
        string(defaultValue: "", description: 'supply a tag ', name: 'tag')
        choice(name: 'environment', choices: ['dev', 'qa', 'stg', 'prod'], description: 'Select the environment')
    }
    stages {
        stage ('checkout') {
        steps {
            dir("${WORKSPACE}/build") {
            checkout([
                $class: 'GitSCM',
                branches: [[name: "*/${branch}"]],
                doGenerateSubmoduleConfigurations: false,
                extensions: [[$class: 'LocalBranch']],
                submoduleCfg: [],
                userRemoteConfigs: [[
                url: "${repository}",
                credentialsId: 'GitHub-Credentials'
                ]]
            ])
            }
        }
    }
  }
} 



pipeline {
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '20'))
        disableConcurrentBuilds()
        timeout (time: 10, unit: 'MINUTES')
        timestamps()
    }
    environment {

        AWS_ACCOUNT_ID="YOUR_ACCOUNT_ID_HERE"
        AWS_DEFAULT_REGION="CREATED_AWS_ECR_CONTAINER_REPO_REGION" 
        IMAGE_REPO_NAME="ECR_REPO_NAME"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"

        registry = 'leonardtia/devops-test-repo'
        registryCredential = 'Docker-Hub-Credentials'
        dockerImage = ''
    }
    parameters {
        choice(name: 'team', choices: ['devops', 'developer', 'tester'], description: 'Select your team')
        string(defaultValue: "", description: 'Enter your last_name', name: 'name')
        choice(name: 'app', choices: ['client', 'api', 'db'], description: 'Select an app')
        choice(name: 'registry', choices: ['nexus', 'dockerhub', 'ecr', 'all'], description: 'Select a registry')
        string(defaultValue: "https://github.com/leonardtia1/dockerfile.git", description: 'supply a github repository', name: 'github')
        string(defaultValue: "main", description: 'supply the branch for the docker image', name: 'branch')
        choice(name: 'repository', choices: ['klm', 'jnlp'], description: 'Select a repository')
        string(defaultValue: "", description: 'supply a tag ', name: 'tag')
        choice(name: 'environment', choices: ['dev', 'qa', 'stg', 'prod'], description: 'Select the environment')
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
                script {
                    dockerImage = docker.build registry + ":${tag}-${BUILD_NUMBER}"
                }
            }   
        }
        stage('Pushing to Nexus') {
            when {
                expression { 
                    params.registry == 'nexus' 
                }
            }
            steps {
                sh '''
                ls
                '''
            }
        }
        stage('Pushing to Docker Hub') {
            when {
                expression { 
                    params.registry == 'dockerhub' 
                }
            }
            steps {
                script {
                    sh '''
                    ls
                    '''
                }
            }
        }
        stage('Pushing to ECR') {
            when {
                expression { 
                    params.registry == 'dockerhub' 
                }
            }
            steps {
                script {
                    sh '''
                    ls
                    '''
                }  
            }
        }
        stage('Pushing to Nexus, Docker Hub and ECR') {
            when {
                expression { 
                    params.registry == 'all' 
                }
            }
            steps {
                script {
                    sh '''
                    ls
                    '''
                }
                script {
                    sh '''
                    ls
                    '''
                }
                script {
                    sh '''
                    ls
                    '''
                }  
            }
        }
        stage('Deploying to DEV') {
            when {
                expression { 
                    params.environment == 'dev' 
                }
            }
            steps {
                script {
                    sh '''
                    echo "Deploy to Developmnet environment"
                    '''
                }  
            }
        }
        stage('Deploying to QA') {
            when {
                expression { 
                    params.environment == 'qa' 
                }
            }
            steps {
                script {
                    sh '''
                    echo "Deploy to QA environment"
                    '''
                }  
            }
        }
        stage('Deploying to STG') {
            when {
                expression { 
                    params.environment == 'stg' 
                }
            }
            steps {
                script {
                    sh '''
                    echo "Deploy to STG environment"
                    '''
                }  
            }
        }
        stage('Deploying to PROD') {
            when {
                expression { 
                    params.environment == 'prod' 
                }
            }
            steps {
                script {
                    sh '''
                    echo "Deploy to STG environment"
                    '''
                }  
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
    } 
}




// pure
```groovy
pipeline {
    agent any
    environment {

        AWS_ACCOUNT_ID="YOUR_ACCOUNT_ID_HERE"
        AWS_DEFAULT_REGION="CREATED_AWS_ECR_CONTAINER_REPO_REGION" 
        IMAGE_REPO_NAME="ECR_REPO_NAME"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"

        registry = 'leonardtia/devops-test-repo'
        registryCredential = 'Docker-Hub-Credentials'
        dockerImage = ''
    }
     parameters {
           choice(name: 'team', choices: ['devops', 'developer', 'tester'], description: 'Select your team')
           string(defaultValue: "", description: 'Enter your last_name', name: 'name')
           choice(name: 'app', choices: ['client', 'api', 'db'], description: 'Select an app')
           choice(name: 'registry', choices: ['nexus', 'dockerhub', 'ecr', 'all'], description: 'Select a registry')
           string(defaultValue: "", description: 'supply a github repository', name: 'github')
           string(defaultValue: "", description: 'supply the branch for the docker image', name: 'branch')
           choice(name: 'repository', choices: ['klm', 'jnlp'], description: 'Select a repository')
           string(defaultValue: "", description: 'supply a tag ', name: 'tag')
           choice(name: 'environment', choices: ['dev', 'qa', 'stg', 'prod'], description: 'Select the environment')
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
                script {
                    dockerImage = docker.build registry + ":${tag}-${BUILD_NUMBER}"
                }
            }   
        }
        stage('Pushing to Nexus') {
            when {
                expression { 
                    params.registry == 'nexus' 
                }
            }
            steps {
                sh '''
                ls
                '''
            }
        }
        stage('Pushing to Docker Hub') {
            when {
                expression { 
                    params.registry == 'dockerhub' 
                }
            }
            steps {
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Pushing to ECR') {
            when {
                expression { 
                    params.registry == 'dockerhub' 
                }
            }
            steps {
                script {
                    sh '''
                    aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com

                    docker tag ${IMAGE_REPO_NAME}:${tag} ${REPOSITORY_URI}:$IMAGE_TAG"
                    docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${tag}
                    '''
                }  
            }
        }
        stage('Pushing Nexus, Docker Hub and ECR') {
            when {
                expression { 
                    params.registry == 'all' 
                }
            }
            steps {
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                    }
                }
                script {
                    sh '''
                    aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com

                    docker tag ${IMAGE_REPO_NAME}:${tag} ${REPOSITORY_URI}:$IMAGE_TAG
                    docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${tag}
                    '''
                }
                script {
                    sh '''
                    ls
                    '''
                }  
            }
        }
        stage('Deploying to DEV') {
            when {
                expression { 
                    params.environment == 'dev' 
                }
            }
            steps {
                script {
                    sh '''
                    echo "Deploy to Developmnet environment"
                    '''
                }  
            }
        }
        stage('Deploying to QA') {
            when {
                expression { 
                    params.environment == 'qa' 
                }
            }
            steps {
                script {
                    sh '''
                    echo "Deploy to QA environment"
                    '''
                }  
            }
        }
        stage('Deploying to STG') {
            when {
                expression { 
                    params.environment == 'stg' 
                }
            }
            steps {
                script {
                    sh '''
                    echo "Deploy to STG environment"
                    '''
                }  
            }
        }
        stage('Deploying to PROD') {
            when {
                expression { 
                    params.environment == 'prod' 
                }
            }
            steps {
                script {
                    sh '''
                    echo "Deploy to STG environment"
                    '''
                }  
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




pipeline {
    
    agent any
    
    parameters {
        booleanParam(name: "RELEASE", defaultValue: false)
    }
    
    stages {

        stage("Build") {
            steps {
                // sh "./gradlew build"
                sh "yes"
            }
        }
        
        stage("Publish") {
            steps {
                script {
                    if (params.RELEASE) {
                        // sh "./gradlew release"
                        sh "no"
                    }
                }
            }
        }
    }
}

pipeline {
    agent any

    stages {
        stage('test') {
            steps {
                sh 'echo hello'
            }
        }
        stage('test1') {
            steps {
                sh 'echo $TEST'
            }
        }
        stage('test3') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'master') {
                        echo 'I only execute on the master branch'
                    } else {
                        echo 'I execute elsewhere'
                    }
                }
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
           choice(name: 'registry', choices: ['nexus', 'dockerhub', 'both'], description: 'Select a registry')
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
    stage('push') {
            steps {
                sh '''
                '''
            }
        }
         stage ('dockerhub') {
            when {
                expression { params.registry == 'dockerhub' }
            }
            steps {
                sh '''
                   sudo docker login  --username devopseasylearning2021 -p  DevOps2021@
                  sudo docker tag ${team}_${name}_${app}_${repository}:${tag}  devopseasylearning2021/${team}_${name}_${app}_${repository}:${tag}
                  sudo docker push devopseasylearning2021/${team}_${name}_${app}_${repository}:${tag}
                '''
            }
        }
            stage ('nexus') {
            when {
                expression { params.registry == 'nexus' }
            }
            steps {
                sh '''
                  cat /var/lib/jenkins/.nexus | sudo docker login 34.213.92.53:5000 --username admin --password-stdin
                  sudo docker tag ${team}_${name}_${app}_${repository}:${tag}  34.213.92.53:5000/${team}_${name}_${app}_${repository}:${tag}
                  sudo docker push 34.213.92.53:5000/${team}_${name}_${app}_${repository}:${tag}
                '''
            }
        }
          stage ('both') {
            when {
                expression { params.registry == 'both' }
            }
            steps {
                sh '''
                   sudo docker login  --username devopseasylearning2021 -p  DevOps2021@
                  sudo docker tag ${team}_${name}_${app}_${repository}:${tag}  devopseasylearning2021/${team}_${name}_${app}_${repository}:${tag}
                  sudo docker push devopseasylearning2021/${team}_${name}_${app}_${repository}:${tag}
                  cat /var/lib/jenkins/.nexus | sudo docker login 34.213.92.53:5000 --username admin --password-stdin
                  sudo docker tag ${team}_${name}_${app}_${repository}:${tag}  34.213.92.53:5000/${team}_${name}_${app}_${repository}:${tag}
                  sudo docker push 34.213.92.53:5000/${team}_${name}_${app}_${repository}:${tag}
                '''
            }
        }
    }
 post {
success{
  slackSend (channel: '#general', color: 'good', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
}
failure{
slackSend (channel: '#general', color: '#FF9FA1', message: "FAILURE: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
}
unstable{
slackSend (channel: '#general', color: 'warning', message: "UNSTABLE : Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
}
 }
}



pipeline {
    agent none
    stages {



         stage('cleaning') {

              agent {
        label "master"
          }
          
            steps {
                sh '''
                rm -rf ./*
                '''
            }
        }

        stage('cloning the repo') {
            agent {
        docker { image 'git_container' }
          }
            steps {
                sh '''
                git clone https://github.com/kemvoueric/devops_addressbook.git
                
                '''
            }
        }

        

        stage('build artifact') {
            agent {
        docker { image 'maven:3.8.1-adoptopenjdk-11' }
          }
            steps {
                sh '''
                ls
               cd  devops_addressbook
                mvn clean install package
                 sleep 5
            '''
            }
        }

         stage('building  images') {
               agent {
        label "master"
          }
            steps {
                sh '''
              
                cd devops_addressbook
               sudo docker build -t tomcat-image:${BUILD_NUMBER} .
                 
            '''
            }
        }

          stage('deploy') {
               agent {
        label "master"
          }
            steps {
                sh '''
              
               sudo docker  rm -f $(sudo docker ps -aq)
           
               sudo docker run -itd --name tomcat-${BUILD_NUMBER} -p 85:8080  tomcat-image:${BUILD_NUMBER} 
                sudo docker ps   
            '''
            }
        }


    }

}
