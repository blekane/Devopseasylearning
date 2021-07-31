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

