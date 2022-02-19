

##https://docs.docker.com/develop/develop-images/multistage-build/

#Web content location in the container for HTTPD, NGINX AND TOMCAT
#HTTPD: /usr/local/apache2/htdocs/
#NGINX: /usr/share/nginx/html/
#TOMCAT: /usr/local/tomcat/webapps/


# -------------------------------------------------------------------------
FROM centos:latest
LABEL maintainer="Tia M"
RUN yum -y update && \
    yum -y install httpd

USER root
COPY index.html /var/www/html/
ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80

# OR 

FROM centos:latest
LABEL maintainer="Tia M"
RUN yum -y update && \
    yum -y install httpd

USER root
ADD index.html /var/www/html/
ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80

# OR 

FROM centos:latest
LABEL maintainer="Tia M"
RUN yum -y install httpd
COPY index.html /var/www/html/
USER root
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80
# -------------------------------------------------------------------------



# -------------------------------------------------------------------------
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
ENTRYPOINT ["httpd-foreground"]
EXPOSE 80

# OR 

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

# OR 

FROM httpd
ARG port=80
ARG user=root
LABEL maintainer="Tia M"
RUN apt -y update 
RUN apt -y install wget 
RUN apt -y install unzip 
RUN cd /usr/local/apache2/htdocs/ 
RUN rm -rf * 
RUN wget https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/covid19.zip 
RUN unzip covid19.zip 
RUN cp -R covid19/* . 
RUN rm -rf covid19.zip 
RUN rm -rf covid19 

USER root
CMD ["httpd-foreground"]
EXPOSE 80

# -------------------------------------------------------------------------



# -------------------------------------------------------------------------
FROM httpd
ARG port=80
ARG user=root
LABEL maintainer="Tia M"
RUN apt -y update && \
    apt -y install wget && \
    apt -y install unzip

WORKDIR /usr/local/apache2/htdocs/

RUN rm -rf * && \
    wget https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/static-website-example.zip && \
    unzip static-website-example.zip && \
    cp -R static-website-example/* . && \
    rm -rf static-website-example.zip && \
    rm -rf static-website-example

USER ${user}
ENTRYPOINT ["httpd-foreground"]
EXPOSE ${port}

# OR 

FROM httpd
ARG port=80
ARG user=root
LABEL maintainer="Tia M"
RUN apt -y update && \
    apt -y install wget && \
    apt -y install unzip && \
    cd /usr/local/apache2/htdocs/ && \
    rm -rf * && \
    wget https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/static-website-example.zip && \
    unzip static-website-example.zip && \
    cp -R static-website-example/* . && \
    rm -rf static-website-example.zip && \
    rm -rf static-website-example

USER ${user}
ENTRYPOINT ["httpd-foreground"]
EXPOSE ${port}

# OR 

FROM httpd
ARG port=80
ARG user=root
LABEL maintainer="Tia M"
RUN apt -y update 
RUN apt -y install wget 
RUN apt -y install unzip 
RUN cd /usr/local/apache2/htdocs/ 
RUN rm -rf * 
RUN wget https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/static-website-example.zip
RUN unzip static-website-example.zip 
RUN cp -R static-website-example/* . 
RUN rm -rf static-website-example.zip 
RUN rm -rf static-website-example

USER ${user}
CMD ["httpd-foreground"]
EXPOSE ${port}

# -------------------------------------------------------------------------



# -------------------------------------------------------------------------

FROM httpd
ARG port=80
ARG user=root
ARG WEB_DIRECTORY=static-website-example

LABEL maintainer="Tia M"
RUN apt -y update && \
    apt -y install wget && \
    apt -y install unzip

WORKDIR /usr/local/apache2/htdocs/

RUN rm -rf * && \
    wget https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/$WEB_DIRECTORY.zip && \
    unzip $WEB_DIRECTORY.zip && \
    cp -R $WEB_DIRECTORY/* . && \
    rm -rf $WEB_DIRECTORY.zip && \
    rm -rf $WEB_DIRECTORY

USER ${user}
ENTRYPOINT ["httpd-foreground"]
EXPOSE ${port}

# OR


FROM httpd

ARG WEB_DIRECTORY=covid19 
ARG port=80
ARG user=root
LABEL maintainer="Tia M"
RUN apt -y update && \
    apt -y install wget && \
    apt -y install unzip

WORKDIR /usr/local/apache2/htdocs/

RUN rm -rf * && \
    wget https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/$WEB_DIRECTORY.zip && \
    unzip $WEB_DIRECTORY.zip && \
    cp -R $WEB_DIRECTORY/* . && \
    rm -rf $WEB_DIRECTORY.zip && \
    rm -rf $WEB_DIRECTORY

USER ${user}
ENTRYPOINT ["httpd-foreground"]
EXPOSE ${port}
# -------------------------------------------------------------------------



# -------------------------------------------------------------------------
FROM tomcat
ARG port=8080
ARG user=root
LABEL maintainer="Tia M"
ADD https://warfiles-for-docker.s3.amazonaws.com/addressbook.war /usr/local/tomcat/webapps/
USER ${user}
ENTRYPOINT ["catalina.sh", "run"]
EXPOSE ${port}


FROM tomcat
LABEL maintainer="Tia M"
WORKDIR /usr/local/tomcat/webapps
RUN wget https://warfiles-for-docker.s3.amazonaws.com/addressbook.war
CMD ["catalina.sh", "run"]
EXPOSE 8080

FROM tomcat
LABEL maintainer="Tia M"
RUN cd /usr/local/tomcat/webapps && \
    wget https://warfiles-for-docker.s3.amazonaws.com/addressbook.war
CMD ["catalina.sh", "run"]
EXPOSE 8080


# -------------------------------------------------------------------------
FROM centos
ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG JENKINS_HOME=/var/jenkins_home

ENV TIA_HOME /var/tia/devops

RUN mkdir -p $JENKINS_HOME \
    && chown ${uid}:${gid} $JENKINS_HOME \
    && groupadd -g ${gid} ${group} \
    && useradd -d "$JENKINS_HOME" -u ${uid} -g ${gid} -s /bin/bash ${user}

USER ${user}


# -------------------------------------------------------------------------


FROM tomcat:latest
LABEL maintainer="Tia M"
WORKDIR /opt
RUN mkdir pebble
WORKDIR /opt/pebble
RUN wget http://prdownloads.sourceforge.net/pebble/pebble-2.6.4.zip?download
RUN unzip -q pebble-2.6.4.zip\?download
RUN rm -rf /usr/local/tomcat/webapps/*
RUN cd /opt/pebble/pebble-2.6.4 && cp -r pebble-2.6.4.war /usr/local/tomcat/webapps
RUN cd /usr/local/tomcat/webapps && mv pebble-2.6.4.war pebble.war
RUN cd /opt && rm -rf pebble
EXPOSE 8080
CMD ["catalina.sh", "run"]


# -------------------------------------------------------------------------


FROM stakater/oracle-jdk:8u152-alpine-3.7

LABEL Stakater Team

## Arguments

ARG USER=jenkins
ARG GROUP=jenkins
# why 386? Please read: https://github.com/jenkinsci/docker/issues/112#issuecomment-228553691
ARG UID=386
ARG GID=386
ARG HTTP_PORT=8080
ARG AGENT_PORT=50000
ARG JENKINS_VERSION=2.95
# This can be used to customize where jenkins.war get downloaded from:
ARG JENKINS_URL=https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war
ARG INSTALL_PLUGINS=ace-editor:1.1,async-http-client:1.7.24.1,ant:1.5,antisamy-markup-formatter:1.5,ansicolor:0.5.2,authentication-tokens:1.3,blueocean-autofavorite:1.0.0,blueocean-commons:1.3.5,blueocean-config:1.3.5,blueocean-dashboard:1.3.5,blueocean-display-url:2.1.0,blueocean-events:1.3.5,blueocean-git-pipeline:1.3.5,blueocean-github-pipeline:1.3.5

## Environment Variables

ENV JENKINS_USER ${USER}
ENV INSTALL_PLUGINS ${INSTALL_PLUGINS}
ENV IMAGE_CONFIG_DIR /usr/local/bin
ENV JENKINS_WAR_PATH /usr/share/jenkins
ENV JENKINS_HOME /var/jenkins_home
ENV JENKINS_SLAVE_AGENT_PORT ${AGENT_PORT}
# jenkins version being bundled in this docker image
ENV JENKINS_VERSION ${JENKINS_VERSION}
ENV JENKINS_UC https://updates.jenkins.io
ENV JENKINS_UC_EXPERIMENTAL https://updates.jenkins.io/experimental
ENV COPY_REFERENCE_FILE_LOG $JENKINS_HOME/copy_reference_file.log

RUN apk add --no-cache git openssh-client curl unzip bash ttf-dejavu coreutils gettext

# Jenkins is run with USER `jenkins`, UID = 386
# If you bind mount a volume from the host or a data container,
# ensure you use the same UID; and then things will work happily!
RUN addgroup -g ${GID} ${GROUP} \
    && adduser -h "$JENKINS_HOME" -u ${UID} -G ${GROUP} -s /bin/bash -D ${USER}

# Jenkins home directory is a volume, so configuration and build history
# can be persisted and survive image upgrades
VOLUME /var/jenkins_home

# `/usr/share/jenkins/ref/` contains all reference configuration we want
# to set on a fresh new installation. Use it to bundle additional plugins
# or config file with your custom jenkins Docker image.
RUN mkdir -p /usr/share/jenkins/ref/init.groovy.d

## This is used to modify the jenkins slave agent port to 5000 as specified in JENKINS_SLAVE_AGENT_PORT env
COPY init.groovy /usr/share/jenkins/ref/init.groovy.d/tcp-slave-agent-port.groovy

# could use ADD but this one does not check Last-Modified header neither does it allow to control checksum
# see https://github.com/docker/docker/issues/8331
RUN curl -fsSL ${JENKINS_URL} -o ${JENKINS_WAR_PATH}/jenkins.war

## Expose

# for main web interface:
EXPOSE ${HTTP_PORT}
# will be used by attached slave agents:
EXPOSE ${AGENT_PORT}

COPY ./contrib ${IMAGE_CONFIG_DIR}

# Make daemon service dir for jenkins and place file
# It will be started and maintained by the base image
RUN mkdir -p /etc/service/jenkins
COPY ./contrib/run.sh /etc/service/jenkins/run




