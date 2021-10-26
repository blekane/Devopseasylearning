### basic node
```groovy
node{
    echo 'this is scripted pipeline'
}
```

### basic node with stages
```groovy
node{
    
    stage('Build')
    {
        echo 'this is scripted pipeline with stage'
    }
}
```

### basic node->stage->node
```groovy
node{
	stage('Build')
	{
		node { //execute the stage on any nodes
			echo 'this is node in stage'
		}
	}
}
```

### no node - just stages
```groovy
stage('Build')
{
	echo 'this is scripted pipeline with stage Build'
}
	
stage('Deploy')
{
	echo 'this is scripted pipeline with stage Deploy'
}	
```

### specify slaves
```groovy
node('master'){
    
    node('Slave 1'){
		stage('Build')
		{
			echo 'this is node in stage Slave 1'
		}
    }
}
```

##  Docker > Image
```groovy
node {
	stage('Build'){
		def mavenImage = docker.image('maven:3.5.3-jdk-10-slim')
		
		mavenImage.inside{
			sh 'mvn -v'
		}
    }
}



node{

	stage('Build') {	
		def mavenImage = docker.image('maven:3.5.3-jdk-10-slim')
		
		mavenImage.inside{
			sh 'mvn -v'
		}
	}	

	stage('Deploy') {	
		def mavenImage = docker.image('maven:3.5.3-jdk-10-slim')
		
		mavenImage.inside{
			sh 'mvn -v'
		}
	}
}
```

## Docker > Args
```groovy
node {
	stage('Build'){
		def mavenImage = docker.image('maven:3.5.3-jdk-10-slim')
		
		mavenImage.inside('-e VAULT_PASSWORD=HGGDDN125CVF',{ 
			sh '''
            echo $VAULT_PASSWORD
            cat /etc/*release
            java --version
            mvn --version
            '''

		})
    }
}
```

## Docker > AlwaysPull
```groovy
node {
	stage('Build'){
		def mavenImage = docker.image('maven:3.5.3-jdk-10-slim')
		
		mavenImage.pull()
		
		mavenImage.inside('-e VAULT_PASSWORD=HGGDDN125CVF',{ 
			sh '''
            echo $VAULT_PASSWORD
            cat /etc/*release
            java --version
            mvn --version
		})
    }
}
```

## Docker > CustomWorkspace
ws = Workspace
```groovy
node {
	stage('Build'){
	
		ws('/var/lib/jenkins/workspace/nodeDockerCustomWorkspace'){
	
			def mavenImage = docker.image('maven:3.5.3-jdk-10-slim')
				
			mavenImage.inside{ 
				sh 'mvn -v'
			}
		}
    }
}
```

## Docker > RegistryUrl/CredentialsId
https://quay.io = registry url
quay.io = credential ID store in jenkins
pipelineascodecourse/myfirstrepo:latest = image
```groovy
node {
	stage('Build'){
		def mavenImage = docker.withRegistry('https://quay.io','quay.io'){
			docker.image('quay.io/pipelineascodecourse/myfirstrepo:latest').inside {
				sh 'printenv'
			}
		}
    }
}


node {
	stage('Build'){
		def mavenImage = docker.withRegistry('https://registry.hub.docker.com','Docker-Hub-Credentials'){
			docker.image('leonardtia/devops-pro-repos:covid19').inside {
				sh '''
                ls -l /usr/local/apache2/htdocs/
                cat /etc/*release
                '''
			}
		}
    }
}
```

## Dockerfile
```groovy
node {
	stage('Build'){
		checkout([$class: 'GitSCM', 
			branches: [[name: "origin/master"]], 
			userRemoteConfigs: [[
			url: 'https://github.com/pipelineascodecourse/pipeline-agent-dockerfile.git']]
		])

		def myCustomUbuntuImage = docker.build("my-ubuntu:my-latest")

		myCustomUbuntuImage.inside {
			sh 'cat /etc/lsb-release'
		}
	}
}
```

## Dockerfile > Dir
```groovy
node {
	stage('Build'){
		checkout([$class: 'GitSCM', 
			branches: [[name: "origin/master"]], 
			userRemoteConfigs: [[
			url: 'https://github.com/pipelineascodecourse/pipeline-agent-dockerfile-dir.git']]
		])

		def myCustomUbuntuImage = docker.build("my-ubuntu:my-latest","./dockerfileDir")

		myCustomUbuntuImage.inside {
			sh 'cat /etc/lsb-release'
		}
	}
}
```

## Dockerfile > Filename
```groovy
node {
	stage('Build'){
		checkout([$class: 'GitSCM', 
			branches: [[name: "origin/master"]], 
			userRemoteConfigs: [[
			url: 'https://github.com/pipelineascodecourse/pipeline-agent-dockerfile-filename.git']]
		])

		def myCustomUbuntuImage = docker.build("my-ubuntu:my-latest","--file myCustomNameDockerfile .")

		myCustomUbuntuImage.inside {
			sh 'cat /etc/lsb-release'
		}
	}
}
```

## Dockerfile > AdditionalBuildArgs
```groovy
node {
	stage('Build'){
		checkout([$class: 'GitSCM', 
			branches: [[name: "origin/master"]], 
			userRemoteConfigs: [[
			url: 'https://github.com/pipelineascodecourse/pipeline-agent-dockerfile.git']]
		])

		def myCustomUbuntuImage = docker.build("my-ubuntu:my-latest","--tag mydockerfile:example .")

		myCustomUbuntuImage.inside {
			sh 'cat /etc/lsb-release'
		}
	}
}
```

## Dockerfile > CustomWorkspace
```groovy
node {
	stage('Build'){
	
		ws('/var/lib/jenkins/workspace/scripted-dockerfile-customWorkspace/checkout-directory'){
	
			checkout([$class: 'GitSCM', 
				branches: [[name: "origin/master"]], 
				userRemoteConfigs: [[
                url: 'https://github.com/pipelineascodecourse/pipeline-agent-dockerfile.git']]				
				])
	
			def myUbuntuImage = docker.build("my-ubuntu:my-latest")
				
			myUbuntuImage.inside{ 
				sh 'cat /etc/lsb-release'
			}
		}
    }
}
```

## Stage > Options > Error/Retry
```groovy
node{
	stage('Build'){	
		retry(3){
			error "Error statement just got executed"
		}
	}
}


node{
	retry(3){
		stage('Build'){		
			error "Error statement just got executed"
		}
	}
}


retry(3){
	node{
		error "Error statement just got executed"
	}
}
```

## Stage > Options > Timeout
```groovy

node{
	stage('Build'){	
	
		//values: NANOSECONDS, MICROSECONDS, MILLISECONDS, SECONDS, MINUTES, HOURS, DAYS
		timeout(time: 1, unit: 'SECONDS')  {
			//sleeping for 2 seconds
			sleep 2
		}
	}
}


node{
	timeout(time: 1, unit: 'SECONDS')  {
		stage('Build'){		
			sleep 2
		}
	}
}


timeout(time: 1, unit: 'SECONDS')  {
	node{
		sleep 2
	}
}
```

## Stage > Options > Timestamps
```groovy

//node level timestamp
node{
	timestamps {
		stage('Build'){
			echo 'Build stage echo statement printed out with timestamp'
		}		
		stage('Deploy'){
			echo 'Deploy stage echo statement printed out with timestamp'
		}		
	}
}


//stage level timestamp
node{
	stage('Build'){
		timestamps {
			echo 'echo statement printed out WITH timestamp'
		}		
	}
	
	stage('Deploy'){
		echo 'echo statement printed out WITHOUT timestamp'
	}
}
```

## Stage > Environment Credentials
```groovy
//single credentials example
node {
  withCredentials([	usernamePassword(
						credentialsId: 'some_username_password', 
						usernameVariable: 'SOME_USERNAME', 
						passwordVariable: 'SOME_PASSWORD')]) {
	echo "SOME_USERNAME ${SOME_USERNAME}"
	echo "SOME_PASSWORD ${SOME_PASSWORD}"
  }
}

node {
  withCredentials([	usernamePassword(
						credentialsId: 'Docker-Hub-Credentials', 
						usernameVariable: 'DOCKER_HUB_USERNAME', 
						passwordVariable: 'DOCKER_HUB_PASSWORD')]) {
	echo "DOCKER_HUB_USERNAME ${DOCKER_HUB_USERNAME}"
	echo "DOCKER_HUB_PASSWORD ${DOCKER_HUB_PASSWORD}"
  }
}


//multiple credentials example
node {
  withCredentials([	usernamePassword(
						credentialsId: 'some_username_password', 
						usernameVariable: 'SOME_USERNAME', 
						passwordVariable: 'SOME_PASSWORD'),
						
					string(
						credentialsId:'some_secret', 
						variable:'SOME_SECRET')]) {
						
	echo "SOME_USERNAME ${SOME_USERNAME}"
	echo "SOME_PASSWORD ${SOME_PASSWORD}"
	
	echo "SOME_SECRET ${SOME_SECRET}"
  }
}

node {
  withCredentials([	usernamePassword(
						credentialsId: 'Docker-Hub-Credentials', 
						usernameVariable: 'DOCKER_HUB_USERNAME', 
						passwordVariable: 'DOCKER_HUB_PASSWORD'),

					string(
						credentialsId: 'Slack-Token-For-Incoming-Webhooks', 
						variable: 'SLACK_TOKEN'),

					usernamePassword(
						credentialsId: 'GitHub-Credentials', 
						usernameVariable: 'GITHUB_USERNAME', 
						passwordVariable: 'GITHUB_PASSWORD')]) {
						
	echo "DOCKER_HUB_USERNAME ${DOCKER_HUB_USERNAME}"
	echo "DOCKER_HUB_PASSWORD ${DOCKER_HUB_PASSWORD}"

    echo "GITHUB_USERNAME ${GITHUB_USERNAME}"
	echo "GITHUB_PASSWORD ${GITHUB_PASSWORD}"

    echo "SLACK_TOKEN ${SLACK_TOKEN}"
  }
}
```

## Stage > When 
```groovy
node{
	def name="jeff"
	def isGroovyCool = false
    withEnv(['DEPLOY_TO=production']) {
        stage('Build') {
		
			//when-environment condition
			if(env.DEPLOY_TO == 'production')
				println "Deploying"
				
			//when-equals condition
			if(	name == "jeff")
				println "name is ${name}"

			//when-expression condition				
			if(isGroovyCool == false)
				println "groovy is always cool"
				
			//when-not condition
			if(	name != "john")
				println "name is not john"			
			
			//when-allOf condition			
			if( name == "jeff" && !isGroovyCool)
				println "name is ${name} and groovy is cool"
				
			//when-anyOf condition	
			if( name == "jeff" || !isGroovyCool)
				println "name is ${name} or groovy is cool"	
        }
    }
}
```

## Stage > When > Branch
```groovy
//https://github.com/pipelineascodecourse/scripted-when-branch
node {
        if(env.BRANCH_NAME == 'master'){
			stage('Build Master') {
                echo 'Building master'
            }
        }
		
		if(env.BRANCH_NAME == 'dev'){
			stage('Build Dev') {            
                echo 'Building dev'
            }
        }


//https://github.com/pipelineascodecourse/scripted-when-buildingTag_and_tag
node{
	stage("Build"){
		if(env.TAG_NAME != null){
			println(" we are building a tag and tag is ${env.TAG_NAME}")
		}
		else{
			println(" we are building a branch")
		}
		
		if(env.TAG_NAME == "release-1.0"){
			println(" we are building specifically release-1.0 tag")
		}
		
	}
}

//https://github.com/pipelineascodecourse/scripted-when-changeRequest
node{
	stage('Build'){
		println "env.CHANGE_ID: ${env.CHANGE_ID}"
		println "env.CHANGE_URL: ${env.CHANGE_URL}"
		println "env.CHANGE_TITLE: ${env.CHANGE_TITLE}"
		println "env.CHANGE_AUTHOR: ${env.CHANGE_AUTHOR}"
		println "env.CHANGE_AUTHOR_DISPLAY_NAME: ${env.CHANGE_AUTHOR_DISPLAY_NAME}"
		println "env.CHANGE_AUTHOR_EMAIL: ${env.CHANGE_AUTHOR_EMAIL}"
		println "env.CHANGE_TARGET: ${env.CHANGE_TARGET}"

		if(env.CHANGE_TITLE == "when-pr"){
			echo "pull request is found"
		}
		else {
			echo "pull request is not found"
		}
	}
}
```

## Stage > Parallel/FailFast
```groovy
//parallel example
node{
	stage('Running in Parallel') {
		parallel 'Parallel1': {
			echo "Parallel1 executing"
			sleep 10
		},
		'Parallel2': {
			echo "Parallel2 executing"
			sleep 10
		},
		'Parallel3': {
			echo "Parallel3 executing"
			sleep 10
		},
		failFast : true //terminate the job if a stage faile
	}
}

//sequential example
node {
	stage('Stage1') {
		echo "Stage1 executing"
		sleep 10
	}
	stage('Stage2') {
		echo "Stage2 executing"
		sleep 10
	}
	stage('Stage3') {
		echo "Stage3 executing"
		sleep 10
	}
}


//parallel example
pipeline {
    agent any
    stages {
        stage('Stages Running in Parallel') {
            failFast true
            parallel {
                stage('Stage1') {
                    steps {
                        echo "Stage1 executing"
                        sleep 10
                    }
                }
                stage('Stage2') {
                    steps {
                        echo "Stage2 executing"
                        sleep 10
                    }
                }
                stage('Stage3') {
                    steps {
                        echo "Stage3 executing"
                        sleep 10
                    }                    
                }
            }
        }
    }
}


//sequential example
pipeline {
    agent any
    stages {
		stage('Stage1') {
			steps {
				echo "Stage1 executing"
				sleep 10
			}
		}
		stage('Stage2') {
			steps {
				echo "Stage2 executing"
				sleep 10
			}
		}
		stage('Stage3') {
			steps {
				echo "Stage3 executing"
				sleep 10
			}                    
		}
    }
}


//failfast example
pipeline {
    agent any
    stages {
		stage('Stages Running in Parallel') {
            failFast true
            parallel {
                stage('Stage1') {
                    steps {
                        echo "Stage1 executing"
                        sleep 10
                    }
                }
                stage('Stage2') {
                    steps {
                        echo "Stage2 executing"
                        sleep 2
						error 'simulating error happened on Stage2'
                    }
                }
                stage('Stage3') {
                    steps {
                        echo "Stage3 executing"
                        sleep 10
                    }                    
                }
            }
        }	
    }
}
```

## Stage > Input
```groovy
//example 1
node{
	def userInput = ""
	stage('Build') {
		userInput = input(id: 'userInput',    
						message: 'Please specify environment',    
						submitterParameter: "whoIsSubmitter",
						parameters: [
							string(name: 'environment', defaultValue: 'Dev', description: 'Environment to build for (Valid values: Dev, Test, Prod)'),
							string(name: 'version', defaultValue: '1.0', description: 'Version number to build for'),
							booleanParam(name: 'to_deploy_to_environment', defaultValue: true, description: ''),
							choice(choices: 'US-EAST-1\nUS-WEST-2', description: 'What AWS region?', name: 'region'),
							text(name:'myText', defaultValue:'myTextValue', description:'myText'),
							password(name:'myPassword', defaultValue:'myPasswordValue', description:'myDescription'),
							file(name:'myFile', description:'fileDescription'),
							credentials(name:'myCredentials', description:'myCredentailsDesc', required:true)
						]  
		)
	  
		echo "We are building for ${userInput.environment}, ${userInput.version}, and we are deploying to environment: ${userInput.to_deploy_to_environment}"
		echo "region:${userInput.region}, myText: ${userInput.myText}, myPassword: ${userInput.myPassword}, and myFile: ${userInput.myFile}"
		echo "submitter is: ${userInput.whoIsSubmitter}"
	}
}

		

//example 2		
//Time out with input example

node{
	def userInput = ""
	stage('Build') {
		timeout(time: 1, unit: 'SECONDS'){ //the build should timeout after 1 second if there is no input
			userInput = input(id: 'userInput',    
							message: 'Please specify environment',    
							submitterParameter: "whoIsSubmitter",
							parameters: [
								string(name: 'environment', defaultValue: 'Dev', description: 'Environment to build for (Valid values: Dev, Test, Prod)'),
								string(name: 'version', defaultValue: '1.0', description: 'Version number to build for'),
								booleanParam(name: 'to_deploy_to_environment', defaultValue: true, description: ''),
								choice(choices: 'US-EAST-1\nUS-WEST-2', description: 'What AWS region?', name: 'region'),
								text(name:'myText', defaultValue:'myTextValue', description:'myText'),
								password(name:'myPassword', defaultValue:'myPasswordValue', description:'myDescription'),
								file(name:'myFile', description:'fileDescription'),
								credentials(name:'myCredentials', description:'myCredentailsDesc', required:true)
							]  
			)
		  
			echo "We are building for ${userInput.environment}, ${userInput.version}, and we are deploying to environment: ${userInput.to_deploy_to_environment}"
			echo "region:${userInput.region}, myText: ${userInput.myText}, myPassword: ${userInput.myPassword}, and myFile: ${userInput.myFile}"
			echo "submitter is: ${userInput.whoIsSubmitter}"
		}
	}
}
```

## Options > BuildDiscarder
```groovy
node{
	properties(
		[
			buildDiscarder(
				logRotator(
					numToKeepStr: '1'
				)
			)
		]
	)
	
	stage('Build'){
		echo 'Hello World'
	}
}
```

## DisableConcurrentBuilds
```groovy
node{
	properties(
		[
			disableConcurrentBuilds()
		]
	)
	
	stage('Build'){
		sleep(time: 10, unit: 'SECONDS') 	
                echo 'Hello World'	
	}
}
```

## Options > SkipStagesAfterUnstable
```groovy
node{	
	stage('Build'){	
		echo "setting current build to unstable"	
        currentBuild.result = 'UNSTABLE'	
    }	
	
	if(currentBuild.result != 'UNSTABLE'){
		stage('Deploy'){	
			echo "deploy is running"	
		}
	}
}
```

## Options > CheckoutToSubdirectory
```groovy
//https://github.com/pipelineascodecourse/scripted-checkoutToSubdirectory
node{
	ws("/var/lib/jenkins/workspace/scripted-checkoutToSubDirectory/someSubDir") {
		checkout([$class: 'GitSCM',
					branches: [[name: "origin/master"]], 
					userRemoteConfigs: [[
					url: 'https://github.com/pipelineascodecourse/scripted-checkoutToSubdirectory.git']]
					])
		stage('Build'){
			echo 'Hello World 1'
		}
	}
}

```
##  Options > NewContainerPerStage
```groovy
node{

	stage('Build') {	
		def mavenImage = docker.image('maven:3.5.3-jdk-10-slim')
		
		mavenImage.inside{
			sh 'mvn -v'
		}
	}	

	stage('Deploy') {	
		def mavenImage = docker.image('maven:3.5.3-jdk-10-slim')
		
		mavenImage.inside{
			sh 'mvn -v'
		}
	}
}

node {
	stage('Build'){
	
		ws('/var/lib/jenkins/workspace/nodeDockerCustomWorkspace'){
	
			def mavenImage = docker.image('maven:3.5.3-jdk-10-slim')
				
			mavenImage.inside{ 
				sh 'mvn -v'
			}
		}
    }
}
```

##  Tools
```groovy
node{
	def mavenHome = tool name: 'maven3_0_5', type: 'maven'
    sh "${mavenHome}/bin/mvn -v"
}
```

##  Parameters
```groovy
node{
	def userInput = ""
	stage('Build') {
		userInput = input(id: 'userInput',    
						message: 'Please specify environment',    
						submitterParameter: "whoIsSubmitter",
						parameters: [
							string(name: 'environment', defaultValue: 'Dev', description: 'Environment to build for (Valid values: Dev, Test, Prod)'),
							string(name: 'version', defaultValue: '1.0', description: 'Version number to build for'),
							booleanParam(name: 'to_deploy_to_environment', defaultValue: true, description: ''),
							choice(choices: 'US-EAST-1\nUS-WEST-2', description: 'What AWS region?', name: 'region'),
							text(name:'myText', defaultValue:'myTextValue', description:'myText'),
							password(name:'myPassword', defaultValue:'myPasswordValue', description:'myDescription'),
							file(name:'myFile', description:'fileDescription'),
							credentials(name:'myCredentials', description:'myCredentailsDesc', required:true)
						]  
		)
	  
		echo "We are building for ${userInput.environment}, ${userInput.version}, and we are deploying to environment: ${userInput.to_deploy_to_environment}"
		echo "region:${userInput.region}, myText: ${userInput.myText}, myPassword: ${userInput.myPassword}, and myFile: ${userInput.myFile}"
		echo "submitter is: ${userInput.whoIsSubmitter}"
	}
}


node() {
   // adds job parameters within jenkinsfile
   properties([
     parameters([
       string(
         defaultValue: 'Dev',
         description: 'Environment to build for (Valid values: Dev, Test, Prod)',
         name: 'environment'
       ),
       booleanParam(
         defaultValue: true,
         description: '',
         name: 'to_deploy_to_environment'
       ),
	   choice(
		choices: 'US-EAST-1\nUS-WEST-2', 
		description: 'What AWS region?', 
		name: 'region'
		),
	   text(
	   name:'myText', 
	   defaultValue:'myTextValue', 
	   description:'myText'
	   ),
	   password(
	   name:'myPassword', 
	   defaultValue:'myPasswordValue', 
	   description:'myDescription'
	   ),
	   file(
	   name:'myFile', 
	   description:'fileDescription'
	   ),
	   credentials(
	   name:'myCredentials', 
	   description:'myCredentailsDesc', 
	   required:true)			   
     ])
   ])
   
    echo "We are building for ${params.environment}, and we are deploying to environment: ${params.to_deploy_to_environment}"
	echo "region:${params.region}, myText: ${params.myText}, myPassword: ${params.myPassword}, and myFile: ${params.myFile}"
	echo "selected credentials is: ${params.myCredentials}"
}
```

## Triggers > Cron
```groovy
node{	
	properties(
		[
			pipelineTriggers(
				[
					//minute, hour, day of month, month, and day of week (0 and 7 are sundays)
					cron('0 1 2 3 1-7')
					
					//cron('H */2 1-3 1,3 2-4')
					
					//@yearly, @annually, @monthly, @weekly, @daily, @midnight, @hourly
					//cron('@daily')
					
					//cron('TZ=Europe/London\n0 1 * * 1-7')										
				]
			),
		]
	)
	stage('Build'){	
        echo 'Hello World'		
    }	
}
```

## Triggers > PollSCM
```groovy
node{	
	properties(
		[
			pipelineTriggers(
				[
					pollSCM('* * * * *') //checking thios repo every 1 minutes and pull if there is a change
				]
			),
		]
	)
        stage('Build') {				
			checkout([$class: 'GitSCM', 				
			branches: [[name: "origin/master"]], 
			userRemoteConfigs: [[
			url: 'https://github.com/pipelineascodecourse/scripted-pollSCM.git']]])
        }		
}
```


## Triggers > Upstream
```groovy

node {			
	stage('Build') {			
		echo 'scripted-upstream-job2 executed'				
	}			
}

node {			
	stage('Build') {			
		echo 'scripted-upstream-job1 executed'			
	}			
}

// this job will trigger anytime that scripted-upstream-job1 or scripted-upstream-job2 is SUCCESS
node{	
	properties(
		[
			pipelineTriggers([
				triggers: [
						[
							$class: 'jenkins.triggers.ReverseBuildTrigger',
							upstreamProjects: "scripted-upstream-job1,scripted-upstream-job2", 
							threshold: hudson.model.Result.SUCCESS //UNSTABLE, FAILURE, NOT_BUILT and ABORTED
						]
				]
			]),
		]
	)
	stage('Build') {			
		echo 'scripted-upstream executed'
	}
}
```