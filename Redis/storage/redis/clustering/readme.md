## Redis Replication and High Availability 
How to setup a cluster [here](https://www.youtube.com/watch?v=GEg7s3i6Jak&t=950s)
Documentation [here](https://redis.io/topics/replication)
Redis configuration documentation [here](https://redis.io/topics/config)

![](/images/redis1.JPG)

## Redis Persistence Volume
Redis Persistence Documentation [here](https://redis.io/topics/persistence)

**dir "/data":** This is where redis should write ump.rdb and appendonly.aof in the redis container and this will be mounted on the host

### Configuration
- redis 0 is the master here
- slaveof redis-0 6379: This tells the slave where to look for the master and the master port
- masterauth a-very-complex-password-here: This allow slave to connect to the master. We have the same on all the nodes because of high availibity

```sh
# persistence
dir "/data"
dbfilename dump.rdb
appendonly yes
appendfilename "appendonly.aof"

```
### redis-0 Configuration

```sh
protected-mode no
port 6379

#authentication
masterauth a-very-complex-password-here
requirepass a-very-complex-password-here
```
### redis-1 Configuration

```sh
protected-mode no
port 6379
slaveof redis-0 6379

#authentication
masterauth a-very-complex-password-here
requirepass a-very-complex-password-here

```
### redis-2 Configuration

```
protected-mode no
port 6379
slaveof redis-0 6379

#authentication
masterauth a-very-complex-password-here
requirepass a-very-complex-password-here
```
Remember to update above in configs!

## Redis Replication
```sh
#Create a net work because all container have to be in the same network
docker network create redis

# Create a volume 
docker volume create redis
docker volume ls
ls -l /var/lib/docker/volumes/
ls -l /var/lib/docker/volumes/redis/_data

cd .\storage\redis\clustering\

#redis-0
docker run -d --rm --name redis-0 \
    --net redis \
    -v ${PWD}/redis-0:/etc/redis/ \
    -v redis:/data  \
    redis:6.0-alpine redis-server /etc/redis/redis.conf
OR
docker run --network=redis --rm \
    --name redis-0 \
    --volume ${PWD}/redis-0:/etc/redis \
    --volume redis:/data  \
    redis:6.0-alpine redis-server /etc/redis/redis.conf

#redis-1
docker run -d --rm --name redis-1 \
    --net redis \
    -v ${PWD}/redis-1:/etc/redis/ \
    -v redis:/data \
    redis:6.0-alpine redis-server /etc/redis/redis.conf
OR
docker run --network=redis --rm \
    --name redis-0 \
    --volume ${PWD}/redis-1:/etc/redis \
    --volume redis:/data  \
    redis:6.0-alpine redis-server /etc/redis/redis.conf

#redis-2
docker run -d --rm --name redis-2 \
    --net redis \
    -v ${PWD}/redis-2:/etc/redis/ \
    -v redis:/data  \
    redis:6.0-alpine redis-server /etc/redis/redis.conf
OR
docker run --network=redis --rm \
    --name redis-0 \
    --volume ${PWD}/redis-2:/etc/redis \
    --volume redis:/data  \
    redis:6.0-alpine redis-server /etc/redis/redis.conf
```

## Example Application

Run example application to show application writing to the master

```sh
cd .\storage\redis\applications\client\
docker build . -t aimvector/redis-client:v1.0.0

docker run -it --net redis \
-e REDIS_HOST=redis-0 \
-e REDIS_PORT=6379 \
-e REDIS_PASSWORD="a-very-complex-password-here" \
-p 80:80 \
aimvector/redis-client:v1.0.0

OR

docker run --network=redis --rm \
    --env REDIS_HOST=redis-0 \
    --env REDIS_PORT=6379 \
    --env REDIS_PASSWORD="a-very-complex-password-here" \
    -p 80:80 \
    aimvector/redis-client:v1.1.0

## Test the application
http://192.168.2.33/
```

## Test Replication

Technically written data should now be on the replicas

```
# go to one of the clients
docker exec -it redis-2 sh
redis-cli
auth "a-very-complex-password-here"
keys *
```

## Running Sentinels (This is call high availability in redis)

Redis Sentinel Documentation [here](https://redis.io/topics/sentinel)
- Redis Sentinel provides high availability for Redis. 
- In practical terms this means that using Sentinel you can create a Redis deployment that resists without human intervention certain kinds of failures.

**This is the full list of Sentinel capabilities at a macroscopical level** 

**Monitoring.** Sentinel constantly checks if your master and replica instances are working as expected.

**Notification.** Sentinel can notify the system administrator, or other computer programs, via an API, that something is wrong with one of the monitored Redis instances.

**Automatic failover.** If a master is not working as expected, Sentinel can start a failover process where a replica is promoted to master, the other additional replicas are reconfigured to use the new master, and the applications using the Redis server are informed about the new address to use when connecting.

## Basic config of Redis Sentinel
```sh
port 5000
sentinel monitor mymaster redis-0 6379 2
sentinel down-after-milliseconds mymaster 5000
sentinel failover-timeout mymaster 60000
sentinel parallel-syncs mymaster 1
sentinel auth-pass mymaster a-very-complex-password-here
```

## Starting Redis in sentinel mode

```sh
cd ./storage/redis/clustering\

#sentinel-0
docker run -d --rm --name sentinel-0 --net redis \
    -v ${PWD}/sentinel-0:/etc/redis/ \
    redis:6.0-alpine \
    redis-sentinel /etc/redis/sentinel.conf
OR
docker run --network=redis --rm \
    --name sentinel-0 \
    --volume ${PWD}/sentinel-0:/etc/redis \
    --volume redis:/data  \
    redis-sentinel /etc/redis/sentinel.conf

#sentinel-1
docker run -d --rm --name sentinel-1 --net redis \
    -v ${PWD}/sentinel-1:/etc/redis/ \
    redis:6.0-alpine \
    redis-sentinel /etc/redis/sentinel.conf
OR
docker run --network=redis --rm \
    --name sentinel-1 \
    --volume ${PWD}/sentinel-1:/etc/redis \
    --volume redis:/data  \
    redis-sentinel /etc/redis/sentinel.conf

#sentinel-2
docker run -d --rm --name sentinel-2 --net redis \
    -v ${PWD}/sentinel-2:/etc/redis/ \
    redis:6.0-alpine \
    redis-sentinel /etc/redis/sentinel.conf
OR
docker run --network=redis --rm \
    --name sentinel-2 \
    --volume ${PWD}/sentinel-2:/etc/redis \
    --volume redis:/data  \
    redis-sentinel /etc/redis/sentinel.conf

docker logs sentinel-0
docker exec -it sentinel-0 sh
redis-cli -p 5000
info
sentinel master mymaster

# clean up 

docker rm -f redis-0 redis-1 redis-2
docker rm -f sentinel-0 sentinel-1 sentinel-2
```
