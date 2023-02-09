#!/usr/bin/env bash

release="latest"

docker run \
    --detach \
    --name node_exporter \
    --publish 9100:9100/tcp \
    --restart always \
    --net="host" \
    --pid="host" \
    --volume "/:/host:ro,rslave" \
    --volume "/:/rootfs:ro" \
    --volume "/etc/hostname:/etc/host_hostname" \
    --volume "/etc/hostname:/etc/hostname" \
    --volume "/etc/hostname:/etc/nodename" \
    --env "HOST_HOSTNAME=/etc/host_hostname" \
    "quay.io/prometheus/node-exporter:${release}" \
        --path.rootfs=/host \
        --path.procfs=/host/proc \
        --path.sysfs=/host/sys \
        --collector.mountstats \
        --collector.systemd \
        --collector.processes
