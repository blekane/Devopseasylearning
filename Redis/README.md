

https://github.com/marcel-dempers/docker-development-youtube-series


docker run -it --rm \
--name redis \
--net redis \
-p 6379:6379 \
redis:6.0-alpine


cd .\storage\redis\
docker run -it --rm --name redis --net redis -v ${PWD}/config:/etc/redis/ redis:6.0-alpine redis-server /etc/redis/redis.conf


cd .\storage\redis\

docker run  --rm \
--network redis \
--volume "${PWD}"/config:/etc/redis \
redis:6.0-alpine /etc/redis/redis.conf

cd .\storage\redis\
docker run --rm \
--network redis \
--volume "${PWD}"/config:/etc/redis \
redis:6.0-alpine redis-server /etc/redis/redis.conf


cd .\storage\redis\

docker run -it --rm \
--name redis \
--network redis \
--volume "${PWD}"/config:/etc/redis \
--volume redis:/data \
redis:6.0-alpine redis-server /etc/redis/redis.conf

docker run -it -v ${PWD}:/go/src -w /go/src --net redis -p 80:80 golang:1.14-alpine


docker run -it \
-p 80:80 \
--network redis \
--volume "${PWD}":/go/src \
--workdir /go/src \
--volume redis \
golang:1.14-alpine

