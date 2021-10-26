

```yml
version: "3"
services:
  zookeeper:
    image: 'bitnami/zookeeper:latest'
    container_name: zookeeper
    ports:
      - '2181:2181'
    environment:
      - ALLOW_ANONYMOUS_LOGIN=yes
  kafka:
    image: 'bitnami/kafka:latest'
    container_name: kafka
    ports:
      - '9092:9092'
    environment:
      - KAFKA_BROKER_ID=1
      - KAFKA_LISTENERS=PLAINTEXT://:9092
      - KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://127.0.0.1:9092
      - KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181
      - ALLOW_PLAINTEXT_LISTENER=yes
    depends_on:
      - zookeeper 
```

docker-compose up -d


docker exec -it kafka /bin/sh

kafka-topics.sh --create --zookeeper zookeeper:2181 --replication-factor 1 --partition 1 --topic news

kafka-topics.sh --create --zookeeper zookeeper:2181 --replication-factor 1 --partition 1 --topic order

kafka-topics.sh --list --zookeeper zookeeper:2181