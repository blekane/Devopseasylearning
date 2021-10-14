## Jenkins Integration with GitHub
[Multibranch Pipeline in Jenkins | Webhook for Multibranch pipeline | Multibranch Pipeline for Git](https://www.youtube.com/watch?v=fo36b23cpIU)

[Multibranch Scan Webhook Trigger](https://plugins.jenkins.io/multibranch-scan-webhook-trigger/)

```
JENKINS_URL/multibranch-webhook-trigger/invoke?token=[Trigger token]
http://10.0.0.10:8080/multibranch-webhook-trigger/invoke?token=my-token
```

**GitHub hook trigger for GITScm polling**

Integrate Jenkins with GitHub and trigger a build every time you make a commit to GitHub. This is essential for starting to use continuous integration within your project or team!

### 1- Install the github `integration plugin` first
![](/images/jenkins13.JPG)

### 2- install git on jenkins server
```
yum install git -y
OR
apt install git -y
```

**NB:** you will have the below error if git is not install
![](/images/jenkins14.JPG)

### 3- Configuration in jenkins
![](/images/jenkins17.JPG)

![](/images/jenkins16.JPG)

update the jenkins location in manage jenkins to manage sure that it is the same url in github
![](/images/jenkins50.JPG)

### 4- Configuration in github
We need to add github to notify jenkins after each commit. Got to github and follow the steps:
- In the repos, click on settings
- Webhoot
- Add webhub
- Copy you jenkins url:**http://10.0.0.94:8080**
- Append github-webhook: **http://10.0.0.94:8080/github-webhook/**
- Paste it in payload url
- In content type, choose application/json

![](/images/jenkins15.JPG)

- In Which events would you like to trigger this webhook?, choose send me everything.
- And check active
- Click add webhook
