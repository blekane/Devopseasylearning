## Install Redis Server on Ubuntu [here](https://redis.io/download) and [here](https://www.youtube.com/watch?v=gNPgaBugCWk)

```sh
## Redis installation on Ubuntu
apt-get update
apt-get install build-essential tcl -y
# apt install make -y
mkdir redis && cd redis
wget https://download.redis.io/releases/redis-6.2.6.tar.gz
tar xzf redis-6.2.6.tar.gz
cd redis-6.2.6
make
```
### This will allow you to start redis server and cli from anywhere instead of src/redis-server and src/redis-cli
```
make install 
```

### To start the redis server
```
redis-server
redis-server &
```

### To connect to a server
```
redis-cli
```


