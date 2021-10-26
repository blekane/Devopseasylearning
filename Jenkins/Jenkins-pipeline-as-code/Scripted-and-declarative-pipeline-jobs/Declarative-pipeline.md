```groovy
//pipeline-helloworld
pipeline{
    agent any
    stages{
        stage("Build"){
            steps{
                echo "Hello World"
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
				
					def name = "jeff"
					
					if(name == "jeff")
						println("hi ${name}")
					else
						println("hi human")				
												
					sleep 2	
					echo "end of script"
				}
            }
        }
    }
}


//retry
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                retry(3) {
					echo "before throwing error"
                    error "error in retry"
                }
                
                echo "after retry(3)"
            }
        }
    }
}

// 5 minutes timeouts
// This stage will timeouts after 5 minutes
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                timeout(time: 5, unit: 'SECONDS') //DAYS,HOURS,MICROSECONDS ,MILLISECONDS ,MINUTES ,NANOSECONDS ,SECONDS 
				{
                    echo "sleeping in timeout"
                    sleep 30
                }
            }
        }
    }
}

pipeline {
    agent any

    stages {
        stage('Build') {
		    options {
				timeout(time: 1, unit: 'SECONDS')  //values: NANOSECONDS, MICROSECONDS, MILLISECONDS, SECONDS, MINUTES, HOURS, DAYS
			}
            steps {
                echo 'Hello World'
				sleep 2
            }
        }
    }
}



// 1 hour timeouts
pipeline {
  options {
      timeout(time: 1, unit: 'HOURS') 
  }
  stages { .. }
  // ..
}

//10 seconds minutes timeout
pipeline {
    agent any
    options {
        timeout(time: 10, unit: 'SECONDS') 
    }
    stages {
        stage('Example') {
            steps {
                echo 'Hello World'
                sleep 35
            }
        }
    }
}

// 3 minutes timeout
pipeline {
    agent any
    stages {
        stage('Deploy') {
            steps {
                retry(3) {
                    sh './flakey-deploy.sh'
                }

                timeout(time: 3, unit: 'MINUTES') {
                    sh './health-check.sh'
                }
            }
        }
    }
}

//retry->timeout
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                retry(3) {
				    timeout(time: 1, unit: 'SECONDS') {
							sleep 2
					}
                    echo "after timeout"
                }
            }
        }
    }
}


//This tools should already install in jenkins and added in global tools configuration
pipeline {
    agent any

    stages {
        stage('Build') {
		    tools {
				maven 'maven3_5_2' 
				maven 'maven3_0_5' 
                java 'jdk11'
			}
            steps {
                sh 'mvn --version'
            }
        }
    }
}


pipeline{
    agent any
    stages{
        stage("Build"){
			options{
				retry(3)
			}
            steps{
                echo "Before error statement"
                error "Error statement just got executed"
                echo "After error statement"
            }
        }
    }
}


pipeline{
    agent any
    stages{
        stage("Build"){
			options{
				retry(3)
			}
            steps{
                echo "Before setting current build to FAILURE"
                script {
                    currentBuild.result = 'FAILURE'
                }
				echo "After setting current build to FAILURE"
            }
        }
    }
}


//Pipeline > Stage > Options > Timestamps
// We should be seeing the timestamps printing after the for the Build stage and not the Test stage
pipeline{
    agent any

    stages{
        stage('Build'){
		    options { 
				timestamps() 
			}
            steps{
                echo "Hello World in Build"
                echo "Hello World in Build Again"
            }
        }
		
        stage('Test'){

            steps{
                echo "Hello World in Test"
                echo "Hello World in Test Again"
            }
        }		
    }
}

//Pipeline > Stage > Options > Timestamps
// We should be seeing the timestamps printing every stage
pipeline{
    agent any

	options { 
		timestamps() 
	}	
	
    stages{
        stage('Build'){

            steps{
                echo "Hello World"
                echo "Hello World Again"
            }
        }
	
        stage('Test'){

            steps{
                echo "Hello World in Test"
                echo "Hello World in Test Again"
            }
        }		
    }		
}


//Input
pipeline {
    agent none
    stages {
        stage('Example') {
            input {
                message "Should we continue?"
                ok "Yes, we should."
                submitter "alice,bob"
                parameters {
                    string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
                }
            }
            agent any
            steps {
                echo "Hello, ${PERSON}, nice to meet you."
            }
        }
    }
}


// docker agent
pipeline {
    agent none 
    stages {
        stage('Example Build') {
            agent { docker 'maven:3-alpine' } 
            steps {
                echo 'Hello, Maven'
                sh 'mvn --version'
            }
        }
        stage('Example Test') {
            agent { docker 'openjdk:8-jre' } 
            steps {
                echo 'Hello, JDK'
                sh 'java -version'
            }
        }
    }
}

pipeline {
    agent none 
    stages {
        stage('Example Build') {
            agent { docker 'maven:3.8.1-adoptopenjdk-11' } 
            steps {
                echo 'Hello, Maven'
                sh 'mvn --version'
            }
        }
        stage('Example Test') {
            agent { docker 'openjdk:8-jre' } 
            steps {
                echo 'Hello, JDK'
                sh 'java -version'
            }
        }
    }
}

// pollSCM or triggers
pipeline {
    agent any
    triggers {
        cron('H 4/* 0 0 1-5')
    }
    stages {
        stage('Example') {
            steps {
                echo 'Hello World'
            }
        }
    }
}

pipeline {
    agent any
    triggers {
        cron('* * * * *')
    }
    stages {
        stage('Example') {
            steps {
                echo 'Hello World'
            }
        }
    }
}


pipeline {
    agent any
    parameters {
        string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')

        text(name: 'BIOGRAPHY', defaultValue: '', description: 'Enter some information about the person')

        booleanParam(name: 'TOGGLE', defaultValue: true, description: 'Toggle this value')

        choice(name: 'CHOICE', choices: ['One', 'Two', 'Three'], description: 'Pick something')

        password(name: 'PASSWORD', defaultValue: 'SECRET', description: 'Enter a password')
    }
    stages {
        stage('Example') {
            steps {
                echo "Hello ${params.PERSON}"

                echo "Biography: ${params.BIOGRAPHY}"

                echo "Toggle: ${params.TOGGLE}"

                echo "Choice: ${params.CHOICE}"

                echo "Password: ${params.PASSWORD}"
            }
        }
    }
}


//Pipeline > Stage > Environment Credentials
//global variable
pipeline {
    agent any
    environment { 
        name1 = "Jeff"
		name2 = "John"
    }
    stages {
        stage('Build') {
            environment { 
                name3 = "Jamie"

            }
            steps {
                echo "name1 ${name1}"
                echo "name2 ${name2}"
                echo "name3 ${name3}"
            }
        }
    }
}

//local variable
pipeline {
    agent any
    environment { 
        name1 = "Jeff"
		name2 = "John"
    }
    stages {
        stage('Build') {
            environment { 
                name3 = "Jamie"
            }
            steps {
                echo "name1 ${name1}"
                echo "name2 ${name2}"
                echo "name3 ${name3}"
            }
        }

        stage('Test') {
            steps {
                echo "name1 ${name1}"
                echo "name2 ${name2}"
                echo "name3 ${name3}" // you will have an error here
            }
        }		
    }
}


pipeline {
    agent any
    environment { 
        name1 = "Jeff"
		name2 = "John"
    }
    stages {
        stage('Build') {
            environment { 
				name2 = "Mike" //local variable will be printed
                name3 = "Jamie"
            }
            steps {
                echo "name1 ${name1}"
                echo "name2 ${name2}"
                echo "name3 ${name3}"
            }
        }
    }
}


pipeline {
    agent any
    environment { 
        name1 = "Jeff"
		name2 = "John"
    }
    stages {
        stage('Build') {
            environment { 
                name3 = "Jamie"
            }
            steps {
                echo "name1 ${name1}"
                echo "name2 ${name2}"
                echo "name3 ${name3}"
                sh "printenv"
            }
        }
    }
}


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
```sh
# RESULT

JAVA_URL_VERSION=8u242b08
JENKINS_HOME=/var/jenkins_home
JENKINS_UC_EXPERIMENTAL=https://updates.jenkins.io/experimental
RUN_CHANGES_DISPLAY_URL=http://ec2-18-218-82-126.us-east-2.compute.amazonaws.com:8070/job/test3/16/display/redirect?page=changes
HOSTNAME=20f98983f366
NODE_LABELS=master
HUDSON_URL=http://ec2-18-218-82-126.us-east-2.compute.amazonaws.com:8070/
SHLVL=0
JAVA_BASE_URL=https://github.com/AdoptOpenJDK/openjdk8-upstream-binaries/releases/download/jdk8u242-b08/OpenJDK8U-jdk_
HOME=/var/jenkins_home
BUILD_URL=http://ec2-18-218-82-126.us-east-2.compute.amazonaws.com:8070/job/test3/16/
HUDSON_COOKIE=d558b4aa-b6d3-4a21-8c5e-162d8eaa979c
JENKINS_SERVER_COOKIE=durable-f72a3f1ae3cbdbf804dd3f9733df43b7
JENKINS_UC=https://updates.jenkins.io
WORKSPACE=/var/jenkins_home/workspace/test3
REF=/usr/share/jenkins/ref
JAVA_VERSION=8u242
NODE_NAME=master
RUN_ARTIFACTS_DISPLAY_URL=http://ec2-18-218-82-126.us-east-2.compute.amazonaws.com:8070/job/test3/16/display/redirect?page=artifacts
STAGE_NAME=Build
EXECUTOR_NUMBER=0
JENKINS_VERSION=2.276
RUN_TESTS_DISPLAY_URL=http://ec2-18-218-82-126.us-east-2.compute.amazonaws.com:8070/job/test3/16/display/redirect?page=tests
JENKINS_INCREMENTALS_REPO_MIRROR=https://repo.jenkins-ci.org/incrementals
BUILD_DISPLAY_NAME=#16
HUDSON_HOME=/var/jenkins_home
JOB_BASE_NAME=test3
PATH=/usr/local/openjdk-8/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
BUILD_ID=16
BUILD_TAG=jenkins-test3-16
LANG=C.UTF-8
JENKINS_URL=http://ec2-18-218-82-126.us-east-2.compute.amazonaws.com:8070/
JOB_URL=http://ec2-18-218-82-126.us-east-2.compute.amazonaws.com:8070/job/test3/
BUILD_NUMBER=16
JENKINS_NODE_COOKIE=faba0145-bbbb-4abe-8051-5efbcc3f74ee
RUN_DISPLAY_URL=http://ec2-18-218-82-126.us-east-2.compute.amazonaws.com:8070/job/test3/16/display/redirect
JENKINS_SLAVE_AGENT_PORT=50000
HUDSON_SERVER_COOKIE=ff987be319ec3889
JOB_DISPLAY_URL=http://ec2-18-218-82-126.us-east-2.compute.amazonaws.com:8070/job/test3/display/redirect
JOB_NAME=test3
COPY_REFERENCE_FILE_LOG=/var/jenkins_home/copy_reference_file.log
JAVA_HOME=/usr/local/openjdk-8
PWD=/var/jenkins_home/workspace/test3
WORKSPACE_TMP=/var/jenkins_home/workspace/test3@tmp
```

```groovy
pipeline {
    agent any

    stages {
        stage('Build') {
            environment { 
                SOME_USERNAME_PASSWORD = credentials('some_username_password') //you create this in jenkins first  
                SOME_SECRET = credentials('some_secret') //you create this in jenkins first
            }
            steps {
				echo "SOME_USERNAME_PASSWORD ${SOME_USERNAME_PASSWORD}" //SOME_USERNAME_PASSWORD is in the format of username:password
                echo "SOME_USERNAME_PASSWORD_USR ${SOME_USERNAME_PASSWORD_USR}"
                echo "SOME_USERNAME_PASSWORD_PSW ${SOME_USERNAME_PASSWORD_PSW}"
                echo "SOME_SECRET ${SOME_SECRET}"
            }
        }
    }
}


//Pipeline > Stage > When

//equal condition
// the build will execude
pipeline {
    agent any
	environment{
		DEPLOY_TO='production'
	}
    stages {
        stage('Build') {
            when {
                environment name: 'DEPLOY_TO', value: 'production'
            }

            steps {
                echo 'Deploying'
            }
        }
    }
}

pipeline {
    agent any
    parameters {							
         choice(name: 'version', choices: ['1.20', '1.30', '1.8', '1.9'], description: 'Select a versin to deploy')
    }
    stages {
        stage("Build") {
            when {
                expression { 
					"${params.version}" == "1.20" 
				}
            }
            steps {
                echo "Deploy '${params.version}'"
            }
        }
    }
}


//equal condition
// the build will execude
pipeline {
    agent any
	environment{
		some_name="jeff"
	}	
    stages {
        stage('Build') {
            when {
                equals expected: "jeff", actual: some_name
            }
            steps {
				echo "${some_name}"
            }
        }
    }
}

//not equal condition
// the build will skipped
pipeline {
    agent any
	environment{
		some_name="jeff"
	}	
    stages {
        stage('Build') {
            when {
				not{
					equals expected: "jeff", actual: some_name
				}
            }
            steps {
				echo "${some_name}"
            }
        }
    }
}

// the build will execude
pipeline {
    agent any
	environment{
		some_name="tom"
	}	
    stages {
        stage('Build') {
            when {
				not{
					equals expected: "jeff", actual: some_name
				}
            }
            steps {
				echo "${some_name}"
            }
        }
    }
}

// the build will execude because is equal to 10
pipeline {
    agent any
	environment{
		version="1.0"
	}
    stages {
        stage("Build") {
            when {
                expression { 
					version == "1.0" 
				}
            }
            steps {
                echo "Building ${version}"
            }
        }
    }
}

// the build will skipped
pipeline {
    agent any
	environment{
		version="1.0"
	}
    stages {
        stage("Build") {
            when {
                expression { 
					version != "1.0" 
				}
            }
            steps {
                echo "Building ${version}"
            }
        }
    }
}

// all condition should true for the stage to execute
// this stage will be execute
pipeline {
    agent any
	environment{
		version="1.0"
		some_name="jeff"
	}
    stages {
        stage("Build") {
            when {
                allOf { // all condition should true for the stage to execute
					environment name: "version", value: "1.0"
					environment name: "some_name", value: "jeff"
				}
            }
            steps {
                echo "Building allOf ${version} ${some_name}"
            }
        }
    }
}

// this stage will be skipped (and condition)
pipeline {
    agent any
	environment{
		version="1.1.0"
		some_name="jeff"
	}
    stages {
        stage("Build") {
            when {
                allOf { // all condition should true for the stage to execute
					environment name: "version", value: "1.0"
					environment name: "some_name", value: "jeff"
				}
            }
            steps {
                echo "Building allOf ${version} ${some_name}"
            }
        }
    }
}

// any condition should be true for the to execute or one or more condition should be true (and condition)
pipeline {
    agent any
	environment{
		version="2.0"
		some_name="jeff"
	}
    stages {
        stage("Build") {
            when {
                anyOf { 
					environment name: "version", value: "1.0"
					environment name: "some_name", value: "jeff"
				}
            }
            steps {
                echo "Building anyOf ${version} ${some_name}"
            }
        }
    }
}

// this stage will be execute
pipeline {
    agent any
	environment{
		version="2.0"
		some_name="jeff"
	}
    stages {
        stage("Build") {
            when {
                anyOf { 
					environment name: "version", value: "2.0"
					environment name: "some_name", value: "jeff"
				}
            }
            steps {
                echo "Building anyOf ${version} ${some_name}"
            }
        }
    }
}

// this stage will be skipped
pipeline {
    agent any
	environment{
		version="2.0"
		some_name="jeff"
	}
    stages {
        stage("Build") {
            when {
                anyOf { 
					environment name: "version", value: "2.0"
					environment name: "some_name", value: "jeff"
				}
            }
            steps {
                echo "Building anyOf ${version} ${some_name}"
            }
        }
    }
}

// https://github.com/pipelineascodecourse/pipeline-stage-when-branch
//this will work only for multi-branch pipeline
pipeline {
    agent any
    stages {
        stage('Build Master') {
            when {
                branch 'master'
            }
            steps {
                echo 'Building master'
            }
        }
        stage('Build Dev') {
            when {
                branch 'dev'
            }
            steps {
                echo 'Building dev'
            }
        }
    }
}

// this will skip the checkout
//https://github.com/pipelineascodecourse/pipeline-stage-options-skipdefaultcheckout/blob/master/Jenkinsfile
pipeline {
    agent any
    options { 
	skipDefaultCheckout() 
    }

    stages {
        stage('Build') {
			agent any
			options { 
				skipDefaultCheckout() 
			}

            steps {                
                echo 'Hello World'
            }
        }
    }
}

//https://github.com/pipelineascodecourse/pipeline-stage-when-buildingTag-tag/blob/master/Jenkinsfile
pipeline {
    agent any
	
    stages {
        stage('Build') {
		
			when{
				tag "release-*"
			}
		
            steps {                
                echo 'Hello World building tag'
            }
        }
    }
}

//https://github.com/pipelineascodecourse/pipeline-stage-when-changelog/blob/master/Jenkinsfile
//pipeline-stage-when-changelog
pipeline {
    agent any
	
    stages {
        stage('Build') {
		
			when{
				changelog '.*some_text.*' //this will execute only if the commit message matches this regular expression
			}
		
            steps {                
                echo 'Hello World changelog'
            }
        }
    }
}

//pipeline-stage-when-changeRequest
//https://github.com/pipelineascodecourse/pipeline-stage-when-changeRequest/blob/master/Jenkinsfile
pipeline {
    agent any
	
    stages {
        stage('Build') {
		
			when{
				changeRequest title:"when-pr" //the stage will execute only if there is a PR (pull request)
			}
		
            steps {                
                echo 'Hello World changing request'
            }
        }
    }
}


//Pipeline > Stage > Parallel/FailFast
// all these will execute at the same time
// this will take 10 seconds
pipeline {
    agent any
    stages {
        stage('Stages Running in Parallel') {
            failFast true //this means if one of the stage fails, the reste of the stage should also fail
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

// this will take 30 seconds
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
						xxxxxx error 'simulating error happened on Stage2'// error here
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

//Pipeline > Stage > Input
pipeline{			
    agent any

    stages{
        stage('Build'){	
			input{
                    message "Please specify environment:"			
                    ok "OK"
					submitter "dummyuser,admin@localhost.com" //create these users in jenkins first
					submitterParameter "whoIsSubmitter"
                    parameters {
						string(name: 'environment', defaultValue: 'Dev', description: 'Environment to build for (Valid values: Dev, Test, Prod)')
						string(name: 'version', defaultValue: '1.0', description: 'Version number to build for')
						booleanParam(name: 'to_deploy_to_environment', defaultValue: true, description: '')
						choice(choices: 'US-EAST-1\nUS-WEST-2', description: 'What AWS region?', name: 'region')
						text(name:'myText', defaultValue:'myTextValue', description:'myText')
						password(name:'myPassword', defaultValue:'myPasswordValue', description:'myDescription')
						file(name:'myFile', description:'fileDescription')
						credentials(name:'myCredentials', description:'myCredentailsDesc', required:true)
                    }
                }			
            			
            steps{			
				echo "We are building for ${environment}, ${version}, and we are deploying to environment: ${to_deploy_to_environment}"
				echo "region:${region}, myText: ${myText}, myPassword: ${myPassword}, and myFile: ${myFile}"
				echo "submitter is: ${whoIsSubmitter}"
				echo "selected credentials is: ${myCredentials}"
			}
        }			
    }			
}				


//  Pipeline > Stage > Post
//Always/success/failure
pipeline{
    agent any
    stages{
        stage('Build'){
            steps{
                    echo "building"
                    //error("Build failed")
            }
        }
    }
    post{
		//Only runs if the current Pipeline’s or stage’s run has a "success" status
		success{
			echo 'post->success is called'
		}
		//Only runs if the current Pipeline’s or stage’s run has a "failed" status
		failure { 
            echo 'post->failure is called'
        }
		//Runs regardless of the completion status of the Pipeline’s or stage’s run.
        always { 
            echo 'post->always is called'
        }
    }
}

//changed 
pipeline{
    agent any
    stages{
        stage('Build'){
            steps{
                    echo "building"					
					//script{
					//	currentBuild.result = 'UNSTABLE'
					//}
            }
        }
    }
    post{
		//Only runs if the current Pipeline’s or stage’s run has a different completion status from its previous run.
        changed { 
            echo 'post->changed is called'
        }
    }
}

// unstable
// using example from above


		//Only run the steps in post if the current Pipeline’s or stage’s run has an "unstable" status, usually caused by test failures, code violations, etc. 
		unstable { 
            echo 'post->unstable is called'
        }




// fixed
pipeline{
    agent any
    stages{
        stage('Build'){
            steps{
                    echo "building"
            }
        }
    }
    post{
		//Only runs if the current Pipeline’s or stage’s run is successful and the previous run failed or was unstable.
		fixed { 
            echo 'post->fixed is called'
        }
    }
}


//regression
pipeline{
    agent any
    stages{
        stage('Build'){
            steps{
                    echo "building"
					error("Build failed")
            }
        }
    }
    post{
		//Only runs if the current Pipeline’s or stage’s status is failure, unstable, or aborted and the previous run was successful.
		regression { 
            echo 'post->regression is called'
        }
    }
}

//aborted
pipeline{
    agent any
    stages{
        stage('Build'){
            steps{
                    echo "building"
					script{
						currentBuild.result = 'ABORTED'
					}
            }
        }
    }
    post{
		//Only runs if the current Pipeline’s or stage’s run has an "aborted" status, usually due to the Pipeline being manually aborted. 
		aborted { 
            echo 'post->aborted is called'
        }
    }
}



//cleanup
pipeline{
    agent any
    stages{
        stage('Build'){
            steps{
                    echo "building"
                    //error("Build failed")
            }
        }
    }
    post{
		//Only runs if the current Pipeline’s or stage’s run has a "success" status, typically denoted by blue or green in the web UI.
		success{
			echo 'post->success is called'
		}
		//Only runs if the current Pipeline’s or stage’s run has a "failed" status, typically denoted by red in the web UI.
		failure { 
            echo 'post->failure is called'
        }
		//Runs regardless of the completion status of the Pipeline’s or stage’s run.
        always { 
            echo 'post->always is called'
        }
		//Runs after every other post condition has been evaluated, regardless of the status of Pipeline or stage
		cleanup{
			echo 'post->cleanup is called'
		}
    }
}


// Pipeline > Options > BuildDiscarder
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


//Pipeline > Options > DisableConcurrentBuilds
pipeline {	
    agent any	
    //options {	
    //    disableConcurrentBuilds()	
    //}	
    stages {	
        stage('Build') {	
            steps {	
                sleep(time: 10, unit: 'SECONDS') 	
                echo 'Hello World'	
            }	
        }	
    }	
}	


//Pipeline > Options > SkipStagesAfterUnstable
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


//Pipeline > Options > CheckoutToSubdirectory
//https://github.com/pipelineascodecourse/pipeline-options-checkoutToSubdirectory/blob/master/Jenkinsfile
pipeline {	
    agent any	
	options { 
		checkoutToSubdirectory('someSubDir') 
	}
    stages {	
        stage('Build') {	
            steps {                	
                echo 'Hello World'	
            }	
        }	
    }	
}	


//Pipeline > Options > NewContainerPerStage
pipeline {	
	agent {
		docker {
			image 'ubuntu:latest'
		}
	}
    options {	
        newContainerPerStage()
    }	
    stages {	
        stage('Build') {	
            steps {	
                sh 'cat /etc/lsb-release'
            }	
        }	
        stage('Deploy') {	
            steps {	
                sh 'cat /etc/lsb-release'
            }	
        }			
    }	
}

//Pipeline > Parameters
pipeline {							
    agent any							
    parameters {							
        string(name: 'environment', defaultValue: 'Dev', description: 'Environment to build for (Valid values: Dev, Test, Prod)')
		string(name: 'version', defaultValue: '1.0', description: 'Version number to build for')
		booleanParam(name: 'to_deploy_to_environment', defaultValue: true, description: '')
		choice(choices: 'US-EAST-1\nUS-WEST-2', description: 'What AWS region?', name: 'region')
		text(name:'myText', defaultValue:'myTextValue', description:'myText')
		password(name:'myPassword', defaultValue:'myPasswordValue', description:'myDescription')
		file(name:'myFile', description:'fileDescription')
		credentials(name:'myCredentials', description:'myCredentailsDesc', required:true)					
    }							
    stages {							
        stage('Example') {							
            steps {							
                echo "We are building for ${params.environment}, ${params.version}, and we are deploying to environment: ${params.to_deploy_to_environment}"
				echo "region:${params.region}, myText: ${params.myText}, myPassword: ${params.myPassword}, and myFile: ${params.myFile}"
				echo "selected credentials is: ${params.myCredentials}"
            }							
        }							
    }							
}							


pipeline{			
    agent any

    stages{
        stage('Build'){	
			input{
                    message "Please specify environment:"			
                    ok "OK"
					submitter "dummyuser,admin@localhost.com"
					submitterParameter "whoIsSubmitter"
                    parameters {
						string(name: 'environment', defaultValue: 'Dev', description: 'Environment to build for (Valid values: Dev, Test, Prod)')
						string(name: 'version', defaultValue: '1.0', description: 'Version number to build for')
						booleanParam(name: 'to_deploy_to_environment', defaultValue: true, description: '')
						choice(choices: 'US-EAST-1\nUS-WEST-2', description: 'What AWS region?', name: 'region')
						text(name:'myText', defaultValue:'myTextValue', description:'myText')
						password(name:'myPassword', defaultValue:'myPasswordValue', description:'myDescription')
						file(name:'myFile', description:'fileDescription')
						credentials(name:'myCredentials', description:'myCredentailsDesc', required:true)
                    }
                }			
            			
            steps{			
				echo "We are building for ${environment}, ${version}, and we are deploying to environment: ${to_deploy_to_environment}"
				echo "region:${region}, myText: ${myText}, myPassword: ${myPassword}, and myFile: ${myFile}"
				echo "submitter is: ${whoIsSubmitter}"
				echo "selected credentials is: ${myCredentials}"
			}
        }			
    }			
}				


//Pipeline > Pipeline Triggers > Cron
pipeline {		
    agent any		
    triggers {		
		//minute, hour, day of month, month, and day of week (0 and 7 are sundays)
        cron('0 1 2 3 1-7')
		
    }		
    stages {		
        stage('Build') {		
            steps {		
                echo 'Hello World'		
            }		
        }		
    }		
}


// Pipeline > Pipeline Triggers > PollSCM
```groovy
pipeline {				
    agent any				
    triggers {				
        pollSCM('* * * * *') //checking thios repo every 1 minutes and pull if there is a change				
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

//  Pipeline > Pipeline Triggers > Upstream
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



//Pipeline > Agent > Docker > ReuseNode
pipeline {
    agent {
        label 'Slave 1'
    }

    stages {
        stage('Build') {
            agent {
                docker { 
                    image 'maven:3.5.3-jdk-10-slim'
                    label 'Slave 2'
                }
            } 
            steps {
                sh 'mvn -v'
            }
        }
        stage('Deploy') {
            agent {
                docker { 
                    image 'ubuntu:16.04'
                    reuseNode true // job will run on slave 1
                }
            }
            steps {
                sh 'printenv'
            }
        }        
    }
    
}

pipeline {
    agent {
        label 'Slave 1'
    }

    stages {
        stage('Build') {
            agent {
                docker { 
                    image 'maven:3.5.3-jdk-10-slim'
                    label 'Slave 2'
                }
            } 
            steps {
                sh 'mvn -v'
            }
        }
        stage('Deploy') {
            agent {
                docker { 
                    image 'ubuntu:16.04'
                    reuseNode false //job will continue to run on slave1
                }
            }
            steps {
                sh 'printenv'
            }
        }        
    } 
}

// Pipeline > Agent > Dockerfile
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


//Pipeline > Agent > Dockerfile > Dir
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

//Pipeline > Agent > Dockerfile > Filename
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


//ipeline > Agent > Dockerfile > AdditionalBuildArgs
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

//Pipeline > Agent > Dockerfile > CustomWorkspace
pipeline {
    agent {
        docker {
            image 'maven:3.5.3-jdk-10-slim'
			args '-e someEnv=dev'
			alwaysPull true
			customWorkspace '/var/lib/jenkins/workspace/myCustomWorkspace'
        }
    }
    stages {
        stage('Build') {
            steps {
                sh 'echo $someEnv'
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
                url: 'https://github.com/pipelineascodecourse/pipeline-agent-dockerfile.git']],
				extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'checkout-directory']]
				])
            }
        }
        stage('dockerfile'){            
            agent {
                dockerfile {
                    customWorkspace '/var/lib/jenkins/workspace/pipeline-agent-dockerfile-customWorkspace/checkout-directory'
                } 
            }            
            steps{
                sh 'cat /etc/lsb-release'
            }
        }
    }
}
``

// Groovy Script Outside of Declarative Pipeline Script
def nameOfPerson = "john"

def printName(name){
	echo name
}

pipeline{
    agent any
    stages{
        stage("Build"){
            steps{
				script{
					printName(nameOfPerson)
				}
            }
        }
    }
}


//registryCredentialsId 
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
