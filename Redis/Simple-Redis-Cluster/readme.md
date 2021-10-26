## Example 6-Node Redis Cluster Configuration [here](https://www.youtube.com/watch?v=ScsWSeJoq2E) and [here](https://www.youtube.com/watch?v=N8BkmdZzxDg&t=219s)
- GitHub Repo with src code for setting up a Redis Cluster [here](https://github.com/asoorm/redis)
- Redis cluster tutorial [here](https://redis.io/topics/cluster-tutorial)

1. Provision machine which are able to speak with each other (or run all locally)
2. Install Redis Server on each of them [here](https://redis.io/download)

```sh
## Redis installation on Ubuntu
apt-get update
apt-get install build-essential tcl -y
mkdir redis && cd redis
wget https://download.redis.io/releases/redis-6.2.6.tar.gz
tar xzf redis-6.2.6.tar.gz
cd redis-6.2.6
# make
make install # This will allow you to start redis server and cli from anywhere instead of src/redis-server and src/redis-cli

## To start the redis server
redis-server
## To connect to a server
redis-cli
```
3. Start redis servers on each machine and ensure that you pass config file to each

```
redis-server node1.conf
redis-server node2.conf
redis-server node3.conf
redis-server node4.conf
redis-server node5.conf
redis-server node6.conf

```
4. Create cluster by using redis-trib.rb ruby script
cluster-replicas 1 = This I want to have 1 replica for each master

```
redis-cli --cluster create --cluster-replicas 1 127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005 127.0.0.1:7006

OR

./redis-trib.rb create --replicas 1 127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005 127.0.0.1:7006
```
```s
root@ubuntu:~/redis# redis-cli --cluster create --cluster-replicas 1 127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005 127.0.0.1:7006
>>> Performing hash slots allocation on 6 nodes...
Master[0] -> Slots 0 - 5460
Master[1] -> Slots 5461 - 10922
Master[2] -> Slots 10923 - 16383
Adding replica 127.0.0.1:7005 to 127.0.0.1:7001
Adding replica 127.0.0.1:7006 to 127.0.0.1:7002
Adding replica 127.0.0.1:7004 to 127.0.0.1:7003
>>> Trying to optimize slaves allocation for anti-affinity
[WARNING] Some slaves are in the same host as their master
M: 276a562e6c6cf6c009e7c8894e08f8c185f69bf9 127.0.0.1:7001
   slots:[0-5460] (5461 slots) master
M: 414ea4be3e11b06b0b5a4df9ec6048ba3cb7c5c8 127.0.0.1:7002
   slots:[5461-10922] (5462 slots) master
M: 5371a97d9d99ad6e512b093fbc71f7b7827605bc 127.0.0.1:7003
   slots:[10923-16383] (5461 slots) master
S: 40efcab77587f00a8ccea120d936519cc10bea6a 127.0.0.1:7004
   replicates 414ea4be3e11b06b0b5a4df9ec6048ba3cb7c5c8
S: 9a55b7a7e25c866044be48fab7f7f98decb183de 127.0.0.1:7005
   replicates 5371a97d9d99ad6e512b093fbc71f7b7827605bc
S: a2db93d361280d2a9c7756a21796986748f73395 127.0.0.1:7006
   replicates 276a562e6c6cf6c009e7c8894e08f8c185f69bf9
Can I set the above configuration? (type 'yes' to accept):
```

## You will need to type `yes` to accept the cluster configuration

```s
>>> Nodes configuration updated
>>> Assign a different config epoch to each node
>>> Sending CLUSTER MEET messages to join the cluster
Waiting for the cluster to join
.
>>> Performing Cluster Check (using node 127.0.0.1:7001)
M: 276a562e6c6cf6c009e7c8894e08f8c185f69bf9 127.0.0.1:7001
   slots:[0-5460] (5461 slots) master
   1 additional replica(s)
M: 414ea4be3e11b06b0b5a4df9ec6048ba3cb7c5c8 127.0.0.1:7002
   slots:[5461-10922] (5462 slots) master
   1 additional replica(s)
M: 5371a97d9d99ad6e512b093fbc71f7b7827605bc 127.0.0.1:7003
   slots:[10923-16383] (5461 slots) master
   1 additional replica(s)
S: 9a55b7a7e25c866044be48fab7f7f98decb183de 127.0.0.1:7005
   slots: (0 slots) slave
   replicates 5371a97d9d99ad6e512b093fbc71f7b7827605bc
S: a2db93d361280d2a9c7756a21796986748f73395 127.0.0.1:7006
   slots: (0 slots) slave
   replicates 276a562e6c6cf6c009e7c8894e08f8c185f69bf9
S: 40efcab77587f00a8ccea120d936519cc10bea6a 127.0.0.1:7004
   slots: (0 slots) slave
   replicates 414ea4be3e11b06b0b5a4df9ec6048ba3cb7c5c8
[OK] All nodes agree about slots configuration.
>>> Check for open slots...
>>> Check slots coverage...
[OK] All 16384 slots covered.
```
M = master or primary
S = slave or replica

### Let connect 
-c = cluster mode
```
redis-cli -p 7001 -c 
redis-cli -p 7002 -c 
redis-cli -p 7003 -c 
redis-cli -p 7004 -c 
redis-cli -p 7005 -c 
redis-cli -p 7006 -c 
```

### Check cluster slots
```s
127.0.0.1:7001> CLUSTER SLOTS
1) 1) (integer) 0
   2) (integer) 5460
   3) 1) "127.0.0.1"
      2) (integer) 7001
      3) "276a562e6c6cf6c009e7c8894e08f8c185f69bf9"
   4) 1) "127.0.0.1"
      2) (integer) 7006
      3) "a2db93d361280d2a9c7756a21796986748f73395"
2) 1) (integer) 5461
   2) (integer) 10922
   3) 1) "127.0.0.1"
      2) (integer) 7002
      3) "414ea4be3e11b06b0b5a4df9ec6048ba3cb7c5c8"
   4) 1) "127.0.0.1"
      2) (integer) 7004
      3) "40efcab77587f00a8ccea120d936519cc10bea6a"
3) 1) (integer) 10923
   2) (integer) 16383
   3) 1) "127.0.0.1"
      2) (integer) 7003
      3) "5371a97d9d99ad6e512b093fbc71f7b7827605bc"
   4) 1) "127.0.0.1"
      2) (integer) 7005
      3) "9a55b7a7e25c866044be48fab7f7f98decb183de"
127.0.0.1:7001> 
```

### Check cluster info
```s
127.0.0.1:7001> CLUSTER INFO
cluster_state:ok
cluster_slots_assigned:16384
cluster_slots_ok:16384
cluster_slots_pfail:0
cluster_slots_fail:0
cluster_known_nodes:6
cluster_size:3
cluster_current_epoch:6
cluster_my_epoch:1
cluster_stats_messages_ping_sent:2229
cluster_stats_messages_pong_sent:2266
cluster_stats_messages_sent:4495
cluster_stats_messages_ping_received:2261
cluster_stats_messages_pong_received:2229
cluster_stats_messages_meet_received:5
cluster_stats_messages_received:4495
127.0.0.1:7001> 
```