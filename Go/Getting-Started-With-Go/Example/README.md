### Dockerfile
```Dockerfile
FROM golang:1.15-alpine

WORKDIR /work
```

### Build the image
```
docker build  . -t go-test
docker run -it -v ${PWD}:/work go-test sh
go version
```

### Initialize the go repository
```
go mod init github.com/pluralsight/webservice
```

### Run the program
```
go run .
go run github.com/pluralsight/webservice
```

### Build the program to get the executable
```
go build .
go build github.com/pluralsight/webservice
```

### Install the module
```
go install github.com/pluralsight/webservice
```

### Pull the go image from my repository
```
docker pull leonardtia/tia:go
docker run -it leonardtia/tia:go sh

docker run -it -v ${PWD}:/work leonardtia/tia:go sh
go version
```