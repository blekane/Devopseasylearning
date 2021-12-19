## Build the application
```sh
docker-compose build

# for new version of docker
docker compose build
```
## Start the application
**-d:** will keep containers running at the background and give you access to your terminal

If you run docker compose without `-d`, it will show you the logs of the container and you will not have access to your **CLI**

```sh
docker-compose up -d
docker-compose up 

# for new version of docker
docker compose up -d
docker compose up 
```

## Stop the application
```sh
docker-compose down

# for new version of docker
docker compose down
```

## Other commands
```sh
docker-compose ps
docker-compose stop [service]
docker-compose start [service]
docker-compose rm

# new version
docker compose ps
docker compose stop [service]
docker compose start [service]
docker compose rm
```

## View the logs of all running containers
```
docker compose logs
docker-compose logs
```

## View the logs for a specify service
```
docker compose logs [service name]
docker-compose logs [service name]

docker compose logs kafka
docker-compose logs redis
```

## Limit the container log output
```
docker compose logs --tail=5
docker-compose logs --tail=5

docker compose logs --tail=5 [service name]
docker-compose logs --tail=5 [service name]

docker compose logs --tail=5 --follow [service name]
docker-compose logs --tail=5 -f [service name]

docker compose logs --tail=5 --follow redis
docker-compose logs --tail=5 -f redis
```

## Follow the log
```
docker compose logs -f
docker compose logs --follow

docker-compose logs -f
docker-compose logs --follow
```

## Shell into a container docker compose
```
docker compose ps

docker compose exec [service_name] [shell]
docker-compose exec [service_name] [shell]

docker compose exec redis sh
docker-compose exec kafka sh
```

