### Installing Jenkins
- Install Java first
[Jenkins webside](https://www.jenkins.io/doc/book/installing/)

### Script to install Jenkins on centos 6 and 7
```sh
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

### Jenkins on AWS EC2
[How to install jenkins in AWS EC2](https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS/)
```sh
sudo yum update –y
sudo yum install wget -y
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade -y
sudo amazon-linux-extras install epel -y
sudo amazon-linux-extras install java-openjdk11 -y 
sudo yum install jenkins -y
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo systemctl status jenkins
sudo systemctl enable jenkins
```

### Get the initial administrative password 
```
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```


### Jenkins install in Ubuntu with Maven
```sh
#!/bin/bash
#Maintainer name 
#This script can only run of debain base OS
echo 'This script will take about 5 min to run and perform the following tasks:'
echo  $'\e[1;33m'Jenkins$'\e[0m'
echo  $'\e[1;33m'start jenkins daemon$'\e[0m'
echo  $'\e[1;33m'Java $'\e[0m'
echo  $'\e[1;33m'Maven$'\e[0m'
echo  $'\e[1;33m'Set JAVA home$'\e[0m'
echo  $'\e[1;33m'set Maven home$'\e[0m'
echo  $'\e[1;33m'display Java and Maven home at the end of the script$'\e[0m'
echo
sleep 3
ID=$(id -u)
if 
[[ $ID -eq 0 ]]
then
echo
echo you are Root and therefore let us gather some facts 
else
echo you are not Root please loging as a root user
exit 1
fi
echo
echo ‘PLEASE be patient with this script it will take about 5mn to unpack all required packages’
echo
echo
echo  $'\e[1;33m' When prompted please Press ENTER in your keyboard to unpack Java$'\e[0m'
echo
echo
sleep 2

sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-get update -y
sudo apt install unzip -y
sudo apt-get install -y openjdk-8-jdk

#Install Jenkins

#wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
echo deb https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list
sudo apt-get update -y
sudo apt-get install -y jenkins
sudo systemctl start jenkins

#Install Maven  ( on Jenkins machine )

## cd /tmp ; wget http://mirrors.estointernet.in/apache/maven/maven-3/3.6.1/binaries/apache-maven-3.6.1-bin.tar.gz
## cd /tmp ; wget http://apachemirror.wuchna.com/maven/maven-3/3.6.2/binaries/apache-maven-3.6.2-bin.tar.gz
cd /tmp ; wget http://apachemirror.wuchna.com/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
cd /tmp ; tar -xzf apache-maven-3.6.3-bin.tar.gz -C /opt

#Install SonarQube-runner ( on Jenkins machine )

#cd /tmp ; wget 

echo
echo
echo  $'\e[1;33m' If any question about SONAR-RUNNER-2 appear it means you have it installed  already just enter yes couple of  time on your keyboard until the script stop asking that question  $'\e[0m'
echo 
sleep 3
http://repo2.maven.org/maven2/org/codehaus/sonar/runner/sonar-runner-dist/2.4/sonar-runner-dist-2.4.zip
cd /tmp ; wget https://repo1.maven.org/maven2/org/codehaus/sonar/runner/sonar-runner-dist/2.4/sonar-runner-dist-2.4.zip
cd /tmp ; unzip sonar-runner-dist-2.4.zip
cd /tmp ; mv sonar-runner-2.4 /opt

#Set JAVA_HOME & MAVEN_HOME as environment variables on Jenkins machine
mkdir -p /home/backup
cp -p /etc/profile /home/backup/profile_`date +%d%b%Y-%H%M`
echo "MAVEN_HOME=/opt/apache-maven-3.6.3" >> /etc/profile
#echo "JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> /etc/profile
echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /etc/profile
echo "PATH=\$JAVA_HOME/bin:\$MAVEN_HOME/bin:\$PATH" >> /etc/profile
source /etc/profile  ## to reload the configuration

echo
echo


echo 'here is your maven and java environment location'
echo                  $'\e[1;33m'$MAVEN_HOME $'\e[0m'

echo
sleep 2
echo                  $'\e[1;33m'$JAVA_HOME $'\e[0m'

echo
echo Now that this was successful go to jenkins set maven and java home using information above

echo
echo
echo Written by Email: $'\e[1;33m'test@gmail.com Tel: 832-342-4000$'\e[0m'
echo

echo Thank you for using this script email me for any question comment or concern


exit
```

### Install jenkins on AWS EC2, CentOs and Ubuntu with the case statement

```sh
#!/bin/bash
# Author: Tia M
# Date: August 16, 2021
#This script can only run of Debain and Fedora base OS
echo
echo 'This script will take about 5 min to run and perform the following tasks:'
echo  $'\e[1;33m'Install Jenkins$'\e[0m'
echo  $'\e[1;33m'Start jenkins daemon$'\e[0m'
echo  $'\e[1;33m'Open port 8080 on the firwall$'\e[0m'
echo  $'\e[1;33m'Display Jenkins URL at the end$'\e[0m'
echo
sleep 5

AWS_IP=`curl ifconfig.co`
OS=$(cat /etc/os-release |grep PRETTY_NAME | awk -F= '{print$2}' | awk -F '"' '{print$2}' |awk '{print$1}')
IP=$(ip route get 1.2.3.4 | awk '{print $7}')

echo 'checking if jenkins is installed'
ls /var/lib |grep jenkins
if 
[[ ${?} -eq 0 ]]
then 
    echo "Jenkins is install"
    exit 1
    else

case $OS in
Ubuntu)
echo "This is Ubuntu server"
sleep 5
#sudo apt update
sudo apt install wget -y
sudo apt search openjdk
sudo apt install openjdk-11-jdk -y
java -version
ufw enable 2& > /dev/null 
ufw allow 8080/tcp   2& > /dev/null 
ufw reload
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update -y
sudo apt-get install jenkins -y
systemctl start jenkins 
systemctl enable jenkins

echo "Use the bellow URL to check your website on the browser:"
sleep 2
echo "http://$IP:8080/"
exit 1
;;

CentOS) 
echo "This is CentOs server"
sleep 5 

sudo yum install wget -y
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
#sudo yum upgrade -y
sudo yum install java-11-openjdk-devel -y
sudo yum install jenkins -y 
sudo systemctl daemon-reload
systemctl start jenkins 
systemctl enable jenkins
firewall-cmd --permanent --add-port=8080/tcp   2& > /dev/null 
firewall-cmd --reload 2& > /dev/null

echo "Use the bellow URL to check your website on the browser:"
sleep 2
echo "http://$IP:8080/"
exit 1
;;


Amazon)
echo "This is Amazon server"
sleep 5
sudo yum update –y
sudo yum install wget -y
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade -y
sudo amazon-linux-extras install epel -y
sudo amazon-linux-extras install java-openjdk11 -y 
sudo yum install jenkins -y
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo systemctl status jenkins
sudo systemctl enable jenkins

echo "Use the bellow URL to check your website on the browser:"
sleep 2
echo "http://$AWS_IP:8080/"
exit 1
;;

*)
   echo "your operating system is UNKNOWN"
   exit 1
   ;;
esac 

fi
```


sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-get update -y
sudo apt install unzip -y
sudo apt-get install -y openjdk-8-jdk



sudo yum update –y
sudo yum install wget -y
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade -y
sudo amazon-linux-extras install epel -y
sudo amazon-linux-extras install java-openjdk11 -y 
sudo yum install jenkins -y
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo systemctl status jenkins
sudo systemctl enable jenkins



sudo apt install wget -y
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update -y
sudo apt install openjdk-11-jdk -y
sudo apt-get install jenkins -y
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo systemctl status jenkins
sudo systemctl enable jenkins

