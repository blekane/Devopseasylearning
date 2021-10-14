### Is there a way to combine Docker images into 1 container?

```Dockerfile
FROM golang:1.7.3
WORKDIR /go/src/github.com/alexellis/href-counter/
RUN go get -d -v golang.org/x/net/html  
COPY app.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=0 /go/src/github.com/alexellis/href-counter/app .
CMD ["./app"] 
``` 

``````Dockerfile
#We create a base image.
FROM ubuntu AS base

#Install packages
RUN apt-get -y update
RUN apt-get -y vim

#Create intermediate image layer Dependencies
FROM base AS dependencies

#Install dependencies using a requirements file
RUN pip3 install -r requirements.txt

#Create intermediate image layer for Testing
FROM dependencies AS test

#Set your work directory
WORKDIR /usr/src/app

COPY . .

#Build the final image by running the test file
CMD [“python3”, “./test.py”]
```

```Dockerfile
FROM jenkins/jenkins:lts
FROM maven:latest
FROM openjdk:latest
```