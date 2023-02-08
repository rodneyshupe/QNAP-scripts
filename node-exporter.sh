#!/usr/bin/env bash

release="latest"

docker run \
  -d \
  --name node_exporter \
  -p 9100:9100/tcp \
  --restart always \
  --net="host" \
  --pid="host" \
  -v "/:/host:ro,rslave" \
  -v "/:/rootfs:ro" \
  -v "/etc/hostname:/etc/host_hostname" \
  -v "/etc/hostname:/etc/hostnam" \
  -v "/etc/hostname:/etc/nodename" \
  -e "HOST_HOSTNAME=/etc/host_hostname"
  "quay.io/prometheus/node-exporter:${release}" \
    --path.rootfs=/host \
    --path.procfs=/host/proc \
    --path.sysfs=/host/sys \
    --collector.mountstats
