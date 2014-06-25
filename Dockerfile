FROM sameersbn/ubuntu:12.04.20140519
MAINTAINER sameer@damagehead.com

RUN apt-get update && \
		apt-get install -y redis-server && \
		apt-get clean # 20140625

ADD assets/ /app/
RUN chmod 755 /app/init /app/setup/install
RUN /app/setup/install

ADD authorized_keys /root/.ssh/

EXPOSE 6379

VOLUME ["/var/lib/redis"]

ENTRYPOINT ["/app/init"]
CMD ["app:start"]
