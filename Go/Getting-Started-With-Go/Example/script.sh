docker build  . -t go-test
docker run -it -v ${PWD}:/work go-test sh