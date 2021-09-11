# Build Docker Image Using Jenkins Pipeline & Push to ECR

### Step 1: First Let's install Jenkins
[installations steps documentation link](https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS)

```sh
sudo yum update –y
sudo yum install wget -y
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade
sudo amazon-linux-extras install epel -y
sudo amazon-linux-extras install java-openjdk11 -y 
sudo yum install jenkins -y
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo systemctl status jenkins
sudo systemctl enable jenkins
```






### AmazonEC2ContainerRegistryFullAccess
[AWS managed policies for Amazon Elastic Container Registry](https://docs.aws.amazon.com/AmazonECR/latest/userguide/security-iam-awsmanpol.html#security-iam-awsmanpol-AmazonEC2ContainerRegistryFullAccess)

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:*",
                "cloudtrail:LookupEvents"
            ],
            "Resource": "*"
        }
    ]
}
```