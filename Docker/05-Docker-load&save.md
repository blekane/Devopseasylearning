# DOCKER LOAD AND SAVE

### Pull 2 images down
```
docker pull ubuntu
docker pull centos
```

### Save one image to tar file
```
docker save ubuntu > ubuntu.tar
docker load < ubuntu.tar
```

### Archive one image at the same time and reduce the size
```
docker save ubuntu:latest | gzip > tia_images.tar.gz
docker load < tia_images.tar.gz
```

### Archive multiple image at the same time
```
docker save -o my-images.tar ubuntu:latest nginx:latest
Or
docker save -o my-images.tar.gz ubuntu:latest nginx:latest
```

```
docker load < my-images.tar
my-images.tar.gz
```

### Archive multiple image at the same time and reduce the size
```
docker save ubuntu:latest nginx:latest | gzip > tia_images.tar.gz
docker load < my-images.tar.gz
```

## Example:
1. run the container:
```
docker run -it ubuntu:latest /bin/bash
```
2. install you applications or modify the container as you wish 

3. exit out of the container  and keep the container running without exit 
```
ctrl <p> and ctrl <q> : press ctrl + p and ctrl + q simultaneously.
```

4. check if the container is running:
```
docker ps
```

5. log back in the container if needed 
```
docker attach  <running container ID>
docker attach 4c765f2dd902
```

6. commit your changes
```
docker <commit running container ID> <new image name>
docker commit 4c765f2dd902 my-ubuntu:my_tag
```
7. stop the running container first because achieving 
```
docker stop <running container ID>
```

8. save or archive the image and reduce the size
```
docker save my-ubuntu:my_tag |gzip > tia_image.tar.gz
```

9. clean up and load you image back to into docker engine
```
docker load < tia_image.tar.gz
```
