FROM sameersbn/ubuntu:12.04.20140628
MAINTAINER sameer@damagehead.com

RUN add-apt-repository -y ppa:chris-lea/redis-server && \
		apt-get update && \
		apt-get install -y redis-server && \
		apt-get clean # 20140625

RUN sed 's/daemonize yes/daemonize no/' -i /etc/redis/redis.conf && \
		sed 's/bind 127.0.0.1/bind 0.0.0.0/' -i /etc/redis/redis.conf && \
		sed '/^logfile/d' -i /etc/redis/redis.conf

EXPOSE 6379
VOLUME ["/var/lib/redis"]
CMD sudo -u redis -H /usr/bin/redis-server /etc/redis/redis.conf
