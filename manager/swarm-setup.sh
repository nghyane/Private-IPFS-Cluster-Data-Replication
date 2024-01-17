#!/bin/bash

echo "[swarm-setup] Setup Swarm"

# Create swarm manager directory
mkdir -p /vol/swarm/manager

# Remove docker.pid file if exists
rm /var/run/docker.pid || true

# Run docker daemon
dockerd &

# Wait for Docker daemon to start
until docker info &> /dev/null; do
    sleep 1
done

# Check if swarm is already initialized
if docker node ls &> /dev/null; then
    echo "[swarm-setup] Swarm already initialized."
else
    # Leave swarm if not initialized
    docker swarm leave --force
    
    # Initialize swarm
    docker swarm init --advertise-addr eth0 > /vol/swarm/worker_join_script.txt
    grep 'docker swarm join .*' /vol/swarm/worker_join_script.txt | awk '{ sub(/^[ \t]+/, ""); print $0 }' > /vol/swarm/worker_join_script.sh
    # rm /vol/swarm/worker_join_script.txt
    chmod +x /vol/swarm/worker_join_script.sh
fi

# Write Manager IP Address to file
ETH0_IP=$(ip -4 addr show eth0 | grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' | head -n 1)
echo $ETH0_IP > /vol/swarm/manager/ip_address

# Setup ipfs
# bash ../common/ipfs-setup.sh || true
# chmod +x ../common/ipfs-setup.sh
# bash ../common/ipfs-setup.sh
# chmod +x ./ipfs-setup.sh
# bash ./ipfs-setup.sh
bash ./ipfs-setup.sh

# Redirect output and errors to a log file
exec > /vol/swarm/swarm-setup.log 2>&1

# Keep the script running
tail -f /dev/null