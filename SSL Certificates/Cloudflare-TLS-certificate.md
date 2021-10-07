# Setting up Cloudflare Origin TLS certificate
### 1. Create a certificate in clouflare [here](https://developers.cloudflare.com/ssl/client-certificates/create-a-client-certificate)

![](/images/ssl2.JPG)

Copy the certificate and the private key
```
-----BEGIN CERTIFICATE-----
BJIXJPqeAL+3pIAQBC5A2lvgC2z94rULwVB1JTEo8aXNkz8+Ocw7sS0CsIxrWDDQ
VmVBmCjdiINwe56T6ZYkTsXU4xsOdHM0LiQWQxWQRBpJBeLLdWDVUPNss/7BNsLl
qBcuVJzImc7/jarsbnraRLD5WbXYS1TyHMax8AtFe1NRNmqL3ULzdmch0McPrLpM
mv0XXg/K6RFpsAUc0nXKJYLM2tc3vLXLWRf6ISeXKN/VmHwTT48mE0UzW6NFRule
MXBzYssoerV9JTLavEyDl++ZE6vgbG9QPcI/MzHkdDsNLs6XtEZGBl0=
-----END CERTIFICATE-----


-----BEGIN PRIVATE KEY-----
p1gjZNcvuAmQ8FF3s0SlFUkgJofmOUJ30l8FCXIEh6688YZWjAJBlkp5O5H6yGfz
ZHilhc95bfOW5A+qo0EXf0gP0So8SOjtLHVSSKsCgYAfr59P+dEJOrL+FWgUg6I7
W+dtBPprsIHDg/OCixEBtjgyNpAWxNADj/VNaEPQcgvAvOa1aQ8JwsjOUxcvZZOH
tWcWy9NYp8Y01ER9qutngFiwn/pjh6hytl1c9qzcXmDBrlyUJElgsfP8oX2Y93K0
0uzYYjy9E6C6mRrzryrqsw==
-----END PRIVATE KEY-----

```

### 2. Install a certificate
create 2 files in `/etc/ssl/` and `your_domain_name.pem` and `your_domain_name.key` and put the certificate in `your_domain_name.pem` and the key in `your_domain_name.key`

- Certificate Installation Instructions by Platform/OS [here](https://www.digicert.com/kb/ssl-certificate-installation.htm)

- Nginx: Create CSR & Install SSL Certificate [here](https://www.digicert.com/kb/csr-ssl-installation/nginx-openssl.htm#ssl_certificate_install)


```sh
server {

    listen   443;

    ssl    on;
    ssl_certificate  /etc/ssl/your_domain_name.pem; (or bundle.crt)
    ssl_certificate_key  /etc/ssl/your_domain_name.key;

    server_name your.domain.com;
    access_log /var/log/nginx/nginx.vhost.access.log;
    error_log /var/log/nginx/nginx.vhost.error.log;
    location / {
    root   /home/www/public_html/your.domain.com/public/;
    index  index.html;
    }

}

# Create files
cd /etc/ssl
vim anomicatech.com.pem
vim anomicatech.com.key

# Remove all the the below file and add the new content
> /etc/nginx/sites-available/anomicatech.com
vim /etc/nginx/sites-available/anomicatech.com

server {
    listen 443;
    listen [::]:443;

    ssl on;
    ssl_certificate /etc/ssl/anomicatech.com.pem; 
    ssl_certificate_key /etc/ssl/anomicatech.com.key;

    root /var/www/anomicatech.com/html;
    index index.html;
    server_name www.anomicatech.com anomicatech.com;
    location / {
            try_files $uri $uri/ =404;
        }
    }

# Remove default Nginx web content
cd /var/www/html/ && rm -rf *

# Reload Nginx configuration
nginx -t
systemctl reload nginx
systemctl status nginx

# Test
anomicatech.com
www.anomicatech.com
https://www.anomicatech.com
```

