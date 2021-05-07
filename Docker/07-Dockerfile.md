# Dockerfile

## What is a Dockerfile?
It a text file that carry out all the instructions to build a custom image. Or is a text document that contains all the commands a user could call on the command line to assemble a custom image. 

## Dockerfile Basics
Before we construct our Dockerfile, you need to understand what makes up the file. This will be a text file, named `Dockerfile`, that includes specific keywords that dictate how to build a specific image. The specific keywords you can use in a file are:
- FROM
- ADD 
- CMD 
- ENTRYPOINT 
- ENV 
- EXPOSE 
- MAINTAINER
- RUN 
- USER : root
- VOLUME 
- WORKDIR 
- LABEL

## Ways to Create a Custom Image
They are 2 ways to create a custom images
- From a running container (snapshort of a running container at a particular time)
- From Dockerfile (standard way use by companies out there)

## Instruction in Dockerfile
**1. FROM**

The Dockerfile FROM command specifies the base image of your Docker images.

**A base image** is the image that is used to create all of your container images. Your base image can be an official Docker image, such as Centos, or you can modify an official Docker image to suit your needs, or you can create your own base image from scratch.

If you want to start with a bare Linux image, you can use this FROM command:
```Dockerfile
FROM ubuntu:latest
```

**2. COPY**

The Dockerfile COPY command copies one or more files from the Docker host (the computer building the Docker image from the Dockerfile) into the Docker image. The COPY command can copy both a file or a directory from the Docker host to the Docker image. Here are some Dockerfile COPY examples:
```
COPY /myapp/target/myapp.jar /myapp/myapp.jar
```
This example copies a single file call `myapp.jar` from the Docker host at `/myapp/target/myapp.jar` to the Docker image at `/myapp/myapp.jar.` The first argument is the Docker host path (where to copy from) and the second argument is the Docker image path (where to copy to).


```Dockerfile
COPY /myapp/target/* /myapp/
```
This example copies all single files and directories from the Docker host at `/myapp/target/` to the Docker image at `/myapp/`. The first argument is the Docker host path (where to copy from) and the second argument is the Docker image path (where to copy to).



**3. RUN**

The RUN command is executed during build time of the Docker image, so `RUN` commands are only **executed once**. The RUN command can be used to extract files, to download files, to install packages, to run all shell command or other command line activities which are necessary to run while building the docker image.

```Dockerfile
RUN apt-get install some-needed-app
RUN yum -y install git
RUN mkdir -p /tmp/file
```

```Dockerfile
RUN apt -y update
RUN apt -y install wget
RUN apt -y install unzip

OR

RUN apt -y update && \
    apt -y install wget && \
    apt -y install unzip
```

```Dockerfile
RUN cd /usr/local/apache2/htdocs
RUN rm -rf * 
RUN wget https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/covid19.zip 
RUN unzip covid19.zip 
RUN cp -R covid19/* . 
RUN rm -rf covid19.zip 
RUN rm -rf covid19


OR 

RUN cd /usr/local/apache2/htdocs && \
    rm -rf * && \
    wget https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/covid19.zip && \
    unzip covid19.zip && \
    cp -R covid19/* .
    rm -rf covid19.zip && \
    rm -rf covid19 && \ 
```







**3. CMD**

The CMD command specifies the command line command to execute when a Docker container starts. can be used for executing a specific command within the container


Here are a few Dockerfile CMD examples:
CMD echo Docker container started.
CMD sh script.sh


## Dockerfile Example 1
```
vim Dockerfile
```
```Dockerfile
FROM httpd
LABEL maintainer="Tia M"
RUN apt -y update && \
    apt -y install wget && \
    apt -y install unzip

WORKDIR /usr/local/apache2/htdocs/

RUN rm -rf * && \
    wget https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/covid19.zip && \
    unzip covid19.zip && \
    cp -R covid19/* . && \
    rm -rf covid19.zip && \
    rm -rf covid19

USER root
CMD ["httpd-foreground"]
EXPOSE 80
```

**Biuld and test**
```
docker build -t <username>/<repository name>:tag
docker build -t leonardtia/devops_repo:covid19 .
docker run --name covid19 -p 8010:80 -d leonardtia/devops_repo:covid19 
docker login
docker push leonardtia/devops_repo:covid19
```

**Access Application locally**
```
http://<IP>:8010/
http://10.0.0.94:8010/
```

## Dockerfile Example 2

docker run --name covid19-3 -p 8030:80 -d leonardtia/devops_repo:covid19-3 
http://10.0.0.94:8030/












ADD copies the files from a source on the host into the container’s own filesystem at the set destination.
CMD can be used for executing a specific command within the container.
ENTRYPOINT sets a default application to be used every time a container is created with the image.
ENV sets environment variables.
EXPOSE associates a specific port to enable networking between the container and the outside world.
FROM defines the base image used to start the build process.
MAINTAINER defines a full name and email address of the image creator.
RUN is the central executing directive for Dockerfiles.
USER sets the UID (or username) which is to run the container.
VOLUME is used to enable access from the container to a directory on the host machine.
WORKDIR sets the path where the command, defined with CMD, is to be executed.
LABEL allows you to add a label to your docker image.


### Differences between a Dockerfile, Docker Image and Docker Container
- **A Dockerfile** is a recipe for creating Docker images
- **A Docker image** gets built by running a Docker command (which uses a Dockerfile)
- **A Docker container** is a running instance of a Docker image