### Sripted and Declarative Pipeline
- repos [here](https://github.com/pipelineascodecourse)
- source code [here](https://github.com/pipelineascodecourse/source_code)
- pipeline-shared-lib [here](https://github.com/pipelineascodecourse/pipeline-shared-lib)

### Good pipeline option
```groovy
pipeline {
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '10')) 
        skipStagesAfterUnstable() 
        checkoutToSubdirectory('src') 
        timeout(time: 1, unit: 'SECONDS')
        disableConcurrentBuilds()
        timestamps() 
        skipDefaultCheckout() 
        newContainerPerStage()
    }
    stages {
        stage('Build') {
            steps {
                echo 'Hello World'
            }
        }
    }
}
```

###Pint all env in Jenkins
```groovy
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh "printenv"
            }
        }
    }
}
``` 

### Pipeline > Options > BuildDiscarder
```groovy
pipeline {
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '1')) 
    }
    stages {
        stage('Build') {
            steps {
                echo 'Hello World'
            }
        }
    }
}
```

### Pipeline > Options > DisableConcurrentBuilds
stop Jenkins from allowing a job to be started if there's already one of the same job going. 
```groovy
pipeline {	
    agent any	
    options {	
       disableConcurrentBuilds()	
    }	
    stages {	
        stage('Build') {	
            steps {	
                sleep(time: 10, unit: 'SECONDS') 	
                echo 'Hello World'	
            }	
        }	
    }	
}	
```

### Pipeline > Options > SkipStagesAfterUnstable
All stages will be skipped after UNSTABLE stage
```groovy
pipeline{	
    agent any	
    options { 
		skipStagesAfterUnstable() 
	} 	
    stages{	
        stage('Build'){	
            steps{	
                echo "setting current build to unstable"	
                script {	
                    currentBuild.result = 'UNSTABLE'	
                }	
            }	
        }	
        stage('Deploy'){	
            steps{	
                echo "deploy is running"	
            }	
        } 
        stage('Push'){	
            steps{	
                echo "Pushing to docker hub"	
            }	
        }            	
    }	
}	
```

### Pipeline > Options > CheckoutToSubdirectory [here](https://github.com/pipelineascodecourse/pipeline-options-checkoutToSubdirectory/blob/master/Jenkinsfile)
all jobs will be checkout in `src` dir
```groovy
pipeline {	
    agent any	
	options { 
		checkoutToSubdirectory('src') 
	}
    stages {	
        stage('Build') {	
            steps {                	
                echo 'Hello World'	
            }	
        }	
    }	
}

```			


### Pipeline > Pipeline Triggers > PollSCM
```groovy
pipeline {				
    agent any				
    triggers {				
        pollSCM('* * * * *')				
    }				
    stages {				
        stage('Build') {				
            steps {	
                checkout([$class: 'GitSCM', 				
				branches: [[name: "origin/master"]], 
				userRemoteConfigs: [[
                url: 'https://github.com/pipelineascodecourse/pipeline-triggers-pollSCM.git']]])
            }				
        }				
    }				
}				
```


### Pipeline > Pipeline Triggers > Upstream
pipeline-triggers-upstream job will be trigger only if any of pipeline-triggers-upstream-job1 and pipeline-triggers-upstream-job2 is `SUCCESS` if any of those is UNSTABLE, FAILURE or ABORTED, the main job will not be trigger base on the condition
```groovy
pipeline {			
    agent any			
    triggers {
        upstream(upstreamProjects: 'pipeline-triggers-upstream-job1,pipeline-triggers-upstream-job2', 			
        threshold: hudson.model.Result.SUCCESS)//UNSTABLE, FAILURE, NOT_BUILT, ABORTED, SUCCESS
    }			
    stages {			
        stage('Build') {			
            steps {			
                echo 'pipeline-triggers-upstream executed'			
            }			
        }			
    }			
}			

pipeline {			
    agent any
    stages {			
        stage('Build') {			
            steps {			
                echo 'pipeline-triggers-upstream-job1 executed'			
            }			
        }			
    }			
}			

pipeline {			
    agent any
    stages {			
        stage('Build') {			
            steps {			
                echo 'pipeline-triggers-upstream-job2 executed'			
            }			
        }			
    }			
}			

pipeline {			
    agent any
    stages {			
        stage('Build') {			
            steps {			
				script{
					currentBuild.result='UNSTABLE'				
                }
            }			
        }			
    }			
}			
```

### Pipeline > Agent > Dockerfile [here](https://github.com/pipelineascodecourse/pipeline-agent-dockerfile)
This job will look for a dockerfile in the repository, build it, run the container and execute `cat /etc/lsb-release` command inside the container
```groovy
pipeline {
	agent none
    stages {
        stage('Checkout') {
			agent any
            steps {                
                checkout([$class: 'GitSCM', 
				branches: [[name: "origin/master"]], 
				userRemoteConfigs: [[
                url: 'https://github.com/pipelineascodecourse/pipeline-agent-dockerfile.git']]				
				])
            }
        }
        stage('Build'){   
		    agent {
				dockerfile true 
			}
            steps{
                sh 'cat /etc/lsb-release'
            }
        }
    }
}
```

### Pipeline > Agent > Dockerfile > Dir [here] https://github.com/pipelineascodecourse/pipeline-agent-dockerfile-dir
the dockerfile is in `dockerfileDir`. dir is used to specify the path of the dockerfile in the repo
```groovy
pipeline {
    agent none
    stages {
        stage('Checkout') {
            agent any
            steps {
                checkout([$class: 'GitSCM', 
				branches: [[name: "origin/master"]], 
				userRemoteConfigs: [[
                url: 'https://github.com/pipelineascodecourse/pipeline-agent-dockerfile-dir.git']],
				])
            }
        }        
        stage('dockerfile'){
            agent { 
                dockerfile {                    
					dir 'dockerfileDir'
                } 
            }
            steps{
                sh 'cat /etc/lsb-release'
            }
        }
    }
}
```

### Pipeline > Agent > Dockerfile > Filename [here](https://github.com/pipelineascodecourse/pipeline-agent-dockerfile-filename)
This is use if the default Dockerfile name is not spell with capital `D`
```groovy
pipeline {
    agent none
    stages {
        stage('Checkout') {
            agent any
            steps {
                
                checkout([$class: 'GitSCM', 
				branches: [[name: "origin/master"]], 
				userRemoteConfigs: [[
                url: 'https://github.com/pipelineascodecourse/pipeline-agent-dockerfile-filename.git']]
				])
            }
        }
        stage('dockerfile'){            
            agent { 
                dockerfile {
					filename 'myCustomNameDockerfile'
                } 
            }            
            steps{
                sh 'cat /etc/lsb-release'			
            }
        }
    }
}
```

### ipeline > Agent > Dockerfile > AdditionalBuildArgs
Tag the image
```groovy
pipeline {
    agent none
    stages {
        stage('Checkout') {
            agent any
            steps {                
                checkout([$class: 'GitSCM', 
				branches: [[name: "origin/master"]], 
				userRemoteConfigs: [[
                url: 'https://github.com/pipelineascodecourse/pipeline-agent-dockerfile.git']]
				])
            }
        }        
        stage('dockerfile'){            
            agent { 
                dockerfile {
                    additionalBuildArgs '--tag mydockerfile:example'
                } 
            }            
            steps{
				sh 'cat /etc/lsb-release'
            }
        }
    }
}
```


### ipeline > Agent > Dockerfile > MIX
Tag the image
```groovy
pipeline {
    agent none
    stages {
        stage('Checkout') {
            agent any
            steps {                
                checkout([$class: 'GitSCM', 
				branches: [[name: "origin/master"]], 
				userRemoteConfigs: [[
                url: 'https://github.com/pipelineascodecourse/pipeline-agent-dockerfile.git']]
				])
            }
        }        
        stage('dockerfile'){            
            agent { 
                dockerfile {
                    dir 'dockerfileDir'
                    filename 'myCustomNameDockerfile'
                    additionalBuildArgs '--tag mydockerfile:example'
                    customWorkspace '/var/lib/jenkins/workspace/myCustomWorkspace'
                } 
            }            
            steps{
				sh 'cat /etc/lsb-release'
            }
        }
    }
}


pipeline {
    agent none
    stages {
        stage('Checkout') {
            agent any
            steps {                
                checkout([$class: 'GitSCM', 
				branches: [[name: "origin/master"]], 
				userRemoteConfigs: [[
                url: 'https://github.com/pipelineascodecourse/pipeline-agent-dockerfile.git']]
				])
            }
        }        
        stage('dockerfile'){            
            agent { 
                dockerfile {
                    dockerfile true 
                    additionalBuildArgs '--tag mydockerfile:example'
                } 
            }            
            steps{
				sh 'cat /etc/lsb-release'
            }
        }
    }
}

pipeline {
    agent none
    stages {
        stage('Checkout') {
            agent any
            steps {                
                checkout([$class: 'GitSCM', 
				branches: [[name: "origin/master"]], 
				userRemoteConfigs: [[
                url: 'https://github.com/pipelineascodecourse/pipeline-agent-dockerfile.git']]
				])
            }
        }        
        stage('dockerfile'){            
            agent { 
                dockerfile {
                    dir 'dockerfileDir' 
                    tag = additionalBuildArgs '--tag mydockerfile:example'
                } 
            }            
            steps{
				sh 'cat /etc/lsb-release'
            }
        }
    }
}
```


## registryCredentialsId
```groovy
pipeline {
    agent {
        docker { 
            image 'leonardtia/devops-pro-repos:covid19'
            registryUrl 'https://registry.hub.docker.com'
            registryCredentialsId 'Docker-Hub-Credentials'
        }
    }
    stages {
        stage('Build') {
            steps {
                sh '''
                ls -l /usr/local/apache2/htdocs/
                cat /etc/*release
                '''
            }
        }
    }
}
```

## registryCredentialsId 
```groovy
pipeline{
    agent any
    stages{
        stage("Build"){
             steps {
              withCredentials([
                usernamePassword(credentialsId: 'GitHub-Credentials', usernameVariable: 'GITHUB_USERNAME', passwordVariable: 'GITHUB_PASSWORD'),
                usernamePassword(credentialsId: 'Docker-Hub-Credentials', usernameVariable: 'DOCKER_HUB_USERNAME', passwordVariable: 'DOCKER_HUB_PASSWORD'),
                string(credentialsId: 'Slack-Token-For-Incoming-Webhooks', variable: 'SLACK_TOKEN')]) {
                  echo "DOCKER_HUB_USERNAME ${DOCKER_HUB_USERNAME}"
	                echo "DOCKER_HUB_PASSWORD ${DOCKER_HUB_PASSWORD}"

                  echo "GITHUB_USERNAME ${GITHUB_USERNAME}"
	                echo "GITHUB_PASSWORD ${GITHUB_PASSWORD}"

                  echo "SLACK_TOKEN ${SLACK_TOKEN}"
                }
            }
        }
    }
}



pipeline{
    agent any
    stages{
        stage("Build"){
             steps {
              withCredentials([
                usernamePassword(credentialsId: 'GitHub-Credentials', 
                usernameVariable: 'GITHUB_USERNAME', 
                passwordVariable: 'GITHUB_PASSWORD'),

                usernamePassword(credentialsId: 'Docker-Hub-Credentials', 
                usernameVariable: 'DOCKER_HUB_USERNAME', 
                passwordVariable: 'DOCKER_HUB_PASSWORD'),

                string(credentialsId: 'Slack-Token-For-Incoming-Webhooks', 
                variable: 'SLACK_TOKEN')]) {

                  echo "DOCKER_HUB_USERNAME ${DOCKER_HUB_USERNAME}"
	                echo "DOCKER_HUB_PASSWORD ${DOCKER_HUB_PASSWORD}"

                  echo "GITHUB_USERNAME ${GITHUB_USERNAME}"
	                echo "GITHUB_PASSWORD ${GITHUB_PASSWORD}"

                  echo "SLACK_TOKEN ${SLACK_TOKEN}"

                  sh "cat /etc/*release"
                }
            }
        }
    }
}
```