FROM sameersbn/ubuntu:20140310
MAINTAINER sameer@damagehead.com

# image specific
RUN apt-get install -y redis-server && apt-get clean

ADD assets/ /app/
RUN chmod 755 /app/init /app/setup/install && /app/setup/install

ADD authorized_keys /root/.ssh/

EXPOSE 22
EXPOSE 6379

VOLUME ["/var/lib/redis"]

ENTRYPOINT ["/app/init"]
CMD ["app:start"]
