#!/usr/bin/env bash

release="latest"

share_root="$(mount | egrep --only-matching 'on /share/.*DATA type' | sed -e 's/^on //' -e 's/ type$//')"

docker network create prometheus

docker run \
    --name prometheus \
    --detach \
    --network prometheus \
    --publish 9090:9090 \
    --volume $share_root/appdata/prometheus:/etc/prometheus/ \
    --restart always \
    prom/prometheus:${release}

docker run \
    --name pushgateway \
    --detach \
    --network prometheus \
    --publish 9091:9091 \
    --restart always \
    prom/pushgateway
