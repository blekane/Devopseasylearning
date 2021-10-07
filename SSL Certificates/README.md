# Cloudflare
Create a CloudFlare Account [here](https://dash.cloudflare.com/)

CloudFlare is an American web infrastructure and website security company, providing content delivery network services, DDoS mitigation, Internet security, and distributed domain name server services. as a reverse proxy for websites

### Types of SSL in Cloudflare
![](/images/ssl5.JPG)

### Full (strict)
![](/images/ssl6.JPG)

### How to Get a Free Domain for Your Website
- Freenom [here](https://www.freenom.com)
- Wix [here](https://wixstats.com/?a=18045&c=124&s1=)
- Weebly [here](https://www.thefigco.com/weebly)
- Squarespace [here](https://www.thefigco.com/squarespace)
- Bluehost [here](https://www.bluehost.com/track/thefigco)
- Hostgator [here](https://fave.co/3jleBD0)

### Symmetric Key Encryption
Data is encrypted using a special key and any machine that have the special key have the ability to decrypt the data and read it. This is the cons of  Symmetric Encryption

### Asymmetric keys Encryption
- Data is Encrypted using the public and private key. 
- Only the owner of the private key can decrypt the data. Data can be send using the public key and only the owner that has the private key can decrypt the data. 
- Here public key is available for everyone.
- Data encrypted can be see by everyone but only the owner of the private key can decrypt the data and read.

### Installing OpenSSL
It is installed in windows and Mac by default

### Generate RSA key
- This will generate a private key
- aes256: this will add encryption
```s
openssl genrsa -aes256
openssl genrsa -aes4096
```
-----BEGIN RSA PRIVATE KEY-----
Proc-Type: 4,ENCRYPTED
DEK-Info: AES-256-CBC,967C50FF228A996A6FA1EE75935462C7

SL0JXDfoyqavsFFhgn6iYr/AlMRI+Wgx0eGWEcI9euv9faafwzN4tcrlGgic7R3Y
etcE2iyHEdJFvWK88uVfP4wwrNrm1nJroTTKX6Fjsay/+UOnP3ro5fx2u9DlOA4L
UTgk2jSrKrU8Os7DbE4vfsNqgS1RzIyPY3r5xF4+5AW4ICjCJmwYOQqj2nX6iB+e
SC8au/4lSnVzWD6c2EXVheZNcjoycEIgmHrOR2wh0j6BGKCvioDAjcKLVtowOWg2
RdLdoaqFJZVwQ4Z6zfo5dLItO6Qgv7ew3AAn6f6n98BZ4CyDDLF8Ivn/XodNqsSV
CLIoMUJ8VXr9sH8ezlvE9BnwQrrqATfT/QEFzeWVlt4cRmUTlUi81Xe8PhQzeHtm
79IpF3runFf2qIerCkGiZYMfPdYpiz5FAhzIDK0C9MUNBJloje4IEaDOTE55XObh
HWJQEtulPa0hxPI1eFr9OB6lXDEW2UZg42Tg1HNxbOzsUpS+0M2iJOElGvnvT5ua
v5wYehj4W5lezPSceCI5E3yJN91bLuVLrmfmTX99BNkOs00QdcLaWAqErCEJGVv7
AS00nNch8Ly6Gv2NHtH9JjU8Z5X7PVCq8NesH10/WECOsvMAXq/YJZgRmMMAWli6
WXHOSzp1HskjRG98yhqqIzyhdf+bQdH0++bMQijqQMwRuwWdSqaxg883yKzMYKkG
5cJC4B90o/kp5otXIdGNrN1szj7kmSjl/QAFIqo5+BUEOmRMJV1D9lbOtlM+VSd7
pbNOF1KRaLCUE+O/xn4XhkvXa05c1MUeWx/bh/tjrdZHhesMMmT3CQWyP8tm4HeY
yZtwAqQk36qksSHTpMP12Xti4GqJkrLzlTMYztvfGCGTNX5xubVcmOvXKl4AVoVi
UBl/QiwcL2Vq5klbqQMa/RI1GE1ER8tYpHdSHplUfFWYIeEJJwamDDOFP030RffG
jCNO+YoPF0+fzIlQAWw/wHyhldw5qTv2AsMQF6TTptCxabgwG3Jj3kokFpB8ojhZ
MXv5LGYL1ZoTa+b/08H6WMy1GDb6JdycKSV5gq68YE350aGAi4sv6mOwTsS2cYDG
ACnl57kkzU4izy+olWvy16Ithu1HgULKs9sUU2lctENf6K5TycobrBoc4ZRM10z3
p1WBdna5NzP8g1MALugva3nrcCF+QsOt86v57RgFmI96OER6nFtalXmwTtNCeQg1
rxA/AP/8KsrL/rwxOdPMXQdbyn7SdWnKs8lSGxPSUVg7jIqq5GhjiB+JfJ6K0iGM
kYt1vNDbCHidbRzTUZW+PUZYGy3n1gpFetmX4TYtrcAEb9hicrsss3K+WA9kZMA7
YWli6C22hkB940Pv+tktZ6W+3TfM41w2W+tnddc30on/tRC/YqfcGmiKKjok4C0F
XUJ+dc1pvwvoppx1qp5gjD1QvYq2F+dYAJOjPf72YL84VMO7f2KkMO6eDAWR8onW
/qybOsVyjYyLq9EYs26t0yRiZzYtJcR8c+gvJ2lht+QxDUviTpEqdBHI4/P4BGgz
M3xMC4drBmZ+gd6SrRFsXAg8Ef/rWxGF9YYKOScRFForLLv7mSgaqu/1AgVnON4O
-----END RSA PRIVATE KEY-----

### Generate a private key and store in the file 
**NB:** public key is also incoded in the private key
```s
openssl genrsa -aes256 -out private.pem
cat private.pem
```
```
-----BEGIN RSA PRIVATE KEY-----
Proc-Type: 4,ENCRYPTED
DEK-Info: AES-256-CBC,F9EE735CC78CF6BF5E24156843D37B8C

oZqWLeUHsT2+V4MzlvdyHl1tgvEW8uWq6qYl4YeqTuSOta859FLkLXyNlDJPA9bD
/F52ecg02UcIhxgz9sXu3+Hik8db5PIIsefEgwSZsP0lYX2yGluObGgVtlIVq5M3
QUOyiJbgK62DuO8XCs3S8auzbBIUMuksUg1folCOmlD87/xPpVM+STKHZrTdAsdZ
fyxMGTPbN+1xeX5ooSTNH2r2EKp6TRFORAaWj5r4HbvyVs0bxx30OI/TX/pV/cAC
J/Q5yVcp3d4dlsmP8fBfTjhIpzZ2s5r9pwPx6w39y3LC627M3mwe3QVio91PdIyf
u4G+6k0QSGwk3JEn4ctjQ6vrVeXq4YV7s0SP8DbKv4ynhm4kgFHkEZ0I8XIGFR7c
6+Lv6Zd/+h49b0R6sQZf1v2IdO0Xni/+DQDjizuackcPTVO+9CJDsbRvFHJntp3k
xF+6ij7YBJVsERV5nTnG60xc1en35a5VK609JmXY8noM3aQGC2k7Z/7m2avHp62m
yNzwmWOWSpdw3nSACOE/pozAGs3Ea6aJgrqEtJse57puNBaNjnlnHrmG9ZfEEDfw
wrVjqpw396g302qGos7HX2qas4yNe/0AbQ76ZUo1EF+U4g4VAeIGPq5gOsbaDw1g
esLOa3jinDe22uWDY4JJkaHAiB8oolN6hOgE1hZC0WpxdmCvNd+oN8iYX72UUits
YN2porlcxFH7Qc5QHZlGV6snST9keStFtcM2bUjTsH/K0EWRyOFuKB6xE1SgaVAX
bhu4Uqj2nBgZo+Ci7dzZlaCBTOn8tyDp7KJgQh5nuxilneKSQapaRJ1OTnKL5HE2
x6/hB8tXB1o3dokAq23f0C2KQg4MDvi2OVzxrA6MRls7tyreVuPdxb9JCIsGEDJI
2NVQ2r3YuiPTZNb+qiwsJ/2Luqtv2iKystZBoBVr5RKxvED+y+5nGI4T+awSVdkq
lJfBgljKuQ47pC+gLVLnqookrzhyNPfT4ebz4QzyUSLw+S5mM0omQz9bK342qOUP
/OS8yV6uNlMOe+svl9bVNYsIkJ3hdDSn+r5VlZ5QR/5zaPydWHW5xOE8n/7YgE73
BjGLtSL3wZieQYyHRZ5g88YMi8V2DTy8wpJmTN7rKgHPAuKm+LOxEr1DN7VBDrYV
ytRf7QbJEjjd13AGQB40u1BRa5/LDdY3e6Zkzs2O9ypQViP7NbJWGH6mG0/2EV1X
8+BvHX/o2h2xXaEPxnWdtRVRLEa2ChFm+dgx/V8bKVlHd++ly6tK4F8rwqbHfxO4
ERfEpEr8hhkrApHHGvQ+5F902nyZI51qWdTjWIacdVovT7iNJZ0CRGYQLbjhCnKk
ur0zZqGwgJk0arXCDOP6X0ALly0ykVTe18iFBcWHS0020NQXG0xvX53IpYGPKl3y
sCdgTd1lcMJchZHtOvokfOuayC5g+maTvQgj4Pd41MCqaudD7YKAzBhQPzHyp2zN
r3KGWgKHEavT+i1cWOKfpeqnRLwj5SZ3ICM7dEGAGScyMGnDX2gIYPv/d7jD4AHb
xX0eHomQimm1Tps44CXITpBSeo992/iGGWisyEIdwATduMq5s0XTlVU1EXwgRBp9
-----END RSA PRIVATE KEY-----
```

### Extract the public key from the private using the passphrase
this will extract the public key from `private.pem` and store it in `public.pem`
```
rsa -in private.pem -outform PEM -pubout -out public.pem
cat public.pem
```
```
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxk4Xjwgb7F+IEXDq/6dt
T6MmtOaaWIvKywEoILzi/Mh5l+DKuR5R2GqF8x6eFD7wc26btO7o7BnrFM5exZwc
CV7Hg4gkIVQumfk/zyISIINNRdJSQdT7Yv4IvgsgmAXqeWgT+6UJMCs4/mjmOyMS
9bFGAU8zGoXw/IEFKz9GYDSlcMpleXQhoCIF/M8ydWYrYc2FP/wF+5x1Op+kYBMe
KXjUxvrkkWO9H8k+uBnIlc6BqcqNoIajGx8jTXVIqAEog1Q1PQDFpY8XX+h19rrZ
Gjs+qNyXtzkX1saXGFgkzkbVxlkzwvFtdDTDb6QNzLFpw4oeQdWcPVNjVCiRN59c
owIDAQAB
-----END PUBLIC KEY-----
```

### Generate 4096 bit RSA key
```s
openssl genrsa -out mykey.pem 4096 
openssl rsa -in mykey.pem -pubout > mykey.pub 
```
```
cat mykey.pem

-----BEGIN RSA PRIVATE KEY-----
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
-----END RSA PRIVATE KEY-----
```

```
cat mykey.pub

-----BEGIN PUBLIC KEY-----
MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwxA4jq6CSyQlFXhvFQX3
OOQjcJUml8UvA3+Ly/bgTPi+z3xrchHhPtnuoS02jPWh9q0oRstRA7KG9QK1vral
vLzTuZO1CfMowd85M7PlMa29O6753h05kJXCjgELLZoUPrci+P6cpatHoucBEpS8
CeX+uoS8PAohInEK4BH0bFe2mRisXS5a7XFhTlOy+FkK0ujoXU5ARqSZwClW7Do5
2ZhS/7MFrN5kBfJjVrtzPTfrJoXdejj5DsR60px8n/yzLNwQ8dKAqDC/hTOKwUMX
zs7nXX1w/3lypxSpIFHz7zrztshuhnQQiiHTlGaIO0BsK++Hnu71rNrXnJKXsgMA
oCCQHJQoj/pvlw2CNthkBVR9CFhPg5IoJWqqhtspjLiDzGVJ0sPnp2VKo2yGj2SX
uLJxx+ye0fRx+kEi+5HOx7jRPflXTHnv/YAVAKKEGlEx0AzhIz9rRnNlUUeWIyB3
dzh7+uG86qDQu/bR3XMgbDiHAvEM8uXv/bqLmNaC5x/CLx8MtZA7VSr5VYtSzO+F
brN2vP4PE9ZDXiSmTUr7V+K+vvDcUt1aMUH5xzkpFJCz7YdeTHknJxBNECXiibAH
0BgLInWrBp2SGhKt7RhZn9C0dSh7MpthoPORGXWoGTQ9qRl71k+vlbfYQdKD2tDQ
0xsfElbnH2uZwKPZ+5NxmIsCAwEAAQ==
-----END PUBLIC KEY-----
```

### Create github website using github.com sub dowmain
1. create a repository with `username.github.io`
2. put you web content it and access it through the we browser
3. Example: `leonardtia1.github.io` or `leonardtia1.github.com` or `leonardtia1.githubusercontent.com`
4. Link to access you website: `https://leonardtia1.github.io/`

```
DNS Name=www.github.com
DNS Name=*.github.com
DNS Name=github.com
DNS Name=*.github.io
DNS Name=github.io
DNS Name=*.githubusercontent.com
DNS Name=githubusercontent.com
```

### Generate letsencrypt certificates
- certbot [here](https://certbot.eff.org/)
- letsencrypt [here](https://letsencrypt.org/)
- SSL For Free [here](https://www.sslforfree.com/)


### Configuring NGINX web server and installing TLS certificate
- Install Nginx on Ubuntu 20.04 [here](https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-20-04)


## Nexus config
```sh
events {
}

http {
  proxy_send_timeout        120;
  proxy_read_timeout        300;
  proxy_buffering           off;
  keepalive_timeout         5 5;
  tcp_nodelay               on;

  ssl                       on;
  ssl_certificate           /etc/nginx/external/nexuscert.crt;
  ssl_certificate_key       /etc/nginx/external/nexuskey.pem;

  client_max_body_size      0;

  map $upstream_http_docker_distribution_api_version $docker_distribution_api_version {
    '' 'registry/2.0';
  }

  server {
    listen 443 ssl;

    location / {
      proxy_pass            http://nexus-repo:8081/;
      proxy_set_header      Host $host;
      proxy_set_header      X-Real-IP $remote_addr;
      proxy_set_header      X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header      X-Forwarded-Host $server_name;
      proxy_set_header      X-Forwarded-Proto $scheme;
    }
  }

  server {
    listen 6666 ssl;

    location / {
      proxy_pass            http://nexus-repo:5555/;
      proxy_set_header      Host $http_host;
      proxy_set_header      X-Real-IP $remote_addr;
      proxy_set_header      X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header      X-Forwarded-Host $server_name;
      proxy_set_header      X-Forwarded-Proto $scheme;
    }
  }

  server {
    listen 7777 ssl;

    location / {
      proxy_pass            http://nexus-repo:4444/;
      proxy_set_header      Host $http_host;
      proxy_set_header      X-Real-IP $remote_addr;
      proxy_set_header      X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header      X-Forwarded-Host $server_name;
      proxy_set_header      X-Forwarded-Proto $scheme;
    }
  }
}
```