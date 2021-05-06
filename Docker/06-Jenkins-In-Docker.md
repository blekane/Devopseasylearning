# JENKINS INSTALLATION

[Jenkins Continuous Integration and Delivery server.](https://hub.docker.com/r/jenkins/jenkins)

### Installating jenkins in docker
```
docker pull jenkins/jenkins:2.276
docker run -d -p 8070:8080 --name jenkins-nonprod jenkins/jenkins:2.276 
```
```
http://<IP>:8070
http://10.0.0.94:8070
```

### Unlock Jenkins
Exec into the port and, `cat /var/jenkins_home/secrets/initialAdminPassword` to get the password to unlock Jenkins
```
docker exec -it 217c7b40d0fd bash
cat /var/jenkins_home/secrets/initialAdminPassword
ctrl <p> <q>
e887a1976710453f922c1aaa50de7d47
```
![](/images/jenkins-key.JPG)

