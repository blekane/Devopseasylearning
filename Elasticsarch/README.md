

deploying Elasticsearch and Kibana with Docker [here](https://quoeamaster.medium.com/deploying-elasticsearch-and-kibana-with-docker-86a4ac78d851)

Deploy Elasticsearch and Kibana in minutes [here](https://info.elastic.co/elasticsearch-service-trial-course.html?ultron=udemy-bo&blade=cpl&hulk=web&gambit=guide-to-es)

Download Elasticsearch on Mac and Linux [here](https://www.elastic.co/downloads/elasticsearch)

Installing Kibana on macOS and Linux [here](https://www.elastic.co/downloads/kibana)

https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html


https://opendistro.github.io/for-elasticsearch-docs/docs/install/docker/

https://quoeamaster.medium.com/deploying-elasticsearch-and-kibana-with-docker-86a4ac78d851

https://github.com/opendistro-for-elasticsearch/opendistro-build/issues/54


https://opendistro.github.io/for-elasticsearch-docs/old/0.9.0/docs/install/docker/
```yaml
version: '3'
services:
  odfe-node1:
    image: amazon/opendistro-for-elasticsearch:0.9.0
    container_name: odfe-node1
    environment:
      - cluster.name=odfe-cluster
      - bootstrap.memory_lock=true # along with the memlock settings below, disables swapping
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m" # minimum and maximum Java heap size, recommend setting both to 50% of system RAM
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - odfe-data1:/usr/share/elasticsearch/data
    ports:
      - 9200:9200
      - 9600:9600 # required for Performance Analyzer
    networks:
      - odfe-net
  odfe-node2:
    image: amazon/opendistro-for-elasticsearch:0.9.0
    container_name: odfe-node2
    environment:
      - cluster.name=odfe-cluster
      - bootstrap.memory_lock=true
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
      - discovery.zen.ping.unicast.hosts=odfe-node1
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - odfe-data2:/usr/share/elasticsearch/data
    networks:
      - odfe-net
  kibana:
    image: amazon/opendistro-for-elasticsearch-kibana:0.9.0
    container_name: odfe-kibana
    ports:
      - 5601:5601
    expose:
      - "5601"
    environment:
      ELASTICSEARCH_URL: https://odfe-node1:9200
      ELASTICSEARCH_HOSTS: https://odfe-node1:9200
    networks:
      - odfe-net

volumes:
  odfe-data1:
  odfe-data2:

networks:
  odfe-net:



https://github.com/quoeamaster/bigdata_blogs/blob/master/es_docker_deploy/docker-compose-single-node.yml

version: '2.2'
services:
  node01:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.11.1
    container_name: node01
    environment:
      - node.name=node01
      - cluster.name=es-cluster-7
      - discovery.type=single-node
      - "ES_JAVA_OPTS=-Xms128m -Xmx128m"
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - es-data01:/usr/share/elasticsearch/data
    ports:
      - 9200:9200
    networks:
      - es-network

  kibana:
    image: docker.elastic.co/kibana/kibana:7.11.1
    environment:
      ELASTICSEARCH_HOSTS: http://node01:9200
    ports:
      - 5601:5601
    networks:
      - es-network
    depends_on:
      - node01

volumes:
  es-data01:
    driver: local

networks:
  es-network:
    driver: bridge



https://quoeamaster.medium.com/deploying-elasticsearch-and-kibana-with-docker-86a4ac78d851
version: '2.2'
services:
  node01:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.11.1
    container_name: node01
    environment:
      - node.name=node01
      - cluster.name=es-cluster-7
      - discovery.seed_hosts=node01,node02,node03
      - cluster.initial_master_nodes=node01,node02,node03
      - "ES_JAVA_OPTS=-Xms128m -Xmx128m"
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - es-data01:/usr/share/elasticsearch/data
    ports:
      - 9200:9200
      - 9300:9300
    networks:
      - es-network

  node02:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.11.1
    container_name: node02
    environment:
      - node.name=node02
      - cluster.name=es-cluster-7
      - discovery.seed_hosts=node01,node02,node03
      - cluster.initial_master_nodes=node01,node02,node03
      - "ES_JAVA_OPTS=-Xms128m -Xmx128m"
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - es-data02:/usr/share/elasticsearch/data
    ports:
      - 9201:9201
      - 9301:9301
    networks:
      - es-network

  node03:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.11.1
    container_name: node03
    environment:
      - node.name=node03
      - cluster.name=es-cluster-7
      - discovery.seed_hosts=node01,node02,node03
      - cluster.initial_master_nodes=node01,node02,node03
      - "ES_JAVA_OPTS=-Xms128m -Xmx128m"
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - es-data03:/usr/share/elasticsearch/data
    ports:
      - 9202:9202
      - 9302:9302
    networks:
      - es-network

  kibana:
    image: docker.elastic.co/kibana/kibana:7.11.1
    environment:
      ELASTICSEARCH_HOSTS: http://node01:9200
    ports:
      - 5601:5601
    networks:
      - es-network
    depends_on:
      - node01

volumes:
  es-data01:
    driver: local
  es-data02:
    driver: local
  es-data03:
    driver: local

networks:
  es-network:
    driver: bridge     