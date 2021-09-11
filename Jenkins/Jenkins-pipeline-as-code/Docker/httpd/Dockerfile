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




FROM httpd
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

USER root
ENTRYPOINT ["httpd-foreground"]
EXPOSE 80




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




FROM httpd

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

USER root
ENTRYPOINT ["httpd-foreground"]
EXPOSE 80





FROM httpd

ARG WEB_DIRECTORY=www.liyeplimal.net

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

USER root
ENTRYPOINT ["httpd-foreground"]
EXPOSE 80