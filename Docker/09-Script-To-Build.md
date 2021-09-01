
## Dockerfile
```
vim Dockerfile
```

```Dockerfile
FROM httpd
LABEL maintainer="Tia M"
RUN apt-get -y update && \
    apt-get -y install wget && \
    apt-get install -y apt-utils && \
    apt-get -y install unzip

WORKDIR /usr/local/apache2/htdocs/

RUN rm -rf * && \
    wget https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/covid19.zip && \
    unzip covid19.zip && \
    cp -R covid19/* . 

CMD ["httpd-foreground"]
EXPOSE 80
```

## Basic script (Junior guy)
```
vim build.sh
chmod +x build.sh
```

```sh
#!/bin/bash
## Login int AWS ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 788210522308.dkr.ecr.us-east-1.amazonaws.com/aws-ecr-docker

## Build the image
docker build -t 788210522308.dkr.ecr.us-east-1.amazonaws.com/aws-ecr-docker:covid19-1 . 

## Push the image
docker push 788210522308.dkr.ecr.us-east-1.amazonaws.com/aws-ecr-docker:covid19-1
```

## Build and push into one env (Senior guy)

```sh
#!/bin/bash
PARAM_ENV=`echo $1 | awk -F= '{print $1}'`
PARAM_TAG=`echo $3 | awk -F= '{print $1}'`
VALUE=`echo $2 | awk -F= '{print $1}'`
TAG=`echo $4 | awk -F= '{print $1}'`

echo $PARAM_ENV
echo $PARAM_TAG
echo $VALUE
echo $TAG
```


```sh
#!/bin/bash

DOCKER_REGISTRY=788210522308.dkr.ecr.us-east-1.amazonaws.com
DOCKER_REPO=aws-ecr-docker

PARAM_ENV=`echo $1 | awk -F= '{print $1}'`
ENVIRONMENT=`echo $2| awk -F= '{print $1}'`
PARAM_TAG=`echo $3 | awk -F= '{print $1}'`
TAG=`echo $4 | awk -F= '{print $1}'`


if [ $ENVIRONMENT == "nonprod" ] && [ $PARAM_ENV == "--env" ] && [ $PARAM_TAG == "--tag" ]
then
    echo "Building $ENVIRONMENT image and pushing it into AWS ECR"
    DOCKER_FULL="$DOCKER_REGISTRY/$DOCKER_REPO:$TAG"

    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $DOCKER_REGISTRY/$DOCKER_REPO
    docker build -t $DOCKER_FULL .
    docker push $DOCKER_FULL
    exit 1
else 
    echo ""
    echo "Usage for covid 19 nonprod image: $0 --env nonprod --tag <image tag name>"
    echo "Example: ./build.sh --env nonprod --tag covid19"
    echo ""
    exit 1
fi
```

## Build and push into 3 environments such as NONPROD, PROD AND QA (Senior guy)

```sh
#!/bin/bash

ENVIRONMENT_PROD=prod
ENVIRONMENT_QA=qa
ENVIRONMENT_NONPROD=nonprod
DOCKER_REGISTRY_PROD=788210522308.dkr.ecr.us-east-1.amazonaws.com
DOCKER_REGISTRY_NONPROD=788210522308.dkr.ecr.us-east-1.amazonaws.com
DOCKER_REGISTRY_QA=788210522308.dkr.ecr.us-east-1.amazonaws.com
DOCKER_REPO=aws-ecr-docker

PARAM_ENV=`echo $1 | awk -F= '{print $1}'`
PARAM_TAG=`echo $3 | awk -F= '{print $1}'`
VALUE=`echo $2 | awk -F= '{print $1}'`
TAG=`echo $4 | awk -F= '{print $1}'`

if [ $VALUE == $ENVIRONMENT_QA ] && [ $PARAM_ENV == "--env" ] && [ $PARAM_TAG == "--tag" ]
then
    echo "Building Covid 19 $VALUE image and pushing it into AWS ECR"
    DOCKER_FULL="$DOCKER_REGISTRY_QA/$DOCKER_REPO:$TAG"
    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $DOCKER_REGISTRY_QA
    docker build -t $DOCKER_FULL .
    docker push $DOCKER_FULL
    exit 1

elif [ $VALUE == $ENVIRONMENT_NONPROD ] && [ $PARAM_ENV == "--env" ] && [ $PARAM_TAG == "--tag" ]
then
    echo "Building Covid 19 $VALUE image and pushing it into AWS ECR"
    DOCKER_FULL="$DOCKER_REGISTRY_NONPROD/$DOCKER_REPO:$TAG"
    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $DOCKER_REGISTRY_NONPROD
    docker build -t $DOCKER_FULL .
    docker push $DOCKER_FULL
    exit 1

elif [ $VALUE == $ENVIRONMENT_PROD ] && [ $PARAM_ENV == "--env" ] && [ $PARAM_TAG == "--tag" ]
then
    echo "Building Covid 19 $VALUE image and pushing it into AWS ECR"
    DOCKER_FULL="$DOCKER_REGISTRY_PROD/$DOCKER_REPO:$TAG"
    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $DOCKER_REGISTRY_PROD
    docker build -t $DOCKER_FULL .
    docker push $DOCKER_FULL
    exit 1

else 
    echo ""
    echo "ERROR: Check the below usage to build the image according to your environement: "
    echo "Usage for Covid 19 QA image: $0 --env $ENVIRONMENT_QA --tag <image tag name>"
    echo "Usage for Covid 19 NONPROD  image: $0 --env $ENVIRONMENT_NONPROD --tag <image tag name>"
    echo "Usage for Covid 19 PROD image: $0 --env $ENVIRONMENT_PROD --tag <image tag name>"
    echo "Example: $0 --env $ENVIRONMENT_NONPROD --tag covid19"
    echo ""
    exit 1
fi
```
```
./build.sh --env nonprod --tag covid19-nonprod
./build.sh --env qa --tag covid19-qa
./build.sh --env prod --tag covid19-prod
```

## Build and push into 2 environments such as NONPROD, PROD (Senior guy)
```sh
ENVIRONMENT_PROD=prod
ENVIRONMENT_NONPROD=nonprod

DOCKER_REGISTRY_PROD=288210522308.dkr.ecr.us-east-1.amazonaws.com
DOCKER_REGISTRY_NONPROD=288210522308.dkr.ecr.us-east-1.amazonaws.com
DOCKER_REPO=jenkins

PARAM_ENV=`echo $1 | awk -F= '{print $1}'`
PARAM_TAG=`echo $3 | awk -F= '{print $1}'`
VALUE=`echo $2 | awk -F= '{print $1}'`
TAG=`echo $4 | awk -F= '{print $1}'`


if [ $VALUE == $ENVIRONMENT_NONPROD ] && [ $PARAM_ENV == "--env" ] && [ $PARAM_TAG == "--tag" ]
then
    echo "Building Jenkins $VALUE image and pushing it into AWS ECR"
    DOCKER_FULL="$DOCKER_REGISTRY_NONPROD/$DOCKER_REPO:$TAG"
    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $DOCKER_REGISTRY_NONPROD
    docker build -t $DOCKER_FULL .
    docker push $DOCKER_FULL
    exit 1

elif [ $VALUE == $ENVIRONMENT_PROD ] && [ $PARAM_ENV == "--env" ] && [ $PARAM_TAG == "--tag" ]
then
    echo "Building Jenkins $VALUE image and pushing it into AWS ECR"
    DOCKER_FULL="$DOCKER_REGISTRY_PROD/$DOCKER_REPO:$TAG"
    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $DOCKER_REGISTRY_PROD
    docker build -t $DOCKER_FULL .
    docker push $DOCKER_FULL
    exit 1

else 
    echo ""
    echo "ERROR: Check the below usage to build the image according to your environement: "
    echo "Usage for Jenkins nonprod image: $0 --env $ENVIRONMENT_NONPROD --tag <image tag name>"
    echo "Usage for Jenkins prod image: $0 --env $ENVIRONMENT_PROD --tag <image tag name>"
    echo "Example: $0 --env $ENVIRONMENT_NONPROD --tag jenkins-nonprod"
    echo ""
    exit 1
fi
```