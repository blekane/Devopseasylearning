# Nexus

### Install in Ubuntu VM
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
