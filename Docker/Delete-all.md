### To stop and delete all containers
for cont in $(docker ps -a |awk '{print$1}'); do docker stop $cont; docker rm -f $cont; done

### Delete all images
for im in $(docker images |awk '{print$3}'); do docker rmi -f $im; done

### Purging All Unused or Dangling Images, Containers, Volumes, and Networks
docker system prune

### To additionally remove any stopped containers and all unused images (not just dangling images), add the -a flag to the command:
docker system prune -a


### Script to delete all
```sh
#!/bin/bash
DOCKER_PS=`docker ps -a |awk '{print$1}'`
DOCKER_IMAGES=`docker images |awk '{print$3}'`
 
#To stop and delete all containers
for cont in $DOCKER_PS;
do
docker stop $cont
docker rm -f $cont
done
 
#Delete all images
for image in $DOCKER_IMAGES;
do
docker rmi -f $image
done
```

## To stop and delete all containers
```
docker rm -f $(docker ps -aq)
```

## Delete all images
```
docker rmi -f $(docker images -aq)
```