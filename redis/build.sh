#!/usr/bin/env bash

DIR=$(dirname "$0")
cd "$DIR" || exit 1
VERSION="5.0.7"
REDIS_VERSION="redis-$VERSION"
REDIS_FILE="$REDIS_VERSION.tar.gz"
REDIS_URL="http://download.redis.io/releases/$REDIS_FILE"
if [[ ! -e "$REDIS_FILE" ]]; then
  wget "$REDIS_URL"
  tar xvfz "$REDIS_FILE"
fi
docker run -i --entrypoint /bin/bash --rm -v "$PWD/$REDIS_VERSION":"/target" centos:7 << COMMANDS
yum install -y make gcc kernel-headers jemalloc-devel
cd /target
make
chown -R $UID:${GROUPS[0]} /target
COMMANDS
mkdir -p bin/
cp "$PWD/$REDIS_VERSION"/src/redis-{server,benchmark,cli,check-rdb,check-aof} bin/
