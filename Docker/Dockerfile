#Web content location in the container for HTTPD, NGINX AND TOMCAT
#HTTPD: /usr/local/apache2/htdocs/
#NGINX: /usr/share/nginx/html/
#TOMCAT: /usr/local/tomcat/webapps/


FROM httpd
LABEL maintainer="Tia M"
RUN apt -y update
RUN apt -y install wget
RUN apt -y install unzip
WORKDIR /usr/local/apache2/htdocs/
RUN rm -rf *
RUN wget https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/crypto.zip 
RUN unzip crypto.zip 
RUN cp -R crypto/* . 
CMD ["httpd-foreground"]
EXPOSE 80


FROM httpd
LABEL maintainer="Tia M"
RUN apt -y update
RUN apt -y install wget
RUN apt -y install unzip
WORKDIR /usr/local/apache2/htdocs/
RUN rm -rf *
RUN wget https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/covid19.zip
RUN unzip covid19.zip 
RUN cp -R covid19/* . 
CMD ["httpd-foreground"]
EXPOSE 80




FROM httpd
LABEL maintainer="Tia M"
RUN apt -y update && \
    apt -y install wget && \
    apt -y install unzip

WORKDIR /usr/local/apache2/htdocs/

RUN rm -rf * && \
    wget https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/covid19.zip && \
    unzip covid19.zip && \
    cp -R covid19/* . 

CMD ["httpd-foreground"]
EXPOSE 80



FROM httpd
LABEL maintainer="Tia M"
RUN apt -y update
RUN apt -y install wget
RUN apt -y install unzip
WORKDIR /usr/local/apache2/htdocs/
RUN rm -rf *
RUN wget https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/static-website-example.zip
RUN unzip static-website-example.zip
RUN cp -R static-website-example/* . 
CMD ["httpd-foreground"]
EXPOSE 80


FROM tomcat
LABEL maintainer="Tia M"
WORKDIR /usr/local/tomcat/webapps
RUN wget https://warfiles-for-docker.s3.amazonaws.com/addressbook.war
CMD "catalina.sh" "run"
EXPOSE 8080


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



FROM centos:latest
LABEL maintainer="Tia M"
RUN yum -y install httpd
COPY index.html /var/www/html/
CMD ["httpd-foreground"]
EXPOSE 80




