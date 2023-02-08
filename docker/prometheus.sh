#!/usr/bin/env bash

release="latest"

share_root="$(mount | egrep --only-matching 'on /share/.*DATA type' | sed -e 's/^on //' -e 's/ type$//')"

docker run \
    -d \
    --name prometheus \
    -p 9090:9090 \
    -v $share_root/appdata/prometheus:/etc/prometheus/ \
    prom/prometheus:${release}
