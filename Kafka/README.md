
# apache-kafka-course
This repository is for the Apache Kafka Course

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