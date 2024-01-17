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

cat vol/swarm/worker_join_script.txt || true
bash vol/swarm/worker_join_script.sh || true

# Setup ipfs
# bash ../common/ipfs-setup.sh || true
# chmod +x ../common/ipfs-setup.sh
# bash ../common/ipfs-setup.sh
# chmod +x ./ipfs-setup.sh
# bash ./ipfs-setup.sh
bash ./ipfs-setup.sh

# Redirect output and errors to a log file
exec > /vol/swarm/swarm-join.log 2>&1

tail -f /dev/null
