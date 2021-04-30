### To stop and delete all containers
for cont in $(docker ps -a |awk '{print$1}'); do docker stop $cont; docker rm -f $cont; done

### Delete all images
for im in $(docker images |awk '{print$3}'); do docker rmi -f $im; done

### Purging All Unused or Dangling Images, Containers, Volumes, and Networks
docker system prune

### To additionally remove any stopped containers and all unused images (not just dangling images), add the -a flag to the command:
docker system prune -a
