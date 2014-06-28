FROM sameersbn/ubuntu:12.04.20140628
MAINTAINER sameer@damagehead.com

RUN add-apt-repository -y ppa:chris-lea/redis-server && \
		apt-get update && \
		apt-get install -y redis-server && \
		apt-get clean # 20140625

ADD assets/ /app/
RUN chmod 755 /app/init /app/setup/install
RUN /app/setup/install

EXPOSE 6379

VOLUME ["/var/lib/redis"]

ENTRYPOINT ["/app/init"]
CMD ["app:start"]
