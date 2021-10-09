## Docker Private Registry with Nexus [here](https://www.youtube.com/watch?v=nwThFH8Xt8c)
- Nexus Installation Script [here](https://raw.githubusercontent.com/linuxautomations/nexus/master/install.sh). **NB:** the script can only rin on **CENTOS**
- Docker Default Config [here](https://raw.githubusercontent.com/linuxautomations/nexus/master/nginx-default-config.conf)

### Configuration
```
nexus.anomicatech.com
```
```sh
sudo yum install epel-release -y 
yum install nginx -y
systemctl status nginx
systemctl start nginx
cd /etc/nginx && cp nginx.conf /tmp
>nginx.conf

vi server.crt
vi server.key
chmod 600 server.crt server.key
nginx -t
systemctl restart nginx
jenkins.anomicatech.com
nexus.anomicatech.com
```

### Jenkins and nexus behind same nginx reverse proxy [here](https://blog.tentamen.eu/jenkins-and-nexus-behind-same-nginx-reverse-proxy/)