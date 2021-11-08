FROM redis:6-alpine
 
RUN mkdir -p /redis
COPY sentinels-config/sentinel.conf /redis/sentinel.conf
RUN chown -R redis:redis /redis/*
EXPOSE 26379

ENTRYPOINT [ "redis-sentinel", "/redis/sentinel.conf" ]
