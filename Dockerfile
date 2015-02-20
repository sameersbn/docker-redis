FROM sameersbn/ubuntu:14.04.20150220
MAINTAINER sameer@damagehead.com

RUN apt-get update \
 && apt-get install -y redis-server \
 && rm -rf /var/lib/apt/lists/* # 20150220

RUN sed 's/^daemonize yes/daemonize no/' -i /etc/redis/redis.conf \
 && sed 's/^bind 127.0.0.1/bind 0.0.0.0/' -i /etc/redis/redis.conf \
 && sed 's/^# unixsocket /unixsocket /' -i /etc/redis/redis.conf \
 && sed 's/^# unixsocketperm 755/unixsocketperm 777/' -i /etc/redis/redis.conf \
 && sed '/^logfile/d' -i /etc/redis/redis.conf

ADD start /start
RUN chmod 755 /start

EXPOSE 6379

VOLUME ["/var/lib/redis"]
VOLUME ["/run/redis"]
CMD ["/start"]
