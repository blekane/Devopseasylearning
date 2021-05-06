# DOCKER LOAD AND SAVE

### Saving Images and Containers as Tar Files for Sharing
Imagine a scenario where you have built Docker images and containers that you would be interested to keep and share it with your other collaborators or colleagues. The below methods shall help you achieve it.

**Four basic Docker CLI comes into action:**
- **The docker export**: Export a container’s filesystem as a tar archive
- **The docker import**: Import the contents a container’s and create a filesystem image
- **The docker save**: Save one or more images to a tar archive
- **The docker load**: Load an image from a tar archive

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

### What is the difference between save and export in Docker?
[Learn more here](https://stackoverflow.com/questions/22655867/what-is-the-difference-between-save-and-export-in-docker)

**There are two main differences between `save` and `export` commands.**

1. save command saves whole image with history and metadata but export command exports only files structure (without history and metadata). So the exported tar file will be smaller then the saved one.

2. When you use exported file system for creating a new image then this new image will not contain any `USER, EXPOSE, RUN` etc. commands from your `Dockerfile`. Only file structure will be transferred. So when you are using mentioned keywords in your Dockerfile then you cannot use export command for transferring image to another machine - **you need always use save command.**