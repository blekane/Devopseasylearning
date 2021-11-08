

docker network create redis -d bridge
# docker build -t redis-client:v1.1.0 -f app.Dockerfile .
docker build -t redis:sentinel -f sentinel.Dockerfile .
docker build -t redis:6.2.1 -f redis.Dockerfile .

docker-compose -f master.docker-compose.yml down  --remove-orphans  
docker-compose -f slave1.docker-compose.yml down  --remove-orphans  
docker-compose -f slave2.docker-compose.yml down  --remove-orphans  
docker-compose -f sentinel.docker-compose.yml down  --remove-orphans 

docker-compose -f master.docker-compose.yml up  -d
# sleep 5
docker-compose -f master.docker-compose.yml ps

docker-compose -f slave1.docker-compose.yml up  -d 
# sleep 5
docker-compose -f slave1.docker-compose.yml ps

docker-compose -f slave2.docker-compose.yml up  -d  
# sleep 5
docker-compose -f slave2.docker-compose.yml ps
