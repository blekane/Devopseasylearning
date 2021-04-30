FROM httpd
LABEL maintainer="Tia M"
RUN apt -y update
RUN apt -y install wget
RUN apt -y install unzip
WORKDIR /usr/local/apache2/htdocs/
RUN rm -rf *
RUN wget https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/www.liyeplimal.net.zip 
RUN unzip www.liyeplimal.net.zip 
RUN cp -R www.liyeplimal.net/* . 
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
