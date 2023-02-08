#!/usr/bin/env bash

APPDATA_ROOT="$(mount | egrep --only-matching 'on /share/.*DATA type' | sed -e 's/^on //' -e 's/ type$//')/appdata"
PUID=$(id -u)
PGID=$(id -g)

# See: https://github.com/prometheus/alertmanager
docker run \
    --detach \
    --name alertmanager \
    --network prometheus \
    --publish 9093:9093 \
    --user ${PUID}:${PGID} \
    --volume "${APPDATA_ROOT}/alertmanager:/alertmanager" \
    --restart always \
    quay.io/prometheus/alertmanager \
        --config.file=/alertmanager/config.yml \
        --storage.path=/alertmanager
