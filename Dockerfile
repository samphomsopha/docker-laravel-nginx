FROM ubuntu:latest

MAINTAINER "Sam Phomsopha" <samphomsopha@gmail.com>

WORKDIR /tmp

#Install Nginx
RUN apt-get update -y && \
    apt-get install -y nginx

#Add Config
ADD config/nginx.conf /etc/nginx/nginx.conf.docker
ADD config/laravel /etc/nginx/sites-available/laravel
RUN ln -s /etc/nginx/sites-available/laravel /etc/nginx/sites-enabled/laravel

#Startup Script
ADD config/nginx-start.sh /usr/bin/nginx-start.sh
RUN chmod 777 /usr/bin/nginx-start.sh

RUN mkdir -p /data
VOLUME ["/data"]

# PORTS
EXPOSE 80
EXPOSE 443

WORKDIR /usr/bin
ENTRYPOINT ["/usr/bin/nginx-start.sh"]