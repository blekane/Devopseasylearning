# Jenkins with Nginx and Cloudflare [here](https://truongtx.me/2020/01/02/set-up-jenkins-server-nginx-free-cloudflare-ssl)

### Jenkins installation
```sh
sudo apt-get update
sudo apt-get install openjdk-11-jdk -y
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install jenkins -y 
```

### Add and A record on clouflare with jenkins public IP
![](/images/ssl4.JPG)

### install nginx
```
sudo apt-get install nginx -y
```

### Generate a self-signed certificate
sudo mkdir -p /etc/nginx/ssl
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.pem

### Create the file and add the below content
```sh
mkdir -p /etc/nginx/conf.d/
sudo vim /etc/nginx/conf.d/jenkins.conf

upstream jenkins {
  server 127.0.0.1:8080 fail_timeout=0;
}
server {
  listen 80;
  server_name jenkins.anomicatech.com;
  return 301 https://$host$request_uri;
}
server {
  listen 443 ssl;
  server_name jenkins.anomicatech.com;

  ssl_certificate /etc/nginx/ssl/server.pem;
  ssl_certificate_key /etc/nginx/ssl/server.key;

  location / {
    proxy_set_header        Host $host:$server_port;
    proxy_set_header        X-Real-IP $remote_addr;
    proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header        X-Forwarded-Proto $scheme;
    proxy_redirect http:// https://;
    proxy_pass              http://jenkins;
    # Required for new HTTP-based CLI
    proxy_http_version 1.1;
    proxy_request_buffering off;
    proxy_buffering off; # Required for HTTP-based CLI to work over SSL
    # workaround for https://issues.jenkins-ci.org/browse/JENKINS-45651
    add_header 'X-SSH-Endpoint' 'jenkins.domain.tld:50022' always;
  }
}

```

### Restart jenkins and nginx
```
nginx -t
sudo systemctl status nginx
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl restart nginx
sudo systemctl reload nginx
sudo systemctl restart jenkins 
```
### Test
```
jenkins.anomicatech.com
https://jenkins.anomicatech.com/
```

