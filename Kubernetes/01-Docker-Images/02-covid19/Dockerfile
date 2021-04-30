FROM httpd
LABEL maintainer="Tia L"
RUN apt -y update
RUN apt -y install wget
RUN apt -y install unzip
WORKDIR /usr/local/apache2/htdocs/
RUN rm -rf *
RUN wget https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/covid19.zip
RUN unzip covid19.zip 
RUN cp -R covid19.zip/* . 
CMD ["httpd-foreground"]
EXPOSE 80