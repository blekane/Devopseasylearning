FROM nginx

RUN apt update -y && apt upgrade -y;apt install -y openssl;mkdir /etc/nginx/ssl

COPY default.conf /etc/nginx/conf.d/