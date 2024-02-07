#!/bin/bash

echo "[manager-setup] Setup Manager"

# Create swarm manager directory
mkdir -p /vol/swarm/manager

# Write Manager IP Address to file
ETH0_IP=$(ip -4 addr show eth0 | grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' | head -n 1)
echo $ETH0_IP > /vol/swarm/manager/ip_address

# Wait for manager ip address to be ready
while [ ! -f /vol/swarm/manager/ip_address ]; do
    echo "[manager-setup] Waiting for manager ip address to be ready..."
    sleep 1
done
echo "[manager-setup] Manager ip address is ready"

# Setup ipfs
bash ./ipfs-setup-manager.sh

# Redirect output and errors to a log file
exec > /vol/swarm/manager-setup.log 2>&1

# Keep the script running
tail -f /dev/null