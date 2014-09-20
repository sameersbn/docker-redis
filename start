#!/bin/bash
set -e

mkdir -p -m 0755 /run/redis
chown -R redis:redis /run/redis

mkdir -p -m 0755 /var/lib/redis
chown -R redis:redis /var/lib/redis

exec sudo -u redis -H /usr/bin/redis-server /etc/redis/redis.conf
