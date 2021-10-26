
# Apache-kafka

### What is Apache Kafka
- Apache Kafka is distributed publish-subscribe messaging system
- Yotube is a public subscribes system like Kafka
- Repository [here](https://github.com/bstashchuk/apache-kafka-course)

### Apache Kafka Brokers
- They store messages
- Publisher send messages to the broker
- Subscribe read messages from the broker
- Brokers store messages, serve publishers and subscribers
- Publisher are called producer. They produce messages the broker and subscribers are called consumers. They consume messages from brokers
![](/images/ka1.JPG)
![](/images/ka2.JPG)

### Broker cluster
- If there are multiple producers and multiple consumers they are able to interact with different blockers
- every single producer may send messages to different Kafka brokers and every Kafka blocker will store part of the messages so it means that all messages from producers will be spread among different server servers in the cluster
- consumers may read messages from different Kafka brokers also if one of the brokers fails, other brokers will take over it and continue operation of entire cluster
- how those blockers synchronize between each other, how they talk to each other, how they agree, how to distribute workload and so on, that's where Zookeeper comes in.

![](/images/ka3.JPG)

### Zookeeper
- KAfka need Zookeeper to start
- Zookeeper was developed by Apache kafka
- It distribute all config to brokers in the system when you create it
- a cluster of Zookeeper is call ensemble
![](/images/ka4.JPG)

### Zookeeper ensemble
- This is the cluster if Zookeepers
- Quorun: this is the minimum quantity of the servers that shoulb up and running in orther to form operational cluster
- If they are less server than Quorun, Zookeeper cluster is considere down and kafka cluster will be down also

### Zookeeper Quorum [here](https://medium.com/@akash.d.goel/zookeeper-quorum-7916e342faf6)
It’s basically the minimum number of server nodes that must be up and running and available for client requests
![](/images/ka5.JPG)


https://www.youtube.com/watch?v=XzypROJqDIM











# Apache Kafka Installation on Ubuntu

Java is a requirement to start any Apache Kafka

- [Downlaod Apache Kafka Link](https://kafka.apache.org/downloads)
- Please download Scala 2.12  - kafka_2.12-2.8.0.tgz 

```
apt-get update
apt install openjdk-11-jdk -y
java -version

mkdir kafka && cd kafka
apt  install curl -y
curl https://mirrors.advancedhosters.com/apache/kafka/2.8.0/kafka_2.12-2.8.0.tgz -o kafka.tgz
tar -xvzf kafka.tgz --strip 1
rm -rf kafka.tgz
```

## Observing contents of the Kafka folder
- `ls bin`: this directory content executable scripts for Linux/Unix OS
- `ls bin/windows/`: this directory content executable scripts for Windowns OS
- `cat config/zookeeper.properties`: this file is used to start Zookeeper service
- `cat config/producer.properties`: this file is used to start producer service
- `cat config/server.properties`: this file is used to start kafka service or kafka broker
- `ls site-docs`: this directory content kafka version

## Install Vs Code to edit those files
```
snap install --classic code
```

## Trying to start Kafka Server without starting Zookeeper
To start kafka server, we need the script and the configuration at the same time
```
bin/kafka-server-start.sh config/server.properties
```

we will the below error message because when we try to start kafka, it tries to connect to Zookeeper first. This means Zookeeper is mandatory for Kafka to start
```
INFO Connecting to zookeeper on localhost:2181 (kafka.server.KafkaServer)
INFO Socket error occurred: localhost/127.0.0.1:2181: Connection refused (org.apache.zookeeper.ClientCnxn)
```

## Starting Zookeeper
```
bin/zookeeper-server-start.sh config/zookeeper.properties
```

Zookeeper is listining to `2181`
```
INFO binding to port 0.0.0.0/0.0.0.0:2181 (org.apache.zookeeper.server.NIOServerCnxnFactory)
```

## Starting Kafka Server while Zookeeper is up and running
```
bin/kafka-server-start.sh config/server.properties
```



