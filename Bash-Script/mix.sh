#!/bin/bash
DOCKER_PS=`docker ps -a |awk '{print$1}'`
DOCKER_IMAGES=`docker images |awk '{print$3}'`

#To stop and delete all containers
for cont in $DOCKER_PS;
do
docker stop $cont
docker rm -f $cont
done

#Delete all images
for im in $DOCKER_IMAGES;
do
docker rmi -f $im
done

function MIX() {

#To stop and delete all containers
for cont in $(docker ps -a |awk '{print$1}');
do
docker stop $cont
docker rm -f $cont
done

#Delete all images
for im in $(docker images |awk '{print$3}');
do
docker rmi -f $im
done

#Web content location in the container for HTTPD, NGINX AND TOMCAT
HTTPD: /usr/local/apache2/htdocs/
NGINX: /usr/share/nginx/html/
TOMCAT: /usr/local/tomcat/webapps/

}