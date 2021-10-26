## bitnami/redis-cluster [here](https://hub.docker.com/r/bitnami/redis-cluster/)

## Docker Compose [here](https://raw.githubusercontent.com/bitnami/bitnami-docker-redis-cluster/master/docker-compose.yml)

curl -sSL https://raw.githubusercontent.com/bitnami/bitnami-docker-redis-cluster/master/docker-compose.yml > docker-compose.yml
docker-compose up -d

```yml
version: '3'
services:
  redis-node-0:
    image: docker.io/bitnami/redis-cluster:6.2
    volumes:
      - redis-cluster_data-0:/bitnami/redis/data
    environment:
      - 'REDIS_PASSWORD=bitnami'
      - 'REDIS_NODES=redis-node-0 redis-node-1 redis-node-2 redis-node-3 redis-node-4 redis-node-5'

  redis-node-1:
    image: docker.io/bitnami/redis-cluster:6.2
    volumes:
      - redis-cluster_data-1:/bitnami/redis/data
    environment:
      - 'REDIS_PASSWORD=bitnami'
      - 'REDIS_NODES=redis-node-0 redis-node-1 redis-node-2 redis-node-3 redis-node-4 redis-node-5'

  redis-node-2:
    image: docker.io/bitnami/redis-cluster:6.2
    volumes:
      - redis-cluster_data-2:/bitnami/redis/data
    environment:
      - 'REDIS_PASSWORD=bitnami'
      - 'REDIS_NODES=redis-node-0 redis-node-1 redis-node-2 redis-node-3 redis-node-4 redis-node-5'

  redis-node-3:
    image: docker.io/bitnami/redis-cluster:6.2
    volumes:
      - redis-cluster_data-3:/bitnami/redis/data
    environment:
      - 'REDIS_PASSWORD=bitnami'
      - 'REDIS_NODES=redis-node-0 redis-node-1 redis-node-2 redis-node-3 redis-node-4 redis-node-5'

  redis-node-4:
    image: docker.io/bitnami/redis-cluster:6.2
    volumes:
      - redis-cluster_data-4:/bitnami/redis/data
    environment:
      - 'REDIS_PASSWORD=bitnami'
      - 'REDIS_NODES=redis-node-0 redis-node-1 redis-node-2 redis-node-3 redis-node-4 redis-node-5'

  redis-node-5:
    image: docker.io/bitnami/redis-cluster:6.2
    volumes:
      - redis-cluster_data-5:/bitnami/redis/data
    depends_on:
      - redis-node-0
      - redis-node-1
      - redis-node-2
      - redis-node-3
      - redis-node-4
    environment:
      - 'REDIS_PASSWORD=bitnami'
      - 'REDISCLI_AUTH=bitnami'
      - 'REDIS_CLUSTER_REPLICAS=1'
      - 'REDIS_NODES=redis-node-0 redis-node-1 redis-node-2 redis-node-3 redis-node-4 redis-node-5'
      - 'REDIS_CLUSTER_CREATOR=yes'

volumes:
  redis-cluster_data-0:
    driver: local
  redis-cluster_data-1:
    driver: local
  redis-cluster_data-2:
    driver: local
  redis-cluster_data-3:
    driver: local
  redis-cluster_data-4:
    driver: local
  redis-cluster_data-5:
    driver: local
```

## Connect

```
docker exec -it root_redis-node-4_1 bash
docker exec -it root_redis-node-0_1 bash
docker exec -it root_redis-node-1_1 bash
docker exec -it root_redis-node-2_1 bash
docker exec -it root_redis-node-3_1 bash
docker exec -it root_redis-node-5_1 bash
```

```sh
root@ubuntu:~# docker ps
CONTAINER ID   IMAGE                       COMMAND                  CREATED         STATUS         PORTS      NAMES
ed15e7b0ee3b   bitnami/redis-cluster:6.2   "/opt/bitnami/script…"   9 minutes ago   Up 9 minutes   6379/tcp   root_redis-node-5_1
0d00838eeb13   bitnami/redis-cluster:6.2   "/opt/bitnami/script…"   9 minutes ago   Up 9 minutes   6379/tcp   root_redis-node-1_1
9403ed9d69fc   bitnami/redis-cluster:6.2   "/opt/bitnami/script…"   9 minutes ago   Up 9 minutes   6379/tcp   root_redis-node-4_1
802a4ca9205d   bitnami/redis-cluster:6.2   "/opt/bitnami/script…"   9 minutes ago   Up 9 minutes   6379/tcp   root_redis-node-3_1
e35aa4c65ad5   bitnami/redis-cluster:6.2   "/opt/bitnami/script…"   9 minutes ago   Up 9 minutes   6379/tcp   root_redis-node-2_1
baa6b87a1523   bitnami/redis-cluster:6.2   "/opt/bitnami/script…"   9 minutes ago   Up 9 minutes   6379/tcp   root_redis-node-0_1
root@ubuntu:~# docker exec -it root_redis-node-5_1 bash
I have no name!@ed15e7b0ee3b:/$ redis-cli
127.0.0.1:6379> 
```

### Run some commands
```
CLUSTER INFO
CLUSTER SLOTS
```