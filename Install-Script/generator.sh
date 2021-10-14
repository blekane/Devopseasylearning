#!/bin/bash

DIR="${HOME}/generator"
USER_SCRIPT=$USER
LOCALHOST_IP=$(ip route get 1.2.3.4 | awk '{print $7}')
# Below variable will print your public IP if your Virtual machine is not in the cloud
CLOUD_PUBLIC_IP=`curl -s ifconfig.me` 

# Fonctions ###########################################################

help_list() {
  echo "Usage of ${0}:

  bash ${0##*/} [-h] -----> For help
  bash ${0##*/} [-a] -----> For api
  bash ${0##*/} [-j] -----> For Jenkins
  And so no

Options:

  -h, --help
    can I help you ?

  -j, --jenkins
    run jenkins container

  -p, --postgres
    run postgres





  -a, --api
    run api for test

  -c, --cassandra
    run cassandra

  -g, --gitlab
    run gitlab

  -gra, --grafana
    run grafana container

  -i, --ip
    list ip for each container

  -k, --kafka
    run kafka with zookeeper

  -m, --mariadb
    run mariadb

  -pro, --prometheus
    run prometheus container
  "
}

options() {
  case $@ in
    -h|--help)
      help_list
      exit
     ;;
     -j|--jenkins)
      jenkins
      ;;


      
    -a|--api)
      api
      ;;
    -c|--cassandra)
      cassandra
      ;;
    -i|--ip)
      ip
      ;;
    -g|--gitlab)
      gitlab
      ;;
    -gra|--grafana)
      grafana
      ;;
    -k|--kafka)
      kafka
      ;;
    -m|--mariadb)
      mariadb
      ;;
    -p|--postgres)
      postgres
      ;;

    -pro|--prometheus)
      prometheus
      ;;

    *)
      echo "Unknown option: ${opt} - Please run 'bash ${0##*/} -h' for help.">&2
      exit 1
  esac
}

jenkins() {

echo
echo "Installing Jenkins"

echo "1 - Create directories ${DIR}/jenkins/"
mkdir -p $DIR/jenkins/

echo "2 - Create docker-compose file"
echo "
version: '3'
services:
  jenkins:
    image: 'jenkins/jenkins:lts'
    container_name: jenkins
    user: 0:0
    ports:
      - '8080:8080'
      - '443:8443'
      - '50000:50000'
    volumes:
      - 'jenkins_data:/var/jenkins_home/'
    networks:
     - generator
volumes:
  jenkins_data:
    driver: local
    driver_opts:
      o: bind
      type: none
      device: ${DIR}/jenkins/
networks:
  generator:
   driver: bridge

" >$DIR/docker-compose-jenkins.yml

echo "3 - Run jenkins "
docker-compose -f $DIR/docker-compose-jenkins.yml up -d

echo "
Getting Jenkins password
docker exec -it [Running Container ID or name] cat /var/jenkins_home/secrets/initialAdminPassword
docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword
"

sleep 5
JENKINS_PPASSWORD=`docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword`
echo "Plase use this password to unlock Jenkins: ${JENKINS_PPASSWORD}"

echo "
Use the below URL to access Jenkins if Jenkins is runing in Vmware or VirtualBox
http://${LOCALHOST_IP}:8080 
"

echo "
Use the below URL to access jenkins if Jenkins is runing in AWS EC2 or Azure
http://${CLOUD_PUBLIC_IP}:8080 
"

echo "Checking running containers:"
sleep 3
docker ps
}





















kafka() {

echo
echo "Installing Cassandra"

echo "1 - Create directories ${DIR}/generator/kafka/"
mkdir -p $DIR/kafka/

echo " 
version: '3.0'
services:
 zookeeper-1:
   image: confluentinc/cp-zookeeper:latest
   environment:
     ZOOKEEPER_SERVER_ID: 1
     ZOOKEEPER_CLIENT_PORT: 22181
     ZOOKEEPER_TICK_TIME: 2000
     ZOOKEEPER_INIT_LIMIT: 5
     ZOOKEEPER_SYNC_LIMIT: 2
     ZOOKEEPER_SERVERS: localhost:22888:23888;localhost:32888:33888;localhost:42888:43888
   network_mode: host
 
 zookeeper-2:
   image: confluentinc/cp-zookeeper:latest
   environment:
     ZOOKEEPER_SERVER_ID: 2
     ZOOKEEPER_CLIENT_PORT: 32181
     ZOOKEEPER_TICK_TIME: 2000
     ZOOKEEPER_INIT_LIMIT: 5
     ZOOKEEPER_SYNC_LIMIT: 2
     ZOOKEEPER_SERVERS: localhost:22888:23888;localhost:32888:33888;localhost:42888:43888
   network_mode: host
 
 zookeeper-3:
   image: confluentinc/cp-zookeeper:latest
   environment:
     ZOOKEEPER_SERVER_ID: 3
     ZOOKEEPER_CLIENT_PORT: 42181
     ZOOKEEPER_TICK_TIME: 2000
     ZOOKEEPER_INIT_LIMIT: 5
     ZOOKEEPER_SYNC_LIMIT: 2
     ZOOKEEPER_SERVERS: localhost:22888:23888;localhost:32888:33888;localhost:42888:43888
   network_mode: host

 kafka-1:
   image: confluentinc/cp-kafka:latest
   network_mode: host
   depends_on:
     - zookeeper-1
     - zookeeper-2
     - zookeeper-3
   environment:
     KAFKA_BROKER_ID: 1
     KAFKA_ZOOKEEPER_CONNECT: localhost:22181,localhost:32181,localhost:42181
     KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://localhost:19092
   ports:
     - 19092:19092
 
 kafka-2:
   image: confluentinc/cp-kafka:latest
   network_mode: host
   depends_on:
     - zookeeper-1
     - zookeeper-2
     - zookeeper-3
   environment:
     KAFKA_BROKER_ID: 2
     KAFKA_ZOOKEEPER_CONNECT: localhost:22181,localhost:32181,localhost:42181
     KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://localhost:29092
   ports:
     - 29092:29092
 
 kafka-3:
   image: confluentinc/cp-kafka:latest
   network_mode: host
   depends_on:
     - zookeeper-1
     - zookeeper-2
     - zookeeper-3
   environment:
     KAFKA_BROKER_ID: 3
     KAFKA_ZOOKEEPER_CONNECT: localhost:22181,localhost:32181,localhost:42181
     KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://localhost:39092
   ports:
     - '39092:39092' 
" >$DIR/docker-compose-kafka.yml

echo "3 - Run kafka"
docker-compose -f $DIR/docker-compose-kafka.yml up -d

echo "4 - Usage"
echo "
Usage :
* create topics : 
     docker run --net=host --rm confluentinc/cp-kafka:latest kafka-topics --create --topic mytopic --partitions 2 --replication-factor 2 --if-not-exists --zookeeper localhost:32181

* insert data :
     docker run --net=host --rm confluentinc/cp-kafka:latest bash -c 'seq 100 | kafka-console-producer --broker-list localhost:29092 --topic mytopic'

* request data :
     docker run --net=host --rm confluentinc/cp-kafka:latest kafka-console-consumer --bootstrap-server localhost:29092 --topic mytopic --from-beginning

"
}

cassandra() {

echo
echo "Installing Cassandra"

echo "1 - Create directories ${DIR}/generator/cassandra/"
mkdir -p $DIR/cassandra/


echo "2 - Create docker-compose file"
echo "
version: '3'
services:
  cassandra:
    image: bitnami/cassandra:latest
    container_name: cassandra
    volumes:
    - cassandra_data:/bitnami
    ports:
    - 9042:9042 # cqlsh
    - 7199:7199 # jmx
    - 7000:7000 # internode communication
    - 7001:7001 # tls internode
    - 9160:9160 # client api
    networks:
    - generator
volumes:
  cassandra_data:
    driver: local
    driver_opts:
      o: bind
      type: none
      device: ${DIR}/cassandra/
networks:
  generator:
   driver: bridge
   ipam:
     config:
       - subnet: 192.168.168.0/24
" >$DIR/docker-compose-cassandra.yml

echo "3 - Run cassandra"
docker-compose -f $DIR/docker-compose-cassandra.yml up -d

echo "4 - Credentials"
echo "
                user: cassandra
                password: cassandra
"
}


gitlab() {

echo
echo "Installing Gitlab"

echo "1 - Create directories ${DIR}/generator/gitlab/"
mkdir -p $DIR/gitlab/{config,data,logs}

echo "
version: '3.0'
services:
  web:
   image: 'gitlab/gitlab-ce:latest'
   container_name: gitlab
   hostname: 'gitlab.example.com'
   environment:
     GITLAB_OMNIBUS_CONFIG: |
       external_url 'https://gitlab.example.com'
   expose: 
   - 5000
   ports:
   - 80:80
   - 443:443
   - 5000:5000
   volumes:
   - gitlab_config:/etc/gitlab/
   - gitlab_logs:/var/log/gitlab/
   - gitlab_data:/var/opt/gitlab/
   networks:
   - generator     
volumes:
  gitlab_data:
    driver: local
    driver_opts:
      o: bind
      type: none
      device: ${DIR}/gitlab/data
  gitlab_logs:
    driver: local
    driver_opts:
      o: bind
      type: none
      device: ${DIR}/gitlab/logs
  gitlab_config:
    driver: local
    driver_opts:
      o: bind
      type: none
      device: ${DIR}/gitlab/config
networks:
  generator:
   driver: bridge
   ipam:
     config:
       - subnet: 192.168.168.0/24
" >$DIR/docker-compose-gitlab.yml

echo "3 - Run gitlab"
docker-compose -f $DIR/docker-compose-gitlab.yml up -d

echo "Add ip of gitlab container and url gitlab.example.com in your /etc/hosts"

}

grafana() {
echo
echo "Installing Grafana"

echo "1 - Create directories ${DIR}/generator/grafana/{etc,data}"
mkdir -p $DIR/grafana/{etc,data}
chmod 775 -R $DIR/grafana/

echo "2 - Create docker compose for grafana"

echo "
version: '3'
services:
  grafana:
    image: grafana/grafana
    container_name: grafana
    user: 0:0
    ports:
     - 3000:3000
    volumes:
     - grafana_data:/var/lib/grafana
     - grafana_etc:/etc/grafana/provisioning/
     networks:
     - generator
volumes:
  grafana_etc:
    driver: local
    driver_opts:
      o: bind
      type: none
      device: ${DIR}/grafana/etc/
  grafana_data:
    driver: local
    driver_opts:
      o: bind
      type: none
      device: ${DIR}/grafana/data/
networks:
  generator:
   driver: bridge
   ipam:
     config:
       - subnet: 192.168.168.0/24
" > $DIR/docker-compose-grafana.yml

echo "3 - Run grafana "
docker-compose -f $DIR/docker-compose-grafana.yml up -d
sleep 10s

echo "4 - Auto setup for local prometheus"
curl --user admin:admin "http://localhost:3000/api/datasources" -X POST -H 'Content-Type: application/json;charset=UTF-8' --data-binary '{"name":"test","isDefault":true ,"type":"prometheus","url":"http://localhost:9090","access":"proxy","basicAuth":false}'

firefox -p test 127.0.0.1:3000

}


prometheus() {
echo
echo "Installing Prometheus"

echo "1 - Create directories ${DIR}/generator/prometheus/{etc,data}"
mkdir -p $DIR/prometheus/{etc,data}
chmod 775 -R $DIR/prometheus/

echo "2 - Create config file prometheus.yml "
echo "
global:
  scrape_interval:     5s # By default, scrape targets every 15 seconds.
  evaluation_interval: 5s # By default, scrape targets every 15 seconds.
  # scrape_timeout is set to the global default (10s).

  # Attach these labels to any time series or alerts when communicating with
  # external systems (federation, remote storage, Alertmanager).
  external_labels:
    monitor: 'codelab-monitor'

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  # - "first.rules"
  # - "second.rules"

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
- job_name: 'node'
  static_configs:
  #- targets: ['172.37.1.1:9100']
" > $DIR/prometheus/etc/prometheus.yml


echo "3 - Create docker compose for prometheus "
echo "
version: '3'
services:
  prometheus:
    image: quay.io/prometheus/prometheus:v2.0.0
    container_name: prometheus
    volumes:
     - prometheus_etc:/etc/prometheus/
     - prometheus_data:/prometheus/
    command: '--config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/prometheus'
    ports:
     - 9090:9090
    networks:
     - generator
volumes:
  prometheus_etc:
    driver: local
    driver_opts:
      o: bind
      type: none
      device: ${DIR}/prometheus/etc/
  prometheus_data:
    driver: local
    driver_opts:
      o: bind
      type: none
      device: ${DIR}/prometheus/data/
networks:
  generator:
   driver: bridge
   ipam:
     config:
       - subnet: 192.168.168.0/24
" > $DIR/docker-compose-prometheus.yml

echo "4 - Run prometheus "
docker-compose -f $DIR/docker-compose-prometheus.yml up -d

firefox 127.0.0.1:9090

}


mariadb() {

echo
echo "Installing Mariadb"

echo "1 - Create directories ${DIR}/generator/mariadb/"
mkdir -p $DIR/mariadb/

echo "2 - Create docker-compose file"
echo "
version: '3'
services:
  mariadb:
    container_name: mariadb
    image: mariadb/server:latest
    volumes:
     - mariadb_data:/var/lib/mysql/
    environment:
      MYSQL_ROOT_PASSWORD: myrootpassword
      MYSQL_DATABASE: mydatabase
      MYSQL_USER: myuser
      MYSQL_PASSWORD: myuserpassword
    ports:
    - 3306:3306
    networks:
    - generator
volumes:
  mariadb_data:
    driver: local
    driver_opts:
      o: bind
      type: none
      device: ${DIR}/mariadb/
networks:
  generator:
   driver: bridge
   ipam:
     config:
       - subnet: 192.168.168.0/24
" >$DIR/docker-compose-mariadb.yml

echo "3 - Run mariadb"
docker-compose -f $DIR/docker-compose-mariadb.yml up -d

echo "4 - Credentials"
echo "
      MYSQL_ROOT_PASSWORD: myrootpassword
      MYSQL_DATABASE: mydatabase
      MYSQL_USER: myuser
      MYSQL_PASSWORD: myuserpassword
"

}

# Let's Go !! and call the option function ####################
options $@
