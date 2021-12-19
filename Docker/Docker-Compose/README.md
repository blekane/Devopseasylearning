# DOCKER COMPOSE
[Overview of Docker Compose](https://docs.docker.com/compose/)

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

## Docker compose file naming convention
- docker-compose.yml
- docker-compose.yaml

## Docker compose file structure
- version: '3.X'
- servives

## Build the application
```sh
docker-compose build

# for new version of docker
docker compose build
```
## Start the application
```sh
docker-compose up -d
docker-compose up 

# for new version of docker
docker compose up -d
docker compose up 
```

## Stop the application
```sh
docker-compose down

# for new version of docker
docker compose down
```

## Key docker compose bulid properties
1. context: It tell us where to look for the `Dockerfile` or path
2. dockerfile: It use when the name of the Dockerfile is not the default `Dockerfile`. It may be node.dockerfile or something else
3. arg: It the an env
4. image: for image properties like tag, name and so on


```yml
service:
  node:
    image: nodeapp

    build:

      context: .

      context: ./app/

      dockerfile: ./app/node.dockerfile

      dockerfile: java.dockerfile

      arg:
        buildversion: 1
        
    ports:
      - "3000:3000"
```

```yml
service:
  node:
    image: nodeapp # name of the image that we are going to build

    build:

      context: . # the Dockerfile is in the same directory

      context: ./app/ # the Dockerfile is in /app

      dockerfile: ./app/node.dockerfile # The Dockerfile is name differently and it is in /app

      dockerfile: java.dockerfile # The Dockerfile is name differently and is in the same directory

      arg:
        buildversion: 1
        
    ports:
      - "3000:3000"
```

## Build a single image
```yml
version: '3.7'

services:

  node:
    container_name: nodeapp
    image: nodeapp
    build:
      context: .
      dockerfile: node.dockerfile
      args:
        PACKAGES: "nano wget curl"
    ports:
      - "3000:3000"
    networks:
      - nodeapp-network
    volumes:
      - ./logs:/var/www/logs
    environment:
      - NODE_ENV=production
      - APP_VERSION=1.0
    env_file: /app/ # env file path to set env
    depends_on: 
      - mongodb
      
  mongodb:
    container_name: mongodb
    image: mongo
    networks:
      - nodeapp-network

networks:
  nodeapp-network:
    driver: bridge
```

## Build a multiple images
Set the environment variables in your command

export APP_ENV=development
export DOCKER_ACCT=codewithdan
export ENV=dev

```yml
version: "3.7"
 
services:
    nginx:
      container_name: nginx
      image: ${DOCKER_ACCT}/nginx #codewithdan/nginx
      build: 
        context: .
        dockerfile: .docker/nginx.${APP_ENV}.dockerfile
      # links are deprecated (networks are used instead for communication and 
      # depends_on for upstream node name in nginx config)
      # links:
      #   - node1:node1
      #   - node2:node2
      #   - node3:node3
      depends_on: 
        - node
      ports:
        - "80:80"
        - "443:443"
      networks:
        - codewithdan-network
        
    node:
      container_name: node-codewithdan
      image: ${DOCKER_ACCT}/node-codewithdan #codewithdan/node-codewithdan 
      build: 
        context: .
        dockerfile: .docker/node-codewithdan.${APP_ENV}.dockerfile
      ports:
      - "8080"
      volumes:
        - .:/var/www/codewithdan
      working_dir: /var/www/codewithdan
      env_file:
        - ./.docker/env/app.${APP_ENV}.env
      depends_on:
        - mongo
        - redis
      networks:
        - codewithdan-network
            
    mongo:
      container_name: mongo
      image: ${DOCKER_ACCT}/mongo #codewithdan/mongo 
      build:
        context: .
        dockerfile: .docker/mongo.dockerfile
      ports:
      - "27017:27017"
      env_file:
        - ./.docker/env/mongo.${APP_ENV}.env
      networks:
        - codewithdan-network
        
    redis:
      container_name: redis
      image: ${DOCKER_ACCT}/redis #codewithdan/redis
      build: 
        context: .
        dockerfile: .docker/redis.${APP_ENV}.dockerfile
      ports:
        - "6379"
      networks:
        - codewithdan-network

    # cadvisor:
    #   container_name: cadvisor
    #   image: google/cadvisor
    #   volumes:
    #     - /:/rootfs:ro
    #     - /var/run:/var/run:rw
    #     - /sys:/sys:ro
    #     - /var/lib/docker/:/var/lib/docker:ro
    #   ports:
    #     - "8080:8080"
    #   networks:
    #     - codewithdan-network
        
networks:
    codewithdan-network:
      driver: bridge
```

```yml
version: "3.7"
 
services:
    nginx:
      container_name: nginx
      image: ${DOCKER_ACCT}/${ENV}:nginx #codewithdan/dev:nginx
      build: 
        context: .
        dockerfile: .docker/nginx.${APP_ENV}.dockerfile
      depends_on: 
        - node
      ports:
        - "80:80"
        - "443:443"
      networks:
        - codewithdan-network
        
    node:
      container_name: node-codewithdan
      image: ${DOCKER_ACCT}/${ENV}:node-codewithdan #codewithdan/dev:node-codewithdan 
      build: 
        context: .
        dockerfile: .docker/node-codewithdan.${APP_ENV}.dockerfile
      ports:
      - "8080"
      volumes:
        - .:/var/www/codewithdan
      working_dir: /var/www/codewithdan
      env_file:
        - ./.docker/env/app.${APP_ENV}.env
      depends_on:
        - mongo
        - redis
      networks:
        - codewithdan-network
            
    mongo:
      container_name: mongo
      image: ${DOCKER_ACCT}/${ENV}:mongo #codewithdan/dev:mongo 
      build:
        context: .
        dockerfile: .docker/mongo.dockerfile
      ports:
      - "27017:27017"
      env_file:
        - ./.docker/env/mongo.${APP_ENV}.env
      networks:
        - codewithdan-network
        
    redis:
      container_name: redis
      image: ${DOCKER_ACCT}/${ENV}:redis #codewithdan/dev:redis
      build: 
        context: .
        dockerfile: .docker/redis.${APP_ENV}.dockerfile
      ports:
        - "6379"
      networks:
        - codewithdan-network
```


### Push images with docker compose
```sh
docker push [user name]/[repository name]:[tag]

docker-compose push
docker compose push

# Images to push
codewithdan/dev:node-codewithdan 
codewithdan/dev:nginx
codewithdan/dev:mongo 
codewithdan/dev:redis
```

## Example 
Create a compose file
```yml
# Create a compose file
mkdir compose
cd compose/
vim docker-compose.yml

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

# Access the application
http://10.0.0.94:8050
http://10.0.0.94:8060/happy_new_year
```

## Postgres
Create a compose file
```yml
# Create a compose file
mkdir compose
cd compose/
vim docker-compose.yml

version: '3'
services:
  postgres:
    image: postgres
    hostname: postgres
    ports:
    - "5432:5432"
    environment:
    - POSTGRES_USER=tia
    - POSTGRES_PASSWORD=password
    - POSTGRES_DB=demodb

# Commands
docker-compose up -d
docker-compose down

# Login in postgres
docker exec -it [Running Container ID or name] psql --host=postgres --username=tia dbname=demodb
docker exec -it 35294ae7753c psql --host=postgres --username=tia dbname=demodb
```

### Docker postgres pgadmin local connection
Combine Postgres and Pgadmin in one docker-compose file, and login as user pgadmin4@pgadmin.org, password: admin. To add the Posgres server, use hostname postgres, port 5432 and password:postgres
```yml
version: '3'
services:
  postgres:
    image: postgres
    hostname: postgres
    ports:
      - "5432:5432"
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_DB: TEST_SM
    volumes:
      - postgres-data:/var/lib/postgresql/data
    restart: unless-stopped

  pgadmin:
    image: dpage/pgadmin4
    depends_on:
      - postgres
    ports:
      - "5555:80"
    environment:
      PGADMIN_DEFAULT_EMAIL: pgadmin4@pgadmin.org
      PGADMIN_DEFAULT_PASSWORD: admin
    restart: unless-stopped

volumes:
  postgres-data:


# Commands
docker-compose up -d
docker-compose down

# Connection through CLI
docker exec -it [Running Container ID or name] psql --host=postgres --username=postgres dbname=TEST_SM
docker exec -it 45971b9c64f4 psql --host=postgres --username=postgres dbname=TEST_SM
```
![](/images/pos.JPG)


##  Jenkins
```yml
version: '3'
services:
  jenkins:
    image: jenkins/jenkins:lts
    ports:
    - "8070:8080"
  
# Commands
docker-compose up -d
docker-compose down

# Get Jenkins password 
docker exec -it [Running Container ID or name] cat /var/jenkins_home/secrets/initialAdminPassword
docker exec -it 51601e2b419e cat /var/jenkins_home/secrets/initialAdminPassword
```

##  Nexus
```yml
version: '3'
services:
  nexus:
    image: sonatype/nexus3
    ports:
    - "8081:8081"
      
# Commands
docker-compose up -d
docker-compose down

# Get Nexus password
docker exec -it [Running Container ID or name] cat /nexus-data/admin.password
docker exec -it nexus cat /nexus-data/admin.password
docker exec -it 96ca9c409aaa cat /nexus-data/admin.password
```


##  Sonarqube
```yml
version: '3'
services:
  sonarqube:
    image: sonarqube
    ports:
    - "9000:9000"
  
# Commands
docker-compose up -d
docker-compose down

# Sonarqube default username and password
username: admin
password: admin
```

##  Pgadmin
```yml
version: '3'
services:
  pgadmin:
    image: dpage/pgadmin4
    ports:
      - "5555:80"
    environment:
      PGADMIN_DEFAULT_EMAIL: pgadmin4@pgadmin.org
      PGADMIN_DEFAULT_PASSWORD: admin
    restart: unless-stopped
  
# Commands
docker-compose up -d
docker-compose down

# Pgadmin default username and password
username: pgadmin4@pgadmin.org
password: admin
```

## Splunk
```yml
version: '3'
services:
  splunk:
    image: splunk/splunk:latest
    ports:
    - "8000:8000"
    environment:
    - SPLUNK_START_ARGS=--accept-license
    - SPLUNK_PASSWORD=<password>

# Commands
docker-compose up -d
docker-compose down

# splunk default username and password
username: admin
password: <password>
```

## Grafana
```yaml
version: '3'
services:
  grafana:
    image: grafana/grafana
    ports:
    - "3000:3000"

# Grafana default username and password
username: admin
password: admin
```

## Example
**1. Create a compose file**
```
mkdir compose
cd compose/
vim docker-compose.yml
```
```yaml
version: '3'
services:
  jenkins:
    image: jenkins/jenkins:lts
    ports:
    - "8070:8080"
  nexus:
    image: sonatype/nexus3
    ports:
    - "8081:8081"
  sonarqube:
    image: sonarqube
    ports:
    - "9000:9000"
  grafana:
    image: grafana/grafana
    ports:
    - "3000:3000"
  splunk:
    image: splunk/splunk:latest
    ports:
    - "8000:8000"
    environment:
    - SPLUNK_START_ARGS=--accept-license
    - SPLUNK_PASSWORD=<password>
  mysql:
    image: mysql
    ports:
    - "3306:3306"
    environment:
    - MYSQL_ROOT_PASSWORD=password
    - MYSQL_USER=tia
    - MYSQL_PASSWORD=password
    - MYSQL_DATABASE=demodb
  postgres:
    image: postgres
    hostname: postgres
    ports:
      - "6543:5432"
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_DB: TEST_SM
    volumes:
      - postgres-data:/var/lib/postgresql/data
    restart: unless-stopped

  pgadmin:
    image: dpage/pgadmin4
    depends_on:
      - postgres
    ports:
      - "5555:80"
    environment:
      PGADMIN_DEFAULT_EMAIL: pgadmin4@pgadmin.org
      PGADMIN_DEFAULT_PASSWORD: admin
    restart: unless-stopped

volumes:
  postgres-data:
```
## Run the docker compose file to install the applications**
```
docker-compose up -d

docker images
docker ps

docker-compose down
```
**-d** = start all the container in detached mode or keep all containers running at the background

```sh
# Get Jenkins password 
docker exec -it [Running Container ID or name] cat /var/jenkins_home/secrets/initialAdminPassword
docker exec -it 51601e2b419e cat /var/jenkins_home/secrets/initialAdminPassword

# Get Nexus password
docker exec -it [Running Container ID or name] cat /nexus-data/admin.password
docker exec -it nexus cat /nexus-data/admin.password
docker exec -it 96ca9c409aaa cat /nexus-data/admin.password

# Sonarqube default username and password
username: admin
password: admin

# Login in MYSQL
docker exec -it [Running Container ID or name] mysql -u root -p
docker exec -it  0288342f1fe0 mysql -u root -p
docker exec -it 0288342f1fe0 mysql -u tia -p

# Test MYSQL DB
CREATE DATABASE MYSQLTEST;
SHOW DATABASES;
exit

# Connection through CLI
docker exec -it [Running Container ID or name] psql --host=postgres --username=postgres dbname=TEST_SM
docker exec -it 45971b9c64f4 psql --host=postgres --username=postgres dbname=TEST_SM

# splunk default username and password
username: admin
password: <password>
http://192.168.2.33:8000/

# Grafana default username and password
username: admin
password: admin
http://192.168.2.33:3000/
```

## LAMP

[docker-compose-lamp](https://github.com/leonardtia1/docker-compose-lamp)

**Environment file call sample.env**
```sh
# Please Note:
# In PHP Versions <= 7.4 MySQL8 is not supported due to lacking pdo support

# To determine the name of your containers
COMPOSE_PROJECT_NAME=lamp

# Possible values: php54, php56, php71, php72, php73, php74
PHPVERSION=php74
DOCUMENT_ROOT=./www
VHOSTS_DIR=./config/vhosts
APACHE_LOG_DIR=./logs/apache2
PHP_INI=./config/php/php.ini

# Possible values: mariadb, mysql, mysql8
DATABASE=mysql
MYSQL_DATA_DIR=./data/mysql
MYSQL_LOG_DIR=./logs/mysql

# If you already have the port 80 in use, you can change it (for example if you have Apache)
HOST_MACHINE_UNSECURE_HOST_PORT=80
HOST_MACHINE_SECURE_HOST_PORT=443

# If you already have the port 3306 in use, you can change it (for example if you have MySQL)
HOST_MACHINE_MYSQL_PORT=3306

# If you already have the port 8080 in use, you can change it
HOST_MACHINE_PMA_PORT=8080

# If you already has the port 6379 in use, you can change it (for example if you have Redis)
HOST_MACHINE_REDIS_PORT=6379

# MySQL root user password
MYSQL_ROOT_PASSWORD=tiger

# Database settings: Username, password and database name
MYSQL_USER=docker
MYSQL_PASSWORD=docker
MYSQL_DATABASE=docker
```

*Docker compose file**
```yaml
version: "3"

services:
  webserver:
    build: 
      context: ./bin/${PHPVERSION}
    container_name: '${COMPOSE_PROJECT_NAME}-${PHPVERSION}'
    restart: 'always'
    ports:
      - "${HOST_MACHINE_UNSECURE_HOST_PORT}:80"
      - "${HOST_MACHINE_SECURE_HOST_PORT}:443"
    links: 
      - database
    volumes: 
      - ${DOCUMENT_ROOT-./www}:/var/www/html
      - ${PHP_INI-./config/php/php.ini}:/usr/local/etc/php/php.ini
      - ${VHOSTS_DIR-./config/vhosts}:/etc/apache2/sites-enabled
      - ${LOG_DIR-./logs/apache2}:/var/log/apache2
    environment:
      PMA_PORT: ${HOST_MACHINE_PMA_PORT}
  database:
    build:
      context: "./bin/${DATABASE}"
    container_name: '${COMPOSE_PROJECT_NAME}-database'
    restart: 'always'
    ports:
      - "127.0.0.1:${HOST_MACHINE_MYSQL_PORT}:3306"
    volumes: 
      - ${MYSQL_DATA_DIR-./data/mysql}:/var/lib/mysql
      - ${MYSQL_LOG_DIR-./logs/mysql}:/var/log/mysql
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
      MYSQL_USER: ${MYSQL_USER}
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
  phpmyadmin:
    image: phpmyadmin/phpmyadmin
    container_name: '${COMPOSE_PROJECT_NAME}-phpmyadmin'
    links:
      - database
    environment:
      PMA_HOST: database
      PMA_PORT: 3306
      PMA_USER: ${MYSQL_USER}
      PMA_PASSWORD: ${MYSQL_PASSWORD}
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_USER: ${MYSQL_USER}
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
    ports:
      - '${HOST_MACHINE_PMA_PORT}:80'
    volumes: 
      - /sessions
      - ${PHP_INI-./config/php/php.ini}:/usr/local/etc/php/conf.d/php-phpmyadmin.ini
  redis:
    container_name: '${COMPOSE_PROJECT_NAME}-redis'
    image: redis:latest
    ports:
      - "127.0.0.1:${HOST_MACHINE_REDIS_PORT}:6379"
```





