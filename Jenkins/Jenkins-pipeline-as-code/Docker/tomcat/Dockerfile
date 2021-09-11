FROM tomcat
LABEL maintainer="Tia M"
WORKDIR /usr/local/tomcat/webapps
RUN rm -rf *
RUN wget https://warfiles-for-docker.s3.amazonaws.com/addressbook.war
CMD ["catalina.sh", "run"]
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