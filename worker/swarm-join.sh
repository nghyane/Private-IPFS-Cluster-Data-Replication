#!/bin/bash

echo "[swarm-join] Join Swarm"

# Remove docker.pid file if exists
rm /var/run/docker.pid || true

# Run docker daemon
# dockerd --debug &
dockerd &

# Wait for Docker daemon to start
until docker info &> /dev/null; do
    sleep 1
done

# Wait for manager ip address to be ready
while [ ! -f /vol/swarm/manager/ip_address ]; do
    echo "[swarm-join] Waiting for manager ip address to be ready..."
    sleep 1
done
echo "[swarm-join] Manager ip address is ready"

# Join swarm
cat vol/swarm/worker_join_script.txt || true
bash vol/swarm/worker_join_script.sh || true

# Setup ipfs
bash ./ipfs-setup.sh

# Redirect output and errors to a log file
exec > /vol/swarm/swarm-join.log 2>&1

# Keep the script running
tail -f /dev/null
