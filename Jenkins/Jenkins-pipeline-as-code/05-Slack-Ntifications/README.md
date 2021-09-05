## Pipeline notifications
[Jenkins Pipeline job Integration with slack](https://www.youtube.com/watch?v=S91WklRDKsY)
[Send notification to slack from the Jenkins CI Job and Jenkinsfile](https://eavnitech.com/blog/send-notification-to-slack-from-the-Jenkins-CI-job-and-jenkinsfile/)


### Slack Notification
1. create a channel in Slack: pipeline test
2. Create a webhook: go to Devops easy learning or your workspace - adminstration - manage app - search for `Incoming WebHooks` - add to slack - Select the channel and add incoming webhooks integration.

![](/images/jenkins21.JPG)

![](/images/jenkins22.JPG)

3. Generate the pipeline syntex: 
Webhook URL: https://hooks.slack.com/services/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
- We need to create a secret file in Jenkins will this token first `T024PM38HT8/B02DBFZUH5K/lU7Pv4AHHH0e9eXojOjc9IiB`
- This is the slackSend baseUrl: `https://hooks.slack.com/services/`
![](/images/jenkins23.JPG)

**RESULT:**
```
slackSend baseUrl: 'https://hooks.slack.com/services/', channel: 'pipeline-test', color: 'good', message: 'Hello, world', teamDomain: 'Devops easy learning', tokenCredentialId: 'Slack-Token-For-Incoming-Webhooks'


slackSend baseUrl: 'https://hooks.slack.com/services/', 
channel: 'pipeline-test', 
color: 'good', message: 
'Hello, world', 
teamDomain: 'Devops easy learning', 
tokenCredentialId: 'Slack-Token-For-Incoming-Webhooks'
```

### EXAMPLE 1: With simple steps

```groovy
pipeline {
    agent any

    stages {
        stage('Slack it'){
            steps {
                slackSend baseUrl: 'https://hooks.slack.com/services/',
                channel: 'pipeline-test', 
                color: 'good', 
                message: 'Hello, world', 
                teamDomain: 'Devops easy learning', 
                tokenCredentialId: 'Slack-Token-For-Incoming-Webhooks'
            }
        }
    }
}
```

### EXAMPLE 2: With Build job informations
```groovy
pipeline {
    agent any

    stages {
        stage('Slack it'){
            steps {
                slackSend baseUrl: 'https://hooks.slack.com/services/',
                channel: 'pipeline-test', 
                color: 'good', 
                message: "Build deployed successfully - ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)", 
                teamDomain: 'Devops easy learning', 
                tokenCredentialId: 'Slack-Token-For-Incoming-Webhooks'
            }
        }
    }
}
```

OR

```groovy
pipeline {
    agent any

    stages {
        stage('Slack it'){
            steps {
                slackSend baseUrl: 'https://hooks.slack.com/services/',
                channel: 'pipeline-test', 
                color: 'good', 
                message: "Job: ${env.JOB_NAME} with buildnumber ${env.BUILD_NUMBER} was successful", 
                teamDomain: 'Devops easy learning', 
                tokenCredentialId: 'Slack-Token-For-Incoming-Webhooks'
            }
        }
    }
}
```


### EXAMPLE 3: Pipeline with post action
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
```

### EXAMPLE 3: Pipeline with post action with Slack on success
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
    post {
        success {
            slackSend baseUrl: 'https://hooks.slack.com/services/',
            channel: 'pipeline-test', 
            color: 'good', 
            message: "Build deployed successfully - ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)", 
            teamDomain: 'Devops easy learning', 
            tokenCredentialId: 'Slack-Token-For-Incoming-Webhooks'
        }
    }
}
```

### EXAMPLE 3: Pipeline with post action with Slack on failure
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
    post {
        failure {
            slackSend baseUrl: 'https://hooks.slack.com/services/',
            channel: 'pipeline-test', 
            color: 'danger', 
            message: "Build failed - ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)", 
            teamDomain: 'Devops easy learning', 
            tokenCredentialId: 'Slack-Token-For-Incoming-Webhooks'
        }
    }
}
```


### EXAMPLE 3: Pipeline with post action with Slack on failure, success and warning
The color can be `good, warning, danger`, or any hex color code `(eg. #439FE0)`. 
- good or success: color = '#BDFFC3'
- warning or unstable: color = '#FFFE89'
- danger or failed: color = '#FF9FA1'

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
    post {
        success {
            slackSend baseUrl: 'https://hooks.slack.com/services/',
            channel: 'pipeline-test', 
            color: 'good', 
            message: "Build SUCCESS - ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)", 
            teamDomain: 'Devops easy learning', 
            tokenCredentialId: 'Slack-Token-For-Incoming-Webhooks'
        }
        failure {
            slackSend baseUrl: 'https://hooks.slack.com/services/',
            channel: 'pipeline-test', 
            color: 'danger', 
            message: "Build FAILED - ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)", 
            teamDomain: 'Devops easy learning', 
            tokenCredentialId: 'Slack-Token-For-Incoming-Webhooks'
        }
        unstable {
            slackSend baseUrl: 'https://hooks.slack.com/services/',
            channel: 'pipeline-test', 
            color: 'warning', 
            message: "Build UNSTABLE - ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)", 
            teamDomain: 'Devops easy learning', 
            tokenCredentialId: 'Slack-Token-For-Incoming-Webhooks'
        }
        
    }
}


OR

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
    post {
        success {
            slackSend baseUrl: 'https://hooks.slack.com/services/',
            channel: 'pipeline-test', 
            color: '#BDFFC3', 
            message: "Build SUCCESS - ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)", 
            teamDomain: 'Devops easy learning', 
            tokenCredentialId: 'Slack-Token-For-Incoming-Webhooks'
        }
        failure {
            slackSend baseUrl: 'https://hooks.slack.com/services/',
            channel: 'pipeline-test', 
            color: '#FF9FA1', 
            message: "Build FAILED - ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)", 
            teamDomain: 'Devops easy learning', 
            tokenCredentialId: 'Slack-Token-For-Incoming-Webhooks'
        }
        unstable {
            slackSend baseUrl: 'https://hooks.slack.com/services/',
            channel: 'pipeline-test', 
            color: '#FFFE89', 
            message: "Build UNSTABLE - ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)", 
            teamDomain: 'Devops easy learning', 
            tokenCredentialId: 'Slack-Token-For-Incoming-Webhooks'
        }
        
    }
}
```


### EXAMPLE 3: Pipeline with post action with Slack on failure, success and warning pure optons

The color can be `good, warning, danger`, or any hex color code `(eg. #439FE0)`. 
- good or success: color = '#BDFFC3'
- warning or unstable: color = '#FFFE89'
- danger or failed: color = '#FF9FA1'

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
    post {
        success {
            slackSend baseUrl: 'https://hooks.slack.com/services/',
            channel: 'pipeline-test', 
            color: 'good', 
            message: 'Project Name : ' + JOB_NAME + ' \n Build Status : Build number ' + currentBuild.displayName + ' finished with status: SUCCESS ===> GOOD JOB GUYS! \n Description : ' + currentBuild.description + '\n Build URL : ' + BUILD_URL, 
            teamDomain: 'Devops easy learning', 
            tokenCredentialId: 'Slack-Token-For-Incoming-Webhooks'
        }
        failure {
            slackSend baseUrl: 'https://hooks.slack.com/services/',
            channel: 'pipeline-test', 
            color: 'danger', 
            message: 'Project Name : ' + JOB_NAME + ' \n Build Status : Build number ' + currentBuild.displayName + ' finished with status: FAILED ===> Please check the console output to fix this job IMMEDIATELY ===> THANKS. \n Description : ' + currentBuild.description + '\n Build URL : ' + BUILD_URL, 
            teamDomain: 'Devops easy learning', 
            tokenCredentialId: 'Slack-Token-For-Incoming-Webhooks'
        }
        unstable {
            slackSend baseUrl: 'https://hooks.slack.com/services/',
            channel: 'pipeline-test', 
            color: 'warning', 
            message: 'Project Name : ' + JOB_NAME + ' \n Build Status : Build number ' + currentBuild.displayName + ' finished with status: UNSTABLE ===> Please check the console output to fix this job IMMEDIATELY ===> THANKS. \n Description : ' + currentBuild.description + '\n Build URL : ' + BUILD_URL, 
            teamDomain: 'Devops easy learning', 
            tokenCredentialId: 'Slack-Token-For-Incoming-Webhooks'
        }
        
    }
}

OR

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
````