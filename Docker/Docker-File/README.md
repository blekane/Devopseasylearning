
```Dockerfile

docker run -it --rm -w "/student_home" -v "${HOME}":/student_home -v /var/run/docker.sock:/var/run/docker.sock tia-2
docker run -it --rm -w "/student_home"  -v "$(pwd)":/student_home -v /var/run/docker.sock:/var/run/docker.sock tia-2

docker run -it --rm \
    -w "/student_home" \
    -v "$(pwd)":/student_home \
    -v /var/run/docker.sock:/var/run/docker.sock \
    tia-2


docker run -it --rm \
    -w "/student_home" \
    -v "${HOME}":/student_home \
    -v /var/run/docker.sock:/var/run/docker.sock \
    tia-2

```

docker run -it --rm \
    -w "/student_home" \
    -v "${HOME}":/student_home \
    -v /var/run/docker.sock:/var/run/docker.sock \
    tia


docker run -itd --name $USER --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /var/run/docker.sock:/var/run/docker.sock tia



docker run -itd --name $USER --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /var/run/docker.sock:/var/run/docker.sock -v "${HOME}":/student_home -w "/student_home" tia

docker run -itd \
    --name $USER \
    --privileged \
    -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v "${HOME}":/student_home \
    -w "/student_home" \
    master-ubuntu-image

docker exec -it $USER bash
exit
docker rm -f $USER


### Image
```Dockerfile
FROM ubuntu
COPY --from=library/docker:latest /usr/local/bin/docker /usr/bin/docker
COPY --from=docker/compose:latest /usr/local/bin/docker-compose /usr/bin/docker-compose
````
docker run -it  -v /var/run/docker.sock:/var/run/docker.sock image-name
```

docker run -d  -v /var/run/docker.sock:/var/run/docker.sock --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro image-name
