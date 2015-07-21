[![Circle CI](https://circleci.com/gh/sameersbn/docker-redis.svg?style=shield)](https://circleci.com/gh/sameersbn/docker-redis)

# sameersbn/redis

- [Introduction](#introduction)
  - [Contributing](#contributing)
  - [Issues](#issues)
- [Getting started](#getting-started)
  - [Installation](#installation)
  - [Quickstart](#quickstart)
  - [Persistence](#persistence)
  - [Authentication](#authentication)
- [Maintenance](#maintenance)
  - [Cache expiry](#cache-expiry)
  - [Upgrading](#upgrading)
  - [Shell Access](#shell-access)

# Introduction

`Dockerfile` to create a [Docker](https://www.docker.com/) container image for [Redis](http://redis.io/).

Redis is an open source, BSD licensed, advanced key-value cache and store. It is often referred to as a data structure server since keys can contain strings, hashes, lists, sets, sorted sets, bitmaps and hyperloglogs.

## Contributing

If you find this image useful here's how you can help:

- Send a pull request with your awesome features and bug fixes
- Help users resolve their [issues](../../issues?q=is%3Aopen+is%3Aissue).
- Support the development of this image with a [donation](http://www.damagehead.com/donate/)

## Issues

Before reporting your issue please try updating Docker to the latest version and check if it resolves the issue. Refer to the Docker [installation guide](https://docs.docker.com/installation) for instructions.

SELinux users should try disabling SELinux using the command `setenforce 0` to see if it resolves the issue.

If the above recommendations do not help then [report your issue](../../issues/new) along with the following information:

- Output of the `docker version` and `docker info` commands
- The `docker run` command or `docker-compose.yml` used to start the image. Mask out the sensitive bits.
- Please state if you are using [Boot2Docker](http://www.boot2docker.io), [VirtualBox](https://www.virtualbox.org), etc.

# Getting started

## Installation

This image is available as a [trusted build](//hub.docker.com/u/sameersbn/redis) on the [Docker hub](//hub.docker.com) and is the recommended method of installation.

```bash
docker pull sameersbn/redis:latest
```

Alternatively you can build the image yourself.

```bash
git clone https://github.com/sameersbn/docker-redis.git
cd docker-redis
docker build --tag $USER/redis .
```

## Quickstart

Start Redis using:

```bash
docker run --name redis -d --restart=always \
  --publish 6379:6379 \
  --volume /srv/docker/redis:/var/lib/redis \
  sameersbn/redis:latest
```

*Alternatively, you can use the sample [docker-compose.yml](docker-compose.yml) file to start the container using [Docker Compose](https://docs.docker.com/compose/)*

> Any arguments specified on the `docker run` command are passed on the `redis-server` command.

## Persistence

For Redis to preserve its state across container shutdown and startup you should mount a volume at `/var/lib/redis`.

> *The [Quickstart](#quickstart) command already mounts a volume for persistence.*

SELinux users should update the security context of the host mountpoint so that it plays nicely with Docker:

```bash
mkdir -p /srv/docker/redis
chcon -Rt svirt_sandbox_file_t /srv/docker/redis
```

## Authentication

To secure your Redis server with a password, specify the password in the `REDIS_PASSWORD` variable while starting the container.

```bash
docker run --name redis -d --restart=always \
  --publish 6379:6379 \
  --env 'REDIS_PASSWORD=redispassword' \
  --volume /srv/docker/redis:/var/lib/redis \
  sameersbn/redis:latest
```

Clients connecting to the Redis server will now have to authenticate themselves with the password `redispassword`.

# Maintenance

## Upgrading

To upgrade to newer releases:

  1. Download the updated Docker image:

  ```bash
  docker pull sameersbn/redis:latest
  ```

  2. Stop the currently running image:

  ```bash
  docker stop redis
  ```

  3. Remove the stopped container

  ```bash
  docker rm -v redis
  ```

  4. Start the updated image

  ```bash
  docker run -name redis -d \
    [OPTIONS] \
    sameersbn/redis:latest
  ```

## Shell Access

For debugging and maintenance purposes you may want access the containers shell. If you are using Docker version `1.3.0` or higher you can access a running containers shell by starting `bash` using `docker exec`:

```bash
docker exec -it redis bash
```
