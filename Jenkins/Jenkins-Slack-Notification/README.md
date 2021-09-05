## Slack Notification

[Send notification to slack from the Jenkins CI Job and Jenkinsfile](https://eavnitech.com/blog/send-notification-to-slack-from-the-Jenkins-CI-job-and-jenkinsfile/)

1. install a slack plugin first: Slack Notification
2. create a channel in Slack: developpers-team
3. install jenkins app in Slack: go to Devops easy learning or your workspace - adminstration - manage app - search for jinkins-ci and install it.
![](/images/jenkins6.JPG)

click on jenkins-ci - add to slack - selct the channel - and hit add jenkins ci integration 

![](/images/jenkins7.JPG)

4. Create a secret test credention in jenkins
[Instruction in jenkins](https://devops-easy-learning.slack.com/services/B02E203VB96?added=1)

Integration Token Credential ID: Create a secret text credential using 8faFMmCRRFkkslG2n7jEwzBZ as the value

![](/images/jenkins8.JPG)

5. Configure Slack
![](/images/jenkins9.JPG)

6. Test a job with post build action
![](/images/jenkins10.JPG)