
```sh
#!/bin/bash
## Login int AWS ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 788210522308.dkr.ecr.us-east-1.amazonaws.com/aws-ecr-docker

## Build the image
docker build -t 788210522308.dkr.ecr.us-east-1.amazonaws.com/aws-ecr-docker:covid19-1 . 

## Push the image
docker push 788210522308.dkr.ecr.us-east-1.amazonaws.com/aws-ecr-docker:covid19-1
```


### Script to build and push image in ECR
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