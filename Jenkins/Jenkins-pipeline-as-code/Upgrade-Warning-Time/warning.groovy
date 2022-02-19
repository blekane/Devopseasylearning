pipeline {
    agent any
    parameters {
   string(name: 'BRANCH',
           defaultValue: 'develop',
           description: '''branch''')
    string(name: 'WARNTIME',
           defaultValue: '15',
           description: '''Warning time (in minutes) before starting upgrade''')
  }
    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'
            }
        }
      stage('warning') {
      steps {
        script {
            notifyUpgrade(currentBuild.currentResult, "WARNING")
            sleep(time:env.WARNTIME, unit:"MINUTES")
        }
      }
    }
  }
  post {
    always {
      script {
        notifyUpgrade(currentBuild.currentResult, "POST")
      }
    }
    cleanup {
      deleteDir()
    }
  }
}   

def notifyUpgrade(String buildResult, String whereAt) {
  if (BRANCH == 'origin/develop') {
    channel = 'pipeline-test'
  } else {
    channel = 'pipeline-test'
  }
  if (buildResult == "SUCCESS") {
    switch(whereAt) {
      case 'WARNING':
        slackSend(channel: channel,
                color: "#439FE0",
                message: "Production: Upgrade starting in ${env.WARNTIME} minutes @ ${env.BUILD_URL}")
        break
    case 'STARTING':
      slackSend(channel: channel,
                color: "good",
                message: "Production: Starting upgrade @ ${env.BUILD_URL}")
      break
    default:
        slackSend(channel: channel,
                color: "good",
                message: "Production: Upgrade completed successfully @ ${env.BUILD_URL}")
        break
    }
  } else {
    slackSend(channel: channel,
              color: "danger",
              message: "Production: Upgrade was not successful. Please investigate it immediately.  @ ${env.BUILD_URL}")
  }
}




pipeline {
    agent any
    parameters {
   string(name: 'BRANCH',
           defaultValue: 'develop',
           description: '''branch''')
    string(name: 'WARNTIME',
           defaultValue: '15',
           description: '''Warning time (in minutes) before starting upgrade''')
  }
    stages {
        stage('Cloning') {
            steps {
               echo 'Hello World'
            }
        }
        stage('Building') {
            steps {
              echo 'Hello World'
            }
        }
        stage('warning') {
        steps {
            script {
                notifyUpgrade(currentBuild.currentResult, "WARNING")
                sleep(time:env.WARNTIME, unit:"MINUTES")
                }
            }
        }
        stage('Deploying') {
            steps {
              notifyUpgrade(currentBuild.currentResult, "STARTING")
              echo 'Hello World'
            }
        }
    }
    post {
    always {
      script {
        notifyUpgrade(currentBuild.currentResult, "POST")
      }
    }
    cleanup {
      deleteDir()
    }
  }
}   

def notifyUpgrade(String buildResult, String whereAt) {
  if (BRANCH == 'origin/develop') {
    channel = 'pipeline-test'
  } else {
    channel = 'pipeline-test'
  }
  if (buildResult == "SUCCESS") {
    switch(whereAt) {
      case 'WARNING':
        slackSend(channel: channel,
                color: "#439FE0",
                message: "Production: Upgrade starting in ${env.WARNTIME} minutes @ ${env.BUILD_URL}")
        break
    case 'STARTING':
      slackSend(channel: channel,
                color: "good",
                message: "Production: Starting upgrade @ ${env.BUILD_URL}")
      break
    default:
        slackSend(channel: channel,
                color: "good",
                message: "Production: Upgrade completed successfully @ ${env.BUILD_URL}")
        break
    }
  } else {
    slackSend(channel: channel,
              color: "danger",
              message: "Production: Upgrade was not successful. Please investigate it immediately.  @ ${env.BUILD_URL}")
    }
}


