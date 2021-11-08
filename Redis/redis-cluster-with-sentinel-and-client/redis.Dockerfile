FROM redis:6.2.1-alpine
ENTRYPOINT [ "redis-server", "/etc/redis/redis.conf" ]

