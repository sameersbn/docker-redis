#!/bin/bash
set -e

REDIS_PASSWORD=${REDIS_PASSWORD:-}

map_redis_uid() {
  USERMAP_ORIG_UID=$(id -u redis)
  USERMAP_ORIG_GID=$(id -g redis)
  USERMAP_GID=${USERMAP_GID:-${USERMAP_UID:-$USERMAP_ORIG_GID}}
  USERMAP_UID=${USERMAP_UID:-$USERMAP_ORIG_UID}
  if [ "${USERMAP_UID}" != "${USERMAP_ORIG_UID}" ] || [ "${USERMAP_GID}" != "${USERMAP_ORIG_GID}" ]; then
    echo "Adapting uid and gid for redis:redis to $USERMAP_UID:$USERMAP_GID"
    groupmod -g "${USERMAP_GID}" redis
    sed -i -e "s/:${USERMAP_ORIG_UID}:${USERMAP_GID}:/:${USERMAP_UID}:${USERMAP_GID}:/" /etc/passwd
  fi
}

create_socket_dir() {
  mkdir -p /run/redis
  chmod -R 0755 /run/redis
  chown -R ${REDIS_USER}:${REDIS_USER} /run/redis
}

create_data_dir() {
  mkdir -p ${REDIS_DATA_DIR}
  chmod -R 0755 ${REDIS_DATA_DIR}
  chown -R ${REDIS_USER}:${REDIS_USER} ${REDIS_DATA_DIR}
}

create_log_dir() {
  mkdir -p ${REDIS_LOG_DIR}
  chmod -R 0755 ${REDIS_LOG_DIR}
  chown -R ${REDIS_USER}:${REDIS_USER} ${REDIS_LOG_DIR}
}

map_redis_uid
create_socket_dir
create_data_dir
create_log_dir

# allow arguments to be passed to redis-server
if [[ ${1:0:1} = '-' ]]; then
  EXTRA_ARGS="$@"
  set --
fi

# default behaviour is to launch redis-server
if [[ -z ${1} ]]; then
  echo "Starting redis-server..."
  exec start-stop-daemon --start --chuid ${REDIS_USER}:${REDIS_USER} --exec $(which redis-server) -- \
    /etc/redis/redis.conf ${REDIS_PASSWORD:+--requirepass $REDIS_PASSWORD} ${EXTRA_ARGS}
else
  exec "$@"
fi
