#!/usr/bin/env bash

docker run \
    --detach \
    --name cadvisor \
    --publish 9180:8080 \
    --volume "/:/rootfs:ro" \
    --volume "/var/run:/var/run:rw" \
    --volume "/sys:/sys:ro" \
    --volume "/var/lib/docker:/var/lib/docker:ro" \
    --volume "/etc/machine-id:/etc/machine-id:ro" \
    --volume "/var/lib/dbus/machine-id:/var/lib/dbus/machine-id:ro" \
    --volume "/etc/localtime:/etc/localtime:ro" \
    --device "/dev/kmsg:/dev/kmsg" \
    --restart unless-stopped \
    zcube/cadvisor \
        --housekeeping_interval=30s \
        --docker_only=true
