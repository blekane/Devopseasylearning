## Redis Overview
- it is a key value data store
- it store all the data in memory 
- it is fast and can handle multiple requests from multiple clients
- it open source
- It a NOSQL DB
- it store user session state
- support clusrering and high availability
- it read data from the disk instead of reading it from memory
- Replication: data is in sync with redis nodes and master
- high availability: a node can be promote to master when the master is down

## Links
- Installing Redis on Linux Using a Package Manager [here](https://www.itpanther.com/installing-redis-on-linux-using-a-package-manager/)
- Redis Persistence Documentation [here](https://redis.io/topics/persistence)
- Redis configuration documentation [here](https://redis.io/topics/config)

https://github.com/cpapidas/docker-compose-redis-cluster


## What is Redis Cluster
- It horizontall scalable. This means we can add more nodes as we need more capacity 
- Auto data sharding: It sync data automatically amount the nodes
- It is fault tolerant. This means we can loose a node or server can go down and we still continue operating and no data is lost.
- New nodes eventually becoume aware to all nodes in the cluster through **gossip**
![](/images/redis17.JPG)

## Data conistency in Redis Cluster
- A replicas takes over when the master goes down
- The client is configured to talk only to the master node in the cluster. This means read and write operation only go to the master
**- AOF = appendonly file:** This is written every single time that you send a write command to redis cluster. If redis ever recieve a write command, it append it in this file. this is the file that stay up to day as it can wit all the command that are coming in to this instance. NB: This file is a little be large because if you send the key multiple time, it will have multiple copy of that key.
![](/images/redis11.JPG)

**- RDB (Redis Database) file** : The RDB persistence performs point-in-time snapshots of your dataset at specified intervals and store it into a dump file. We can mount it to persist the data.

**NB1:** this is also great for backup. We can copy the dum into a storage

**NB2:** The downside of RDB is that when you do an **RDB save** on the node, we will have a performance degradation for anyone who is talking to that node. **It is recommend to do the RDB SAVE only on the SLAVE with the cron job every hour and not on the master so that we will not interupt the master who is taking the client request.**

**- RDB + AOF:**  It is possible to combine both AOF and RDB in the same instance. Notice that, in this case, when Redis restarts the AOF file will be used to reconstruct the original dataset since it is guaranteed to be the most complete.

![](/images/redis12.JPG)

## Cluster manager and maintenance of the master
- The first thing we need to do is the failover this master instance so in this case A2 become master and A1 a replica 
![](/images/redis13.JPG)

- The second thing we need to do is remove A1 from seed notes. The seed  are what are exposed to our clients. So we need to cut off client from knowing about node A1 

- Next we need to ask the cluster to forget or to evit  A1 from the cluster so that it will no longer taking traffic is no longer part of  voting on things in the cluster 
![](/images/redis14.JPG)

- And finally now it's out of traffic we can finally do maintenance, when we're done doing maintenance we can ask the cluster to merge A1 back into the cluster make it part of it 
![](/images/redis15.JPG)

- And then the important  last step is to add A1  back to the seed nodes so that clients can be exposed to this cluster node.
![](/images/redis16.JPG)


## Redis cinfig file in cluster mode
```sh
port 7001  #port
cluster-enabled yes #start in cluster mode 
cluster-config-file cluster-node-1.conf #to store the configuration of node 1
cluster-node-timeout 5000 # if this node cannot be reach within 5000 millisecond which 5 seconds and the failed over is going to triggle. This means if the node was a master, a slave will take over
appendonly yes 
appendfilename node-1.aof  #AOF file for node-1
dbfilename dump-1.rdb #RDB dump file node-1
```

### Set redis path
```
vim ~/.bash_profile
PATH=$PATH:/root/redis/redis-6.2.6/src
source ~/.bash_profile
```

### Change Redis default port
When we start redis, it start with the default configuration with default port 6379.
```sh
cd redis-6.2 
vim  redis.conf 
#change the default port to 6370
port 6370
wq!
#start redis-server at the background with the configuration file
redis-server redis.conf 
#connect
redis-cli -p 6370
```

### RDB SAVE DEFAULT CONDITION
```sh
save 900 1  #save all the data every 900 seconds if at least one key have been changed
save 300 10 #perform a snapshot every 300 seconds if 10 keys have been changed or added
save 60 10000 #perform a snapshot every 60 seconds if 10000 keys have been changed or added 

#default location is :
dir ./
# it can be change to:
/data
```

```S
#write data
set color blue

#get data
get color

#get all keys
keys *

#delete a key
del blue

#check db data (keys value pair)
dbsize

#take a snapdhot
SAVE
```


## How to recover redis data from snapshot(rdb file) copied from another machine?

https://stackoverflow.com/questions/14497234/how-to-recover-redis-data-from-snapshotrdb-file-copied-from-another-machine





```yml
version: "3.2"
services:
  redismaster:
    image: redis:alpine
    container_name: redismaster
    command: redis-server /etc/redis/redis.conf
    expose:
      - 8080
      - 9090
      - 6379
    restart: always
    volumes:
      - redis-data:/data:rw
      - ${PWD}/redis.conf1:/etc/redis/redis.conf
    environment:
     - REDIS_REPLICATION_MODE=master
     - REDIS_PASSWORD=abc123
    networks:
      main_network:
          aliases:
             - redismaster
  redisslave1:
    image: redis:alpine
    container_name: redisslave1
    command: redis-server /etc/redis/redis.conf
    expose:
      - 8080
      - 9090
      - 6379
    restart: always
    depends_on:
      - redismaster
    volumes:
      - redis-data:/data:rw
      - ${PWD}/redis.conf2-slave-01:/etc/redis/redis.conf
    networks:
        main_network:
          aliases:
            - redisslave1
# networking for the Redis container
volumes:
  redis-data:
networks:
  main_network:

