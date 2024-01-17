#!/bin/bash

echo "Join Swarm"

# Remove docker.pid file if exists
rm /var/run/docker.pid || true

# Run docker daemon
dockerd --debug &

# Wait for Docker daemon to start
until docker info &> /dev/null; do
    sleep 1
done

cat vol/swarm/worker_join_script.txt || true
bash vol/swarm/worker_join_script.sh || true

# Redirect output and errors to a log file
exec > /vol/swarm/swarm-join.log 2>&1

tail -f /dev/null
