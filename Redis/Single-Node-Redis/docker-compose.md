```yml
version: "3.7"
services:
    redis:
      container_name: redis
      image: aimvector/redis-client:v1.1.0
      build: 
        context: .
        dockerfile: ./application/client
      ports:
        - "80:80"
      networks:
        - redis
        
    node:
      container_name: node-codewithdan
      image: ${DOCKER_ACCT}/node-codewithdan
      build: 
        context: .
        dockerfile: .docker/node-codewithdan.${APP_ENV}.dockerfile
      ports:
      - "8080"
      volumes:
        - .:/var/www/codewithdan
      working_dir: /var/www/codewithdan
      env_file:
        - ./.docker/env/app.${APP_ENV}.env
      depends_on:
        - mongo
        - redis
      networks:
        - codewithdan-network
            
    mongo:
      container_name: mongo
      image: ${DOCKER_ACCT}/mongo
      build:
        context: .
        dockerfile: .docker/mongo.dockerfile
      ports:
      - "27017:27017"
      env_file:
        - ./.docker/env/mongo.${APP_ENV}.env
      networks:
        - codewithdan-network
        
    redis:
      container_name: redis
      image: ${DOCKER_ACCT}/redis
      build: 
        context: .
        dockerfile: .docker/redis.${APP_ENV}.dockerfile
      ports:
        - "6379"
      networks:
        - codewithdan-network

    # cadvisor:
    #   container_name: cadvisor
    #   image: google/cadvisor
    #   volumes:
    #     - /:/rootfs:ro
    #     - /var/run:/var/run:rw
    #     - /sys:/sys:ro
    #     - /var/lib/docker/:/var/lib/docker:ro
    #   ports:
    #     - "8080:8080"
    #   networks:
    #     - codewithdan-network
        
networks:
    codewithdan-network:
      driver: bridge












version: "3.7"
 
services:
    nginx:
      container_name: nginx
      image: ${DOCKER_ACCT}/nginx
      build: 
        context: .
        dockerfile: .docker/nginx.${APP_ENV}.dockerfile
      depends_on: 
        - node
      ports:
        - "80:80"
        - "443:443"
      networks:
        - codewithdan-network
        
    node:
      container_name: node-codewithdan
      image: ${DOCKER_ACCT}/node-codewithdan
      build: 
        context: .
        dockerfile: .docker/node-codewithdan.${APP_ENV}.dockerfile
      ports:
      - "8080"
      volumes:
        - .:/var/www/codewithdan
      working_dir: /var/www/codewithdan
      env_file:
        - ./.docker/env/app.${APP_ENV}.env
      depends_on:
        - mongo
        - redis
      networks:
        - codewithdan-network
            
    mongo:
      container_name: mongo
      image: ${DOCKER_ACCT}/mongo
      build:
        context: .
        dockerfile: .docker/mongo.dockerfile
      ports:
      - "27017:27017"
      env_file:
        - ./.docker/env/mongo.${APP_ENV}.env
      networks:
        - codewithdan-network
        
    redis:
      container_name: redis
      image: ${DOCKER_ACCT}/redis
      build: 
        context: .
        dockerfile: .docker/redis.${APP_ENV}.dockerfile
      ports:
        - "6379"
      networks:
        - codewithdan-network

    # cadvisor:
    #   container_name: cadvisor
    #   image: google/cadvisor
    #   volumes:
    #     - /:/rootfs:ro
    #     - /var/run:/var/run:rw
    #     - /sys:/sys:ro
    #     - /var/lib/docker/:/var/lib/docker:ro
    #   ports:
    #     - "8080:8080"
    #   networks:
    #     - codewithdan-network
        
networks:
    codewithdan-network:
      driver: bridge