## jenkins configurations as code links
* [Configuration as Code](https://plugins.jenkins.io/configuration-as-code/)

* [Jenkins Pipeline Documentation](https://anoni.sh/jenkins-pipeline)

* [Jenkins Pipeline Syntax](https://anoni.sh/pipeline-syntax)

* [Jenkins Pipeline steps](https://anoni.sh/pipeline-steps)

https://github.com/devbyaccident/demo-shared-pipeline

https://github.com/devbyaccident/azure-voting-app-redis/blob/master/Jenkinsfile


Jenkins and Docker Build a Docker image using an jenkins pipeline and push it into docker registry
https://www.edureka.co/community/55640/jenkins-docker-docker-image-jenkins-pipeline-docker-registry



## General Terms
**- Agent:** An agent is typically a machine, or container, which connects to a Jenkins master and executes tasks when directed by the master.

**Artifact:** An immutable file generated during a Build or Pipeline run which is archived onto the Jenkins Master for later retrieval by users.

**Build:** Result of a single execution of a Project

**Folder** An organizational container for Pipelines and/or Projects, similar to folders on a file system.

**Job:** A deprecated term, synonymous with Project.

**Master:** The central, coordinating process which stores configuration, loads plugins, and renders the various user interfaces for Jenkins.

**Node:** A machine which is part of the Jenkins environment and capable of executing Pipelines or Projects. Both the Master and Agents are considered to be Nodes.

**Project:** A user-configured description of work which Jenkins should perform, such as building a piece of software, etc.

**Pipeline:** A user-defined model of a continuous delivery pipeline

**Plugin:** An extension to Jenkins functionality provided separately from Jenkins

**Trigger:** A criteria for triggering a new Pipeline run or Build.

**Step:** A single task; fundamentally steps tell Jenkins what to do inside of a Pipeline or Project

**Workspace:** A disposable directory on the file system of a Node where work can be done by a Pipeline or Project. Workspaces are typically left in place after a Build or Pipeline run completes unless specific Workspace cleanup policies have been put in place on the Jenkins Master.

**Upstream:** A configured Pipeline or Project which triggers a separate Pipeline or Project as part of its
execution.

**Downstream:** A configured Pipeline or Project which is triggered as part of the execution of a separate Pipeline
or Project.



## Some plugins in Jenkins
- **Config AutoRefresh:** the Config AutoRefresh Plugin provides a way to configure the auto-refresh rate from the Jenkins UI.
- configuration-as-code
- docker-build-publish
- matrix-auth
- publish-over-ssh
- aws-credentials
- maven-plugin
- role-strategy
- github
- pipeline
- pipeline-utility-steps
- Credentials
- Credentials Binding Plugin

## Get the list of all the plugins
* [jenkins-url][/script]
* Example: http://10.0.0.3:8080/script
* Hit enter, paste the code below and run

```groovy
def pluginList = new ArrayList(Jenkins.instance.pluginManager.plugins)
pluginList.sort { it.getShortName() }.each{
  plugin -> 
    println ("${plugin.getShortName()}: ${plugin.getVersion()}")
}






## When condition
**when:**
The when directive allows the Pipeline to determine whether the stage should be executed depending on the given condition.

**Built-in Conditions:**
**- branch:** Execute the stage when the branch being built matches the branch pattern given, for example: `when { branch 'master' }`
**- environment:** Execute the stage when the specified environment variable is set to the given value, for example: `when { environment name: 'DEPLOY_TO', value: 'production' }`
**expression:** Execute the stage when the specified Groovy expression evaluates to true.

```groovy
pipeline {
    agent any
    stages {
        stage('Example Build') {
            steps {
               echo 'Hello World' 
            }
        }
        stage('Example Deploy') {
            when {
               branch 'production' 
            }
            steps {
                echo 'Deploying'
            }
        }
    }
    post {
        always {
            echo 'I will always say Hello again!'
        }
    }
}
```

* This will skip the deployment if the build failed. The deploy stage will run because the build stage will not failed
```groovy
pipeline {
	agent any
	stages {
		stage('Checkout') {
			steps {
				echo "Cloning the code from VCS"
			}
		}
		stage('Build') {
			steps {
				echo "Building the application"
				sh 'cat /etc/*release'
			}
		}
		stage('Deploy') {
			when {
				expression {
					currentBuild.result == null || currentBuild.result == 'SUCCESS'
				}
			}
			steps {
				echo "Deploying the application"
			}
		}
	}
}
```

* This will skip the deployment if the build failed. The deploy stage will be skiped because the build stage will failed
```groovy
pipeline {
	agent any
	stages {
		stage('Checkout') {
			steps {
				echo "Cloning the code from VCS"
			}
		}
		stage('Build') {
			steps {
				echo "Building the application"
				sh 'cat /etc/*release......'
			}
		}
		stage('Deploy') {
			when {
				expression {
					currentBuild.result == null || currentBuild.result == 'SUCCESS'
				}
			}
			steps {
				echo "Deploying the application"
			}
		}
	}
}
```

* In this example, the pipeline will only execute if the previous stage was successful. If one stage `failed`, the pipeline will exit and skip all the rest of the stages.
```groovy
pipeline {
	agent any
	stages {
		stage('Checkout') {
			steps {
				echo "Cloning the code from VCS"
			}
		}
		stage('Compile') {
			when {
				expression {
					currentBuild.result == null || currentBuild.result == 'SUCCESS'
				}
			}
			steps {
				echo "Compiling the application"
				sh 'cat /etc/*release'
			}
		}
		stage('Buiid') {
			when {
				expression {
					currentBuild.result == null || currentBuild.result == 'SUCCESS'
				}
			}
			steps {
				echo "Building the application"
				sh 'cat /etc/*release'
			}
		}
		stage('Test') {
			when {
				expression {
					currentBuild.result == null || currentBuild.result == 'SUCCESS'
				}
			}
			steps {
				echo "Testing the application"
				sh 'cat /etc/*release'
			}
		}
		stage('Package') {
			when {
				expression {
					currentBuild.result == null || currentBuild.result == 'SUCCESS'
				}
			}
			steps {
				echo "Packaging the application"
				sh 'cat /etc/*release'
			}
		}
        stage('deploy') {
			when {
				expression {
					currentBuild.result == null || currentBuild.result == 'SUCCESS'
				}
			}
			steps {
				echo "Deploying the application"
				sh 'cat /etc/*release'
			}
		}
	}
}
```


## User define variables
* It most be in double quote like echo "Building version **${NEW_VERSION}**" and not echo 'Building version $**{NEW_VERSION}**'
```groovy
pipeline {
    agent any
    environment {
      NEW_VERSION = '1.3.0'
    }
    stages {
        
        stage('Build') {
            steps {
               echo "Building the application........" 
               echo "Building version: ${NEW_VERSION}" 
            }
        }
    }
}
```


## Build in variables or environment variables
* [jenkins-url][/env-vars.html/]
* Example: http://10.0.0.3:8080/env-vars.html/

```groovy
BRANCH_NAME
GIT_BRANCH
GIT_URL
BRANCH_NAME

pipeline {
    agent any
    stages {
        stage('Displying some Env') {
            steps {
                echo "The build number is: ${BUILD_NUMBER}"
                echo "The job name is: ${JOB_NAME}"
                echo "The Jenkins home directory is: ${JENKINS_HOME}"
                echo "The Jenkins URL is: ${JENKINS_URL}"
                echo "The build URL is: ${BUILD_URL}"
                echo "The job URL is: ${JOB_URL}"
                echo "The workspace is: ${WORKSPACE}"
            }
        }
    }
}
```


## Using multiple agents

**any:** 
Execute the Pipeline, or stage, on any available agent. For example: agent any

**none:**
When applied at the top-level of the pipeline block no global agent will be allocated for the
entire Pipeline run and each stage directive will need to contain its own agent directive. For example: agent none

**label:**
Execute the Pipeline, or stage, on an agent available in the Jenkins environment with the
provided label. For example: agent { label 'my-defined-label' }

* In this example, job will run on any available agent including **Jenkins master server.**

```groovy
pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
              echo "Cloning the source code........" 
            }
        }
        stage('compile') {
            steps {
               echo "Compiling the application........" 
            }
        }
        stage('build') {
            steps {
               echo "Building the application........"
            }
        }
        stage('test') {
            steps {
              echo "Testing the application........" 
            }
        }
        stage('package') {
            steps {
               echo "Packaging the application........"
            }
        }
        stage('deploy') {
            steps {
               echo "Deploying the application........"
            }
        }
    }
}
```

* An agent is specify here for each stage because we of `agent none`
```groovy
pipeline {
    agent none
    stages {
        stage('Checkout') {
			agent any
            steps {
              echo "Cloning the source code........" 
            }
        }
        stage('compile') {
			agent {
				Label "Linux"
			}
            steps {
               echo "Compiling the application........" 
            }
        }
        stage('build') {
			agent {
				Label "Windows"
			}
            steps {
               echo "Building the application........"
            }
        }
        stage('test') {
			agent any // run on any node
            steps {
              echo "Testing the application........" 
            }
        }
        stage('package') {
			agent {
				Label "Linux"
			}
            steps {
               echo "Packaging the application........"
            }
        }
        stage('deploy') {
			agent {
				Label "AWS-LINUX"
			}
            steps {
               echo "Deploying the application........"
            }
        }
    }
}
```


* In This example, I label the Jenkins master server as `Master` which means **label = Master** and run all the stages on the master server to test.

```groovy
pipeline {
	agent none
	stages {
		stage('Checkout') {
			agent {
				label "Master"
			}
			steps {
				echo "Cloning the code from VCS"
			}
		}
		stage('Compile') {
			agent {
				label "Master"
			}
			when {
				expression {
					currentBuild.result == null || currentBuild.result == 'SUCCESS'
				}
			}
			steps {
				echo "Compiling the application"
				sh 'cat /etc/*release'
			}
		}
		stage('Buiid') {
			agent {
				label "Master"
			}
			when {
				expression {
					currentBuild.result == null || currentBuild.result == 'SUCCESS'
				}
			}
			steps {
				echo "Building the application"
				sh 'cat /etc/*release'
			}
		}
		stage('Test') {
			agent {
				label "Master"
			}
			when {
				expression {
					currentBuild.result == null || currentBuild.result == 'SUCCESS'
				}
			}
			steps {
				echo "Testing the application"
				sh 'cat /etc/*release'
			}
		}
		stage('deploy') {
			agent {
				label "Master"
			}
			when {
				expression {
					currentBuild.result == null || currentBuild.result == 'SUCCESS'
				}
			}
			steps {
				echo "Deploying the application"
				sh 'cat /etc/*release'
			}
		}
	}
	post {
		failure {
			mail bcc: '', body: '''Hi 
			Please Check Jenkins the job failed.''', cc: '', from: '', replyTo: '', subject: 'Jenkins Job Notification', to: 'tiajearad44@gmail.com'
		}
	}
}
```


## Get credentials values
* Install `Credential Binding plungin` first. It as takes the ID as the paramter of the credential in Jenkins.
* add _USR and _PSW on the variable that you set such as `ANSIBLE_HOST_USR` and `ANSIBLE_HOST_PSW`

```groovy
pipeline {
    agent any
    environment {
      ANSIBLE_HOST = credentials('ansadmin-host')
    }
    stages {
        stage('deploy') {
          steps {
            echo "Ansible host username is: ${ANSIBLE_HOST_USR}"
            echo "Ansible host password is: ${ANSIBLE_HOST_PSW}"
          }
        }
    }
}

// Better away of doing it in single quote
pipeline {
    agent any
    environment {
      ANSIBLE_HOST = credentials('ansadmin-host')
    }
    stages {
        stage('deploy') {
          steps {
            sh ('echo Ansible host username is: ${ANSIBLE_HOST_USR}')
            sh ('echo Ansible host password is: ${ANSIBLE_HOST_PSW}')
          }
        }
    }
}
```


## Check out the code
```groovy
pipeline {
    agent any
    stages {
        stage('Chechout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/dev']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/leonardtia1/jenkins.git']]])
            }
        }
    }
}
```


## Condictions
```groovy
BRANCH_NAME == "dev" || BRANCH_NAME == "prod"
BRANCH_NAME == "dev" || BRANCH_NAME == "prod" || BRANCH_NAME == "qa"
BRANCH_NAME == "dev" && BRANCH_NAME == "prod"
BRANCH_NAME == "dev" && BRANCH_NAME == "prod" && BRANCH_NAME == "qa"

BRANCH_NAME != "master" && BRANCH_NAME != "prod"

BRANCH_NAME == "dev" && CODE_CHANGES == true


env.BRANCH_NAME == "dev" || env.BRANCH_NAME == "prod"
env.BRANCH_NAME == "dev" || env.BRANCH_NAME == "prod" || env.BRANCH_NAME == "qa"
env.BRANCH_NAME == "dev" && env.BRANCH_NAME == "prod"
env.BRANCH_NAME == "dev" && env.BRANCH_NAME == "prod" && env.BRANCH_NAME == "qa"

env.BRANCH_NAME != "master" && env.BRANCH_NAME != "prod"

env.BRANCH_NAME == "dev" && env.CODE_CHANGES == true
```

* In this example, the code will be checkout only if the branch name is dev. If the branch name is not dev, the checkout stage will be skipped and the build will failed

```groovy
pipeline {
    agent any
    stages {
        stage('Checkout') {
            when {
                expression {
                    BRANCH_NAME == "dev"
                }
            }
            steps {
              echo "Cloning the source code........" 
            }
        }
    }
}
```


## Tools in Jenkinsfile
- It provide you with build tools for your project
- There are only 3 tools that Jenkinsfile file support 
	- Gradle
	- Maven
	- Jdk
- These tools most be pre-configure or pre-install in `Global tools configuration in Jenkins`

```groovy
pipeline {
    agent any
	tools {
		maven 'my_maven'
        jdk 'my_java'
	}
    stages {
		stage('Compile') {
			steps{
				sh 'mvn compile'
			}
		}
		stage('Unit_Test') {
			steps{
				sh 'mvn test'
			}
		}
		stage('Package') {
			steps{
				sh 'mvn package'
			}
		}
    }
}
```

### Parameter in JenkinsFile
**Types of parameter:** 
- String (name, defaultValue, description)
    - parameters { string(name: 'DEPLOY_ENV',
defaultValue: 'staging', description: '') }
- BooleanParam (name, defaultValue, description)
    - parameters { booleanParam(name: 'DEBUG_BUILD',
defaultValue: true, description: '') }
- Choice (name, defaultValue, description)

```groovy
pipeline {
    agent any
    parameters {
        string(name: 'Greeting', defaultValue: 'Hello', description: 'How should I greet the world?')
    }
    stages {
        stage('Example') {
            steps {
                echo "${params.Greeting} World!"
            }
        
        }
    }
}
```

```groovy
pipeline {
    agent any
    parameters {
        string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
    }
    stages {
        stage('Example') {
            steps {
                echo "Hello ${params.PERSON}"
            }
        
        }
    }
}
```

**params.executeTest:**
- Execute test only if params.executeTest is set to `true` and skip if params.executeTest is `false`
- The test will be skip because the boolean params.executeTest is set to `false`. If we set it to `true`, it will execute. `booleanParam(name: 'executeTest', defaultValue: true, description: "")`

```groovy
pipeline {
    agent any
	parameters {
		//string(name: 'VERSION', defaultValue: "1.30", description: "Version to be deploy to prod")
		choice (name: 'VERSION', choices: ['1.1.0', '1.2.0', '1.3.0'], description: "Version to be deploy to prod")
		booleanParam(name: 'executeTest', defaultValue: false, description: "Execute test only if params.executeTest is set to true and skip if params.executeTest is false")
	}
    stages {
        stage('Checkout') {
            steps {
              echo "Cloning the source code........" 
            }
        }
        stage('compile') {
            steps {
               echo "Compiling the application........" 
            }
        }
        stage('build') {
            steps {
               echo "Building the application........"
            }
        }
        stage('test') {
			when {
				expression {
					params.executeTest
				}
			}
            steps {
              echo "Testing the application........" 
            }
        }
        stage('package') {
            steps {
               echo "Packaging the application........"
            }
        }
        stage('deploy') {
            steps {
               echo "Deploying the application........"
			   echo "Deploying version ${VERSION}"
            }
        }
    }
}
```

### Using external scripts in JenkinsFile
* We can extract stages and put it in a groovy script and import it into a jenkinsfile by defining a global such as `gv` to load the script
* We need to add this github repo before testing it
* After test, we can click on the job number - replay - and see both the jenkinsfile and the script.
* NB: The replay function in Jenkins help us to modify code and test it from Jenkins without actually committing the into VCS. It also helps us to see the jenkinsfile that we committed in VCS.

```groovy
//script.groovy

def buildApp() {
    echo 'building the application...'
} 

def testApp() {
    echo 'testing the application...'
} 

def deployApp() {
    echo 'deplying the application...'
    echo "deploying version ${params.VERSION}"
} 

return this
```

```groovy

def gv

pipeline {
    agent any
    parameters {
        choice(name: 'VERSION', choices: ['1.1.0', '1.2.0', '1.3.0'], description: '')
        booleanParam(name: 'executeTests', defaultValue: true, description: '')
    }
    stages {
        stage("init") {
            steps {
                script {
                   gv = load "script.groovy" 
                }
            }
        }
        stage("build") {
            steps {
                script {
                    gv.buildApp()
                }
            }
        }
        stage("test") {
            when {
                expression {
                    params.executeTests
                }
            }
            steps {
                script {
                    gv.testApp()
                }
            }
        }
        stage("deploy") {
            steps {
                script {
                    gv.deployApp()
                }
            }
        }
    }   
}
```



## Triggers in Jenkinsfile
- The triggers directive defines the automated ways in which the Pipeline should be re-triggered
- Currently the only two
available triggers are cron and pollSCM.

**cron:**
Accepts a cron-style string to define a regular interval at which the Pipeline should be retriggered, for example: triggers `{ cron('H 4/* 0 0 1-5') }`

**pollSCM:**
Accepts a cron-style string to define a regular interval at which Jenkins should check for new
source changes. If new changes exist, the Pipeline will be re-triggered. For example: triggers {
`pollSCM('H 4/* 0 0 1-5') }`

**NOTE:** The pollSCM trigger is only available in Jenkins 2.22 or later

```groovy
pipeline {
    agent any
    triggers {
        cron('H 4/* 0 0 1-5')
    }
    stages {
        stages('Example') {
            steps {
               echo 'Hello World' 
            }
        }
    }
    post {
        always {
            echo 'I will always say Hello again!'
        }
    }
}
```


