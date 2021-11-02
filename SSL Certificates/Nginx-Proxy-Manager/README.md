# Nginx Proxy Manager
-  Nginx Proxy Manager Get Started [here](https://nginxproxymanager.com/guide/)
- Cloudflare CDN: How to Setup + Purchase Domain + NGINX Proxy Manager [here](https://www.youtube.com/watch?v=c6Y6M8CdcQ0&list=PLrafTkhP5sZzKQd31XOslFxtrL2yBP2Yg&index=9&t=1423s)
- Secure Your Domain with NGINX Proxy Manager and CloudFlare [here](https://www.youtube.com/watch?v=rj7DZdWMK2k&list=PLrafTkhP5sZzKQd31XOslFxtrL2yBP2Yg&index=11&t=1616s)
- NGINX Proxy Manager – How-To Installation and Configuration [here](https://www.the-digital-life.com/nginx-proxy-manager/)
- Docker container for Nginx Proxy Manager [here](https://hub.docker.com/r/jlesage/nginx-proxy-manager)

```s
docker run -d \
    --name=nginx-proxy-manager \
    -p 81:81 \
    -p 80:80 \
    -p 443:443 \
    -v /docker/appdata/nginx-proxy-manager:/config:rw \
    jlesage/nginx-proxy-manager
```
```
Default Administrator User
Email:    admin@example.com
Password: changeme
```

### How to install docker on ubuntu
```
sudo apt-get update
apt-get remove docker docker-engine docker.io
apt install docker.io -y
systemctl start docker
systemctl enable docker
docker --version
```

### Compose Installation on Ubuntu?
```
apt update -y
snap install docker         
apt  install docker-compose  -y
docker-compose --version
```

### Nginx Proxy Manager compose file
-  Nginx Proxy Manager Get Started [here](https://nginxproxymanager.com/guide/)
```
Default Admin User:
Email: admin@example.com
Password: changeme
```
```yml
version: '3'
services:
  app:
    image: 'jc21/nginx-proxy-manager:latest'
    ports:
      - '80:80'
      - '81:81'
      - '443:443'
    environment:
      DB_MYSQL_HOST: "db"
      DB_MYSQL_PORT: 3306
      DB_MYSQL_USER: "npm"
      DB_MYSQL_PASSWORD: "npm"
      DB_MYSQL_NAME: "npm"
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
    networks:
      - frontend
  db:
    image: 'jc21/mariadb-aria:latest'
    environment:
      MYSQL_ROOT_PASSWORD: 'npm'
      MYSQL_DATABASE: 'npm'
      MYSQL_USER: 'npm'
      MYSQL_PASSWORD: 'npm'
    volumes:
      - ./data/mysql:/var/lib/mysql
networks:
  frontend:
    driver: bridge

# Install with grafana
version: '3'
services:
  app:
    image: 'jc21/nginx-proxy-manager:latest'
    ports:
      - '80:80'
      - '81:81'
      - '443:443'
    environment:
      DB_MYSQL_HOST: "db"
      DB_MYSQL_PORT: 3306
      DB_MYSQL_USER: "npm"
      DB_MYSQL_PASSWORD: "npm"
      DB_MYSQL_NAME: "npm"
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
    networks:
      - frontend
  db:
    image: 'jc21/mariadb-aria:latest'
    environment:
      MYSQL_ROOT_PASSWORD: 'npm'
      MYSQL_DATABASE: 'npm'
      MYSQL_USER: 'npm'
      MYSQL_PASSWORD: 'npm'
    volumes:
      - ./data/mysql:/var/lib/mysql
    networks:
      - frontend

  grafana:
    image: grafana/grafana
    ports:
      - "3000:3000"
    networks:
      - frontend

networks:
  frontend:
    driver: bridge
```

## Nginx Proxy Manager configuration
We just need to create one certificate from cloudflare, upload into Nginx Proxy Manager and use it instead of creating multiple certificate for every app
```
server.pem
private.key
```
![](/images/ssl7.JPG)

Set up the hosts with HTTP 
![](/images/ssl8.JPG)

Config Example
![](/images/ssl9.JPG)
![](/images/ssl10.JPG)

## Cloudflare configuration
```
jenkins.anomicatech.com
nginx.anomicatech.com
grafana.anomicatech.com
sonarqube.anomicatech.com
```
![](/images/ssl11.JPG)