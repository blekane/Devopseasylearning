FROM golang:1.14-alpine as build

RUN apk add --no-cache git

WORKDIR /src 

COPY app/go.sum /src/
COPY app/go.mod /src/

COPY app/client.go /src 

RUN go build client.go

FROM alpine as runtime

COPY --from=build /src/client /app/client
CMD [ "/app/client" ]