#!/bin/bash

echo "Setup Swarm"

# Remove docker.pid file if exists
rm /var/run/docker.pid || true

# Run docker daemon
dockerd --debug &

# Wait for Docker daemon to start
until docker info &> /dev/null; do
    sleep 1
done

# Check if swarm is already initialized
if docker node ls &> /dev/null; then
    echo "Swarm already initialized."
else
    # Leave swarm if not initialized
    docker swarm leave --force
    
    # Initialize swarm
    docker swarm init --advertise-addr eth0 > /vol/swarm/worker_join_script.txt
    grep 'docker swarm join .*' /vol/swarm/worker_join_script.txt | awk '{ sub(/^[ \t]+/, ""); print $0 }' > /vol/swarm/worker_join_script.sh
    # rm /vol/swarm/worker_join_script.txt
    chmod +x /vol/swarm/worker_join_script.sh
fi

# Redirect output and errors to a log file
exec > /vol/swarm/swarm-setup.log 2>&1

# Keep the script running
tail -f /dev/null