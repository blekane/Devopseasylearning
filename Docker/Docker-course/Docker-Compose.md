# DOCKER COMPOSE

## What is Docker Compose?
- **Docker Compose** is a tool for defining and running multi-container Docker applications. 
- With Compose, you use a YAML file to configure your application's services. Then, with a single command, you create and start all the services from your configuration.
- Compose is use for microservices


## Docker Compose Installation on Linux?

```sh
curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
 
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose -version
```
## Docker Compose Installation on Ubuntu?
```
apt update -y
snap install docker         
apt  install docker-compose  -y
docker-compose --version
```

## Example
**1. Create a compose file**
```
mkdir compose
cd compose/
vim vim docker-compose.yml
```
```yaml
version: '3'
services:
  covid19:
    image: leonardtia/devops-pro-repos:covid19
    ports:
    - "8050:80"
  happy_new_year:
    image: leonardtia/devops-pro-repos:happy_new_year
    ports:
    - "8060:8080"
  jenkins:
    image: jenkins/jenkins:lts
    ports:
    - "8070:8080"
  db:
    image: mysql
    ports:
    - "3306:3306"
    environment:
    - MYSQL_ROOT_PASSWORD=password
    - MYSQL_USER=tia
    - MYSQL_PASSWORD=password
    - MYSQL_DATABASE=demodb
```
**2. Run the docker compose file to install the applications**

docker-compose up -d

-d = start all the container in detached mode or keep all containers running at the background


```
docker images
docker ps
```

**3. Test the web applications**
```
http://10.0.0.94:8050
http://10.0.0.94:8060/happy_new_year
http://10.0.0.94:8070
```

**4. Test MYSQL DB**
**Login into MYSQL container**
```
docker exec -it <mysql container ID> bash
docker exec -it ab3bc2b97c7e bash
```
**Login into MYSQL DB**
```
mysql -u root -p
mysql -u tia -p
```
**Run some MYSQL commands**
```
CREATE DATABASE MYSQLTEST;
SHOW DATABASES;
SELECT DISTINCT User FROM mysql.user;
```

**5. Uninstall the application**
```
docker-compose down
docker ps
```

## Example

**LAMP server:**
- Wordpress = front end or web server
- Mariadb = database
- Php = back end

**- wordpress:** for front end programing

**- phpadmin:** for back end programing

**- mariadb:** for DB


**1. Create a compose file**

**NB:** `links` will make sure that the dependency container is ready first before the other container. All containers here depend on the database. It will start the database first, configure it and link it with others to establish communication. Compose will automatically open communication

```
mkdir compose
cd compose/
vim docker-compose.yml
```
```yaml
version: '3'
services:
    wordpress:
        image: wordpress
        links:
        - wordpress_db:mysql
        ports:
        - "7070:80"
    
    wordpress_db:
        image: mariadb
        ports:
        - "3306:3306"
        environment:
        - MYSQL_ROOT_PASSWORD=password
    
    phpadmin:
        image: corbinu/docker-phpmyadmin
        links:
        - wordpress_db:mysql
        ports:
        - "8181:80"
        environment:
        - MYSQL_ROOT_PASSWORD=password
```
