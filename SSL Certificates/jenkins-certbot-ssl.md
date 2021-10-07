# Jenkins with Nginx and certbot

### A record in Godady
```
http://jenkins.anomicatech.com:8080/    //host is jenkins
http://anomicatech.com:8080/            /host is @
```

### Jenkins installation
```sh
sudo apt-get update
sudo apt-get install openjdk-11-jdk -y
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get ugrade -y
sudo apt-get install jenkins -y 
```

### Configure Jenkins behind Nginx and Secure With Let’s Encrypt SSL [here](https://computingforgeeks.com/configure-jenkins-behind-nginx-reverse-proxy-and-lets-encrypt-ssl/) and [here](https://www.youtube.com/watch?v=1kODzoPrU1Q)

### Step 1: Install Nginx web server
```sh
# CentOS / RHEL
sudo yum -y install nginx vim

# Fedora
sudo dnf -y install nginx vim

# Ubuntu / Debian
sudo apt update
sudo apt install nginx vim
```

### Step 2: Install Cerbot Certificate generation tool

```sh
# Ubuntu / Debian
sudo apt update
sudo apt install certbot
sudo apt install python3-certbot-nginx
# Python 2
sudo apt install python2-certbot-nginx

# Fedora
sudo dnf install certbot python2-certbot-nginx

# CentOS 8 / Rocky Linux 8
sudo dnf -y install epel-release
sudo yum -y install certbot python3-certbot-nginx
 
# CentOS 7
sudo yum -y install epel-release
sudo yum -y install certbot python2-certbot-nginx
```

### Step 3: Configure Nginx for Jenkins Server
After installing Nginx web server we can start creating VirtualHost configuration file:
```
sudo vim /etc/nginx/conf.d/jenkins.conf
```

```groovy
upstream jenkins {
  server 127.0.0.1:8080 fail_timeout=0;
}

server {
  listen 80;
  server_name jenkins.anomicatech.com www.jenkins.anomicatech.com;

  location / {
    proxy_set_header        Host $host:$server_port;
    proxy_set_header        X-Real-IP $remote_addr;
    proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header        X-Forwarded-Proto $scheme;
    proxy_pass              http://jenkins;
    # Required for new HTTP-based CLI
    proxy_http_version 1.1;
    proxy_request_buffering off; 
    proxy_buffering off; # Required for HTTP-based CLI to work over SSL
    }
}
```

RESULT OF `/etc/nginx/conf.d/jenkins.conf` AFTER CERTIFICATE GENERATION
```groovy
 cat /etc/nginx/conf.d/jenkins.conf


upstream jenkins {
  server 127.0.0.1:8080 fail_timeout=0;
}

server {
  server_name jenkins.anomicatech.com;
  location / {
    proxy_set_header        Host $host:$server_port;
    proxy_set_header        X-Real-IP $remote_addr;
    proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header        X-Forwarded-Proto $scheme;
    proxy_pass              http://jenkins;
    # Required for new HTTP-based CLI
    proxy_http_version 1.1;
    proxy_request_buffering off;
    proxy_buffering off; # Required for HTTP-based CLI to work over SSL
  }
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/jenkins.anomicatech.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/jenkins.anomicatech.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}
server {
    if ($host = jenkins.anomicatech.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot

  listen 80;
  server_name jenkins.anomicatech.com;
    return 404; # managed by Certbot
```

**Validate your Nginx configuration:**
```
sudo systemctl enable --now nginx
sudo systemctl restart nginx
sudo nginx -t
```

### Step 4: Secure Jenkins Server With Let’s Encrypt SSL
````
export DOMAIN="jenkins.anomicatech.com"
export ALERTS_EMAIL="tiajearad@gmail.com"

sudo certbot --nginx -d jenkins.anomicatech.com
````

### Automatically Renew Let’s Encrypt Certificates
```
sudo crontab -e
0 12 * * * /usr/bin/certbot renew --quiet
```
### The Jenkins Dashboard should show after login.
```
https://jenkins.anomicatech.com/
```