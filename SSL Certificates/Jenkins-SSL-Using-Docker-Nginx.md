# Setup Jenkins(SSL) Using Docker & Nginx [here](https://mtit.blog/2020/07/30/setup-jenkinsssl-using-docker-nginx/)

Install Docker Compose [here](https://docs.docker.com/compose/install/)

## Docker Compose Installation on Ubuntu [here](https://docs.docker.com/compose/install/)
```
apt update -y
apt install docker.io -y       
apt install docker-compose -y
docker-compose --version
```
```sh
#create config files
mkdir ~/jenkins
mkdir ~/certs
mkdir -p ~/nginx/conf.d

# create the compose file
cd 
mkdir jenkins-env && cd jenkins-env
vim docker-compose.yml
#Copy this code to the docker-compose.yml

version: '3.3'
services:
  jenkins:
    image: "jenkins/jenkins:lts"
    user: root
    expose:
      - 8080
    ports:
      - 8080:8080
      - 50000:50000
    container_name: it-jenkins
    volumes:
      - ~/jenkins:/var/jenkins_home
      - /var/run/docker.sock:/var/run/docker.sock
      - /usr/local/bin/docker:/usr/local/bin/docker
    networks:
      - jenkins_nw
    restart: unless-stopped
  nginx:
    image: "nginx:latest"
    links:
      - "jenkins"
      - "jenkins:jenkinssvc"
    ports:
      - "80:80"
      - "443:443"
    container_name: it-nginx
    volumes:
      - ~/certs:/etc/ssl
      - ~/nginx/conf.d:/etc/nginx/conf.d # This will block nginx default web page
      - /var/run/docker.sock:/tmp/docker.sock:ro
    networks:
      - jenkins_nw
    depends_on:
      - jenkins
    restart: unless-stopped
 
networks:
  jenkins_nw:
    driver: bridge

# Start containers
docker-compose up -d
docker exec -it it-jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

## Configure your Jenkins to use SSL Certificate
```sh
# Copy your certificates (cert.key, cert.pem) to your ~/certs folder or generate a certificate
cd ~/certs
openssl req -x509 -newkey rsa:4096 -keyout key.key -out cert.pem -days 365

# check keys in nginx container
docker exec -it [nginx_container_name] ls /etc/ssl
docker exec -it 780c1a28efd2 ls /etc/ssl

# Add a file to decrypt the private key in nginx. Add the passphrase in that file
cd ~/certs
vim passphrase.pass
docker exec -it [nginx_container_name] cat /etc/ssl/passphrase.pass
docker exec -it 780c1a28efd2 cat /etc/ssl/passphrase.pass

# Go to your ~/nginx/conf.d folder and change the jenkins.conf file to support ssl by coping this code below.
cd ~/nginx/conf.d
vim jenkins.conf 

upstream jenkins {
  server 127.0.0.1:8080 fail_timeout=0;
}
server {
  listen 80;
  server_name jenkins05.anomicatech.com;
  return 301 https://$host$request_uri;
}
server {
  listen 443 ssl;
  server_name jenkins05.anomicatech.com;

  ssl_certificate     /etc/ssl/cert.pem;
  ssl_certificate_key /etc/ssl/key.key;
  ssl_password_file   /etc/ssl/passphrase.pass;

  location / {
    proxy_set_header        Host $host:$server_port;
    proxy_set_header        X-Real-IP $remote_addr;
    proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header        X-Forwarded-Proto $scheme;
    proxy_redirect http:// https://;
    proxy_pass              http://jenkins;
    # Required for new HTTP-based CLI
    proxy_http_version 1.1;
    proxy_request_buffering off;
    proxy_buffering off; # Required for HTTP-based CLI to work over SSL
    # workaround for https://issues.jenkins-ci.org/browse/JENKINS-45651
    add_header 'X-SSH-Endpoint' 'jenkins.domain.tld:50022' always;
  }
}


#Check in the container
docker exec -it [nginx_container_name] cat /etc/nginx/conf.d/jenkins.conf
docker exec -it 780c1a28efd2 cat /etc/nginx/conf.d/jenkins.conf

# Make sure the syntax is OK
docker exec it-nginx nginx -t
# Restart Nginx server:
docker exec it-nginx nginx -s reload
```

