# Nexus

### Install in Docker
[Sonatype Nexus3 Docker: sonatype/nexus3](https://hub.docker.com/r/sonatype/nexus3/)

```sh
docker run -d -p 8081:8081 --name nexus sonatype/nexus3
sudo ufw allow 8080/tcp

# Get the password
docker exec -it [Running Container ID or name] cat /nexus-data/admin.password
docker exec -it nexus cat /nexus-data/admin.password
docker exec -it 96ca9c409aaa cat /nexus-data/admin.password

# Login
http://10.0.0.6:8081/
```

### Install in Ubuntu 

Install Nexus Repository Manager on Ubuntu [here](https://kifarunix.com/install-nexus-repository-manager-on-ubuntu/)
https://kifarunix.com/install-nexus-repository-manager-on-ubuntu/
https://epma.medium.com/install-sonatype-nexus-3-on-ubuntu-20-04-lts-562f8ba20b98

```sh
apt install openjdk-8-jdk
apt update
useradd -M -d /opt/nexus -s /bin/bash -r nexus
echo "nexus   ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/nexus
wget https://sonatype-download.global.ssl.fastly.net/repository/downloads-prod-group/3/nexus-3.29.2-02-unix.tar.gz
mkdir /opt/nexus
tar xzf nexus-3.29.2-02-unix.tar.gz -C /opt/nexus --strip-components=1
ls /opt/nexus
chown -R nexus: /opt/nexus

## open /opt/nexus/bin/nexus.vmoptions
vim /opt/nexus/bin/nexus.vmoptions

## Replace the default values for the lines;
-Xms2703m
-Xmx2703m
-XX:MaxDirectMemorySize=2703m

## To for example, to set it to 1024MB;
-Xms1024m
-Xmx1024m
-XX:MaxDirectMemorySize=1024m

sed -i 's/#run_as_user=""/run_as_user="nexus"/' /opt/nexus/bin/nexus.rc

## open /opt/nexus/bin/nexus.vmoptions and change
-Dkaraf.data=../sonatype-work/nexus3
-Dkaraf.log=../sonatype-work/nexus3/log
-Djava.io.tmpdir=../sonatype-work/nexus3/tmp

## with 
-Dkaraf.data=./sonatype-work/nexus3
-Dkaraf.log=./sonatype-work/nexus3/log
-Djava.io.tmpdir=./sonatype-work/nexus3/tmp

## start nexus
sudo -u nexus /opt/nexus/bin/nexus start
tail -f /opt/nexus/sonatype-work/nexus3/log/nexus.log
netstat -altnp | grep :8081

## Create Nexus Repository Systemd Service
cat > /etc/systemd/system/nexus.service << 'EOL'
[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOL

## reload configuration
/opt/nexus/bin/nexus stop
systemctl daemon-reload
systemctl enable --now nexus.service
systemctl status nexus

## open default port
ufw allow 8081/tcp