## Email Notification  using Jenkins pipeline

[How To Configure Email Notification In Jenkins In 6 Simple Steps?](https://www.edureka.co/blog/email-notification-in-jenkins/)

[Jenkins sending email on post build](https://medium.com/@gustavo.guss/jenkins-sending-email-on-post-build-938b236545d2)

```groovy
pipeline {
    agent any
     
    stages {
        stage('Ok') {
            steps {
                echo "Ok"
            }
        }
    }
    post {
        always {
            echo 'I will always say Hello again!'
            
            emailext body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n, More info at: ${env.BUILD_URL}",
            recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']],
            subject: "Jenkins Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}"
        }
    }
}
```


```
Jenkins Build SUCCESS: Job test
SUCCESS: Job test build 40 , More info at: http://10.0.0.10:8080/job/test/40/
```

![](/images/jenkins24.JPG)





