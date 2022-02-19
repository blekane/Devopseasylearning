```Dockerfile
wget https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/covid19.zip 
unzip covid19.zip 
cp -R covid19/* .
rm -rf covid19.zip 
rm -rf covid19

HTTPD: /usr/local/apache2/htdocs/
NGINX: /usr/share/nginx/html/
TOMCAT: /usr/local/tomcat/webapps/


docker run -it -d -p 8084:80 --name httpd_tia -v "$PWD":"/usr/local/apache2/htdocs/" --workdir "/usr/local/apache2/htdocs/" httpd  

docker run -it -d \
       -p 8083:80 \
       --name httpd_tia \
       -v "$PWD":"/usr/local/apache2/htdocs/" \
       --workdir "/usr/local/apache2/htdocs/" \
       httpd  

docker run -it --rm \
       -v "$PWD":"/code" \
       --workdir "/code" \
       ubuntu
          

docker run --rm \
       -v "$PWD":"/code" \
       --workdir "/code" \
       ubuntu \
          bash script.sh


docker run --rm \
       -v "$PWD":"/code" \
       --workdir "/code" \
       ubuntu bash script.sh


docker run --rm \
       -v "$PWD":"/code" \
       --workdir "/code" \
       ubuntu cat /etc/*release


docker run --rm \
       -v "$PWD":"/python" \
       --workdir "/python" \
       python \
           python python.py


docker run -it --rm \
       -v "$PWD":"/awscli" \
       --workdir "/awscli" \
       organs/awscli


## We will have a project on this for interview
docker run -it --rm \
       -v "$PWD":"/code" \
       --workdir "/code" \
       container-here

docker run -it --rm \
       --name some-postgres2 \
       -e POSTGRES_PASSWORD=12345 \
       -d postgres \
       postgres bash


