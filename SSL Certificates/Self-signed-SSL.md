### How to generate a self-signed SSL certificate using OpenSSL? [here](https://stackoverflow.com/questions/10175812/how-to-generate-a-self-signed-ssl-certificate-using-openssl)

**NB:** Web browser do not thrust self-signed SSL certificate

You can also add `-nodes` (short for no DES) if you don't want to protect your private key with a passphrase. Otherwise it will prompt you for "at least a 4 character" password.

Also, you will not add `ssl_password_file   /etc/ssl/passphrase.pass;`in your configuration if you add `-nodes`

The days parameter `(365)` you can replace with any number to affect the expiration date. It will then prompt you for things like "Country Name", but you can just hit Enter and accept the defaults.

cd /etc/nginx/sites-available/

```s
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365
openssl req -x509 -newkey rsa:4096 -keyout anomicatech.com.key -out anomicatech.com.pem -days 365
OR
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes
```

cat anomicatech.com.pem
```
-----BEGIN CERTIFICATE-----
MIIFazCCA1OgAwIBAgIUBlbaa8bkS4tH4yrPPh6WvKxZN4cwDQYJKoZIhvcNAQEL
BQAwRTELMAkGA1UEBhMCQVUxEzARBgNVBAgMClNvbWUtU3RhdGUxITAfBgNVBAoM
GEludGVybmV0IFdpZGdpdHMgUHR5IEx0ZDAeFw0yMTEwMDYwNDMyNDVaFw0yMjEw
MDYwNDMyNDVaMEUxCzAJBgNVBAYTAkFVMRMwEQYDVQQIDApTb21lLVN0YXRlMSEw
HwYDVQQKDBhJbnRlcm5ldCBXaWRnaXRzIFB0eSBMdGQwggIiMA0GCSqGSIb3DQEB
JB6UdIrNMzmDPBqLxjzIOgOCOBuogOD4PzJm6IY6WrrHiVQqcK/riJp1wyNJ81Ci
hsPC5uNiZGy7UxqlKThgI6UZKPVe6++bO6XkHCvBIeDhF6OCL7NYk6c05rdri5so
KC4OMNirYcloFG7r31WoHAF515+702c0s0OFibAA8uqBzgb5UH8ZXiFmYp/QRQk=
-----END CERTIFICATE-----


cat anomicatech.com.key

-----BEGIN PRIVATE KEY-----
MIIJQgIBADANBgkqhkiG9w0BAQEFAASCCSwwggkoAgEAAoICAQDEO8IUm74HqNtV
l3EZ41Tu4Jre7uSx2GnFy5L6RJDcVuCSeajWGP9GuWkCSLwGkm20mR2HLJpc3Ait
oNsCggEAZhOmtd4KWvom5dqpasnGtovzdxJWM8JYSoW2327/vGEm+8WjaXU5zTA8
C/g6Gpis6P40zsMecLby4nXTZdPcq6DJ1zuylv853b7XpcNga0PW1lBSVI2zMO0M
HHv14CzzNa+nrRvz7T/rNn/V9l70CpVdxM12MJcLL+mR8IFsKWX+/hSeJQMzCt0F
rxuZ72Oljb2uNPO8Ua4ctcfxMMj1WZyIJ3rFTQLgYTZlSmRSlSoF2g69pzzuqCtz
VVecPpGYYW8kKrZc+h/0U3heIdVNw/fP3m8aeDRYKKOjfRlJDsDhDLCMbzlWszmZ
pLaaYaTQWbeg/s3c4sQYAlnMnIc8EA==
-----END PRIVATE KEY-----

```
### 2. Add a file to decrypt the private key in nginx. Add the passphrase in that file
add `ssl_password_file   /etc/ssl/passphrase.pass` in the config
```
cd /etc/ssl/passphrase.pass
vim passphrase.pass
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
    ssl_password_file   /etc/ssl/passphrase.pass;

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
    ssl_password_file   /etc/ssl/passphrase.pass;

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

