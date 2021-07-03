### Script to install Jenkins
```
#!/bin/bash

# Author: Tia M
# Date: November  11, 2019
# Modified on:             by:

# Script to setup Jenkins on CentOS/RHEL 6.x and 7.x

OS_VERSION1=`cat /etc/*release |grep VERSION_ID |awk -F\" '{print $2}'`
OS_VERSION2=`cat /etc/*release|head -1|awk '{print $1}' |cut -d= -f2`
OS_TYPE=`cat /etc/*release|head -1|awk '{print $1}'`

echo -e "\n Checking if your server is connected to the network...."

sleep 4
ping google.com -c 4

if
  [[ ${?} -ne 0 ]]
 then
 echo -e "\nPlease verify that your server is connected!!\n"
 exit 2
 fi

echo -e "\nChecking if system is centOS 6 or 7\n"

if 
  [[ ${OS_VERSION1} -eq 7 ]] && [[ ${OS_TYPE} == CentOS ]]
 then
 echo -e "\nDetected that you are running CentOS 7 \n"
sleep 6

echo "installing Java8..."
sleep 3

# Jenkins is a Java application, so the first step is to install Java
yum -y install java-1.8.0-openjdk-devel

echo "checking the java version, please wait"
echo
sleep 2
java -version

echo "Enabling and adding the Jenkins repository..."
sleep 4
# enable the Jenkins repository
curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | tee /etc/yum.repos.d/jenkins.repo

# And add the repository to your system
rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key

echo "installing jenkins..."
Sleep 4
# Once the repository is enabled, install the latest stable version of Jenkins
yum -y install jenkins

# start the Jenkins service
systemctl start jenkins

# enable the Jenkins service to start on system boot
systemctl enable jenkins

# Use the following commands to open the necessary port
echo "Configuring the port 8080 on the firewall for Jenkins server"
sleep 3
firewall-cmd --permanent --zone=public --add-port=8080/tcp
firewall-cmd --reload

echo
echo " Use this link to access your Jenkins server. http://$(hostname -I |awk '{print $1}'):8080"
echo

fi
```

### Jenkins on AWS
[How to install jenkins in AWS EC2](https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS/)
```
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade
sudo yum install jenkins java-1.8.0-openjdk-devel -y
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo systemctl status jenkins
sudo systemctl enable jenkins
```

### Get the initial administrative password 
```
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```