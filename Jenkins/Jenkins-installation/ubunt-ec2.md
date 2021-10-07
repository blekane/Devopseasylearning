### Installing Java & Jenkins on AWS ec2 [here](https://devops4solutions.com/installing-java-jenkins-on-aws-ec2-ubuntu-16-04/)
```sh
apt install openjdk-11-jre-headless -y
wget -q -O – https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add –
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install jenkins -y
```

```sh
sudo apt-get update
sudo apt-get install openjdk-11-jdk -y
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get ugrade -y
sudo apt-get install jenkins -y 
````