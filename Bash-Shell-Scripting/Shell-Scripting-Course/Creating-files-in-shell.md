### Create a yaml file inside a shell script
```sh
#!/bin/bash
cat <<EOF>> /tmp/kind.yml 
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
- role: worker
EOF
```

### Create a dockerfile inside a shell script
```sh
#!/bin/bash
cat <<EOF /tmp/Dockerfile >/dev/null
FROM httpd
LABEL maintainer="Tia M"
RUN apt -y update && \
    apt -y install wget && \
    apt -y install unzip && \
    cd /usr/local/apache2/htdocs/ && \
    rm -rf * && \
    wget https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/covid19.zip && \
    unzip covid19.zip && \
    cp -R covid19/* . && \
    rm -rf covid19.zip && \
    rm -rf covid19 

USER root
ENTRYPOINT ["httpd-foreground"]
EXPOSE 80
EOF

cd /tmp/
docker build -t https:2.0 .
docker run --name https-web -p 8030:80 -d https:2.0
```

```sh
rm -rf docker-jenkins
mkdir docker-jenkins
cd docker-jenkins
cp /var/lib/jenkins/workspace/Package/target/addressbook.war .
touch dockerfile
cat <<EOT>> dockerfile
From tomcat
ADD addressbook.war /usr/local/tomcat/webapps
CMD "catalina.sh" "run"
EXPOSE 8080
EOT
sudo docker build -t myimage:$BUILD_NUMBER .
sudo docker run -itd -P myimage:$BUILD_NUMBER
```