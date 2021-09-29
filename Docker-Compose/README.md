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

# Sonarqube default password
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

# Pgadmin default password
username: pgadmin4@pgadmin.org
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

# Sonarqube default password
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
```
https://github.com/leonardtia1/docker-compose-lamp
https://github.com/marcel-dempers/docker-development-youtube-series/tree/master/storage/redis

version: "3"

services:
  redis:
    image: redis
    volumes:
      - ./data:/data
    ports:
      - 6379:6379


https://community.atlassian.com/t5/Jira-articles/How-to-run-Jira-in-a-docker-container/ba-p/752697







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
exit
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

---yaml
wordpress:
 image: wordpress
 links:
 - wordpress_db:mysql
 ports:
 - "7070:80"
 
wordpress_db:
 image: mariadb
 environment:
    MYSQL_ROOT_PASSWORD: password
 
phpadmin:
 image: corbinu/docker-phpmyadmin
 links:
 - wordpress_db:mysql
 ports:
 - "8181:80"
 environment:
    MYSQL_USERNAME: root
    MYSQL_ROOT_PASSWORD: password
```


**2. Run the docker compose file to install the applications**
```
docker-compose up -d
-d = start all the container in detached mode or keep all containers running at the background
```

```
docker images
docker ps
```

**3. Test the web applications**
```
http://10.0.0.94:8181
```
![](/images/php.JPG)


```
http://10.0.0.94:7070
```
![](/images/php.JPG)



https://github.com/DanWahlin/NodeExpressMongoDBDockerApp

https://github.com/DanWahlin/CodeWithDanDockerServices