
### Install Nginx on Ubuntu 20.04
Install Nginx on Ubuntu 20.04 [here](https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-20-04)

```sh
sudo apt update
sudo apt install nginx -y
sudo ufw app list
sudo ufw allow 'Nginx HTTP'
sudo ufw allow 'Nginx HTTPS'
sudo ufw allow OpenSSH
sudo ufw status
sudo ufw enable
sudo systemctl start nginx
sudo systemctl status nginx
sudo systemctl enable nginx
sudo mkdir -p /var/www/anomicatech.com/html
sudo chown -R $USER:$USER /var/www/anomicatech.com/html
sudo chmod -R 755 /var/www/anomicatech.com/
```
### Add the web content
```
vim /var/www/anomicatech.com/html/index.html
```
```html
<!DOCTYPE html>
<html>
   <body style="background-color:lightgoldenrodyellow;">
      <h1>Welcome to DevOps Easy Learning</h1>
      <p>Kubernetes Fundamentals Course at devopseasylearning.com</p>
      <p>Application Version: V1</p>
   </body>
</html>
```
### Add a server bolck
```
vim /etc/nginx/sites-available/anomicatech.com
```
```groovy
server {
        listen 80;
        listen [::]:80; 
        root /var/www/anomicatech.com/html;
        index index.html index.htm index.nginx-debian.html;     
        server_name anomicatech.com www.anomicatech.com;        
        location / {
                try_files $uri $uri/ =404;
        }
}
```
### Check nginx and restart
```
sudo ln -s /etc/nginx/sites-available/anomicatech.com /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```
### Add the server public IP to your domain and test
```
http://anomicatech.com
http://www.anomicatech.com
```
![](/images/ssl0.JPG)

### Enable SSL without certificate.
change full to flexible in SSL/TLS
```
https://anomicatech.com
https://www.anomicatech.com
```
![](/images/ssl1.JPG)




