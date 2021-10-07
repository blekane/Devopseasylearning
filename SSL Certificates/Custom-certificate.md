# Getting and installing custom certificate

## BUY SSL CERTIFICATES
FREE Trials — try any SSL for 30 days, no credit card required. How it works. [here](https://www.ssls.com/?gclid=CjwKCAjwtfqKBhBoEiwAZuesiOQtqlAKC1DSTjQerAFKyg0XBy2qrOTT7dAoTYMLq_YIHfQQQbWSlhoCsmsQAvD_BwE)

Cloudflare Free SSL/TLS [here](https://www.cloudflare.com/ssl/?_bt=&_bk=&_bm=&_bn=x&_bg=&_placement=&_target=&_loc=9027665&_dv=c&awsearchcpc=&gclid=CjwKCAjwtfqKBhBoEiwAZuesiAXSTNXMMfupG60JbGOZT0b-5AS0hZq9F1UL8jKt9E_yonwzgTZKeBoC8g8QAvD_BwE&gclsrc=aw.ds)

### Create a certificate self-signed request (CSR)

**NB:** Web browser do not thrust self-signed SSL certificate

You can also add `-nodes` (short for no DES) if you don't want to protect your private key with a passphrase. Otherwise it will prompt you for "at least a 4 character" password.

Also, you will not add `ssl_password_file   /etc/ssl/passphrase.pass;`in your configuration if you add `-nodes`

The days parameter `(365)` you can replace with any number to affect the expiration date. It will then prompt you for things like "Country Name", but you can just hit Enter and accept the defaults.
```
openssl req -x509 -newkey rsa:4096 --nodes -keyout anomicatech.com.key -out server.csr -days 365
```