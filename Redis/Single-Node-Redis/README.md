# Redis 
[docker-development-youtube-series](https://github.com/marcel-dempers/docker-development-youtube-series)

[Redis : The Basics for beginners](https://www.youtube.com/watch?v=L3zp347cWNw)

## Docker 
Docker image over [here](https://hub.docker.com/_/redis)

## Running redis

```
docker network create redis
docker run -it --rm --name redis --net redis -p 6379:6379 redis:6.0-alpine

docker run -it --rm \
    --name redis \
    --network redis \
    -p 6379:6379 \
    redis:6.0-alpine

```

## Configuration

Redis configuration documentation [here](https://redis.io/topics/config)

Starting Redis with a custom config. Let overwrite the default configuration of Redis with a custom config
```sh
cd ./storage/redis

# mount the config folder in /etc/redis/ in the container, run redis-server as entry point and start the config in /etc/redis/redis.conf. This means the config file will run when the container start

# By default, when we run Redis, it store all it data in memory. If the container shutdown, you will loose all your data. It very import to mount you data into a file system or to volume 

docker run -it --rm --name redis --net redis -v ${PWD}/config:/etc/redis/ redis:6.0-alpine redis-server /etc/redis/redis.conf

docker run --network=redis --rm \
    --name redis \
    --volume ${PWD}/config:/etc/redis \
    redis:6.0-alpine redis-server /etc/redis/redis.conf

OR

docker run --network=redis --rm \
    --name redis \
    --volume ${PWD}/config:/etc/redis \
    redis:6.0-alpine /etc/redis/redis.conf

# login and check
docker exec -it 5b9eaabfd1fc /bin/sh
docker exec -it 5b9eaabfd1fc ls
docker exec -it 5b9eaabfd1fc ls /etc/redis
```

## Security
Redis should not be exposed to public.
Always use a strong password in `redis.conf`

```
requirepass SuperSecretSecureStrongPass
```

## Persistence

Redis Persistence Documentation [here](https://redis.io/topics/persistence)

Redis provides a different range of persistence options:

**- RDB:** (Redis Database). It provide the highest performance machanism. The RDB persistence performs point-in-time snapshots of your dataset at specified intervals and store it into a dump file. We can mount it to persist the data.

**NB:** this is also great for backup. We can copy the dum into a storage

**- AOF:**  (Append Only File). The AOF persistence logs every write operation received by the serve

**- RDB + AOF:**  It is possible to combine both AOF and RDB in the same instance. Notice that, in this case, when Redis restarts the AOF file will be used to reconstruct the original dataset since it is guaranteed to be the most complete.

**- No persistence:** If you wish, you can disable persistence completely, if you want your data to just exist as long as the server is running.
 

## Run Redis in RDB mode
Search in config file and turn on `dbfilename dump.rdb`. You can also change the part to the dump file.

## Run Redis in AOF mode
Search in config file and turn on `appendonly yes`. You can also specify the file name to write those operation here `appendfilename "appendonly.aof"`

## let run Redis in RDB and AOF mode as we turn them on 
```sh
docker volume create redis
docker volume ls
ls -l /var/lib/docker/volumes/
ls -l /var/lib/docker/volumes/redis/_data

cd ./storage/redis

# NB: We must put --name redis because we will use it to connect to Redis server

docker run -it --rm --name redis --net redis -v ${PWD}/config:/etc/redis/ -v redis:/data/  redis:6.0-alpine redis-server /etc/redis/redis.conf

docker run --network=redis --rm \
    --name redis \
    --volume ${PWD}/config:/etc/redis \
    --volume redis:/data  \
    redis:6.0-alpine redis-server /etc/redis/redis.conf

OR

docker run --network=redis --rm \
    --name redis \
    --volume ${PWD}/config:/etc/redis \
    --volume redis:/data  \
    redis:6.0-alpine /etc/redis/redis.conf

# --volume ${PWD}/config:/etc/redis \ : To mount the config file
# --volume redis:/data \ : to mount the volume in /data inside the container. /data is the default place where redis stores data
# --network redis \ : to run it in redis network
# redis:6.0-alpine /etc/redis/redis.conf : run the redis container and start the config file with entry point
# --rm : remove the container when it is done
```

```sh
root@ubuntu:~/docker-development-youtube-series/storage/redis/applications/client# docker exec -it 5b9eaabfd1fc /bin/sh
/data # ls
appendonly.aof
/data # ls /etc/redis
redis.conf
/data # 
```

## Redis client application

An example application that reads a key from Redis, increments it and writes it back to Redis.

```sh
cd ./applications

# start go dev environment
docker run -it -v ${PWD}:/go/src -w /go/src --net redis -p 8096:80 golang:1.14-alpine

docker run --network=redis --rm \ 
    --volume ${PWD}:/go/src \
    --workdir /go/src \
    -p 8096:80 \
    golang:1.14-alpine

# --volume "$(pwd)":/go/src \ : all data in client dir will be in sync will all data in /go/src
```

## Build the client in the container
```sh
/go/src # ls
client.go   dockerfile  go.mod      go.sum

# Build the client application
go build client.go

## start the app
./client
```

## Build a docker file and start the application
```dockerfile
FROM golang:1.14-alpine as build

RUN apk add --no-cache git

WORKDIR /src 

COPY go.sum /src/
COPY go.mod /src/
COPY client.go /src 
RUN go build client.go
FROM alpine as runtime

COPY --from=build /src/client /app/client
EXPOSE 80
CMD [ "/app/client" ]

# Build the image
docker build . -t aimvector/redis-client:v1.1.0

#Run our application

docker run -it --net redis \
-e REDIS_HOST=redis \
-e REDIS_PORT=6379 \
-e REDIS_PASSWORD="SuperSecretSecureStrongPass" \
-p 80:80 \
aimvector/redis-client:v1.1.0

docker run -it --net redis \
    -e REDIS_HOST=redis \
    -e REDIS_PORT=6379 \
    -e REDIS_PASSWORD="SuperSecretSecureStrongPass" \
    -p 8090:80 \
    aimvector/redis-client:v1.1.0

docker run --network=redis --rm \
    --env REDIS_HOST=redis \
    --env REDIS_PORT=6379 \
    --env REDIS_PASSWORD="SuperSecretSecureStrongPass" \
    -p 8070:80 \
    aimvector/redis-client:v1.1.0

## Test the application
http://192.168.2.33/
http://192.168.2.33:8090/
http://192.168.2.33:8070/
```

