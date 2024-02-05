#!/bin/bash

# Enable debugging output
set -x

# Get the hostname of the current node
HOSTNAME=$(hostname)

# IP address of the current node
CURRENT_NODE_IP_ADDRESS=$(ip -4 addr show eth0 | grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' | head -n 1)

# Prepare directory based on IP address of the current node
mkdir -p /vol/swarm/$CURRENT_NODE_IP_ADDRESS/ipfs

# IPFS init
echo "[ipfs-setup] Setup IPFS"
echo "[ipfs-setup] Node hostname: $HOSTNAME"
echo "[ipfs-setup] Node eth0 IP address: $CURRENT_NODE_IP_ADDRESS"
ipfs init

# IPFS id to file
echo "[ipfs-setup] IPFS initialized"

# IPFS config
echo "[ipfs-setup] Setup IPFS config"
bash ./ipfs-update-config.sh $CURRENT_NODE_IP_ADDRESS
echo "[ipfs-setup] IPFS config updated"

# IPFS bootstrap
while [ ! -f /vol/swarm/manager/ip_address ] || [ ! -f /vol/swarm/manager/ipfs-id.json ]; do
    echo "[ipfs-setup] Waiting for manager resources to be ready..."
    sleep 1
done
echo "[ipfs-setup] Manager resources are ready"
echo "[ipfs-setup] Setup IPFS bootstrap"
bash ./ipfs-update-bootstrap.sh
echo "[ipfs-setup] IPFS bootstrap updated"

# IPFS Daemon
while [ ! -s ./swarm.key ]; do
    echo "[ipfs-setup] Waiting for swarm key to be ready..."
    sleep 1
done

echo "[ipfs-setup] Swarm key is ready"
SWARM_KEY_CONTENT=$(cat ./swarm.key)
echo "[ipfs-setup] Copy swarm key: $SWARM_KEY_CONTENT" 
cat ./swarm.key > ~/.ipfs/swarm.key
# cp ./swarm.key ~/.ipfs/swarm.key
cd /
echo "[ipfs-setup] Start IPFS Daemon"
bash ./ipfs-daemon.sh
echo "[ipfs-setup] IPFS Daemon started"

# Disable debugging output
set +x
