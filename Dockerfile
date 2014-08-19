FROM sameersbn/ubuntu:12.04.20140818
MAINTAINER sameer@damagehead.com

RUN add-apt-repository -y ppa:chris-lea/redis-server && \
		apt-get update && \
		apt-get install -y redis-server && \
		apt-get clean && rm -rf /var/lib/apt/lists/* # 20140818

RUN sed 's/daemonize yes/daemonize no/' -i /etc/redis/redis.conf && \
		sed 's/bind 127.0.0.1/bind 0.0.0.0/' -i /etc/redis/redis.conf && \
		sed '/^logfile/d' -i /etc/redis/redis.conf

ADD start /start
RUN chmod 755 /start

EXPOSE 6379
VOLUME ["/var/lib/redis"]
CMD ["/start"]
