#!/bin/bash

# Enable debugging output
set -x

# Get the hostname of the current node
# HOSTNAME=$(hostname)

# Get the role of the current node
ROLE=$(docker node inspect --format '{{.Spec.Role}}' $(hostname))

# IP address of the current node
CURRENT_NODE_IP_ADDRESS=$(ip -4 addr show eth0 | grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' | head -n 1)

# Prepare directory based on IP address of the current node
mkdir -p /vol/swarm/$CURRENT_NODE_IP_ADDRESS/ipfs

# IPFS init
echo "[ipfs-setup] Setup IPFS"
echo "[ipfs-setup] Node hostname: $HOSTNAME"
echo "[ipfs-setup] Node role: $ROLE"
echo "[ipfs-setup] Node eth0 IP address: $CURRENT_NODE_IP_ADDRESS"
ipfs init

# IPFS id to file
ipfs id > /vol/swarm/manager/ipfs-id.json
echo "[ipfs-setup] IPFS initialized"

# IPFS config
echo "[ipfs-setup] Setup IPFS config"
bash ./ipfs-update-config.sh $CURRENT_NODE_IP_ADDRESS
echo "[ipfs-setup] IPFS config updated"

# IPFS bootstrap
echo "[ipfs-setup] Setup IPFS bootstrap"
bash ./ipfs-update-bootstrap.sh
echo "[ipfs-setup] IPFS bootstrap updated"

# Prepare swarm key
echo "[ipfs-setup] Setup swarm key"
if [[ "$ROLE" = "manager" ]]; then
    echo "[ipfs-setup] Generate swarm key"
    # rm -rf /vol/swarm/keygen || true
    # mkdir -p /vol/swarm/keygen
    cd /vol/swarm/keygen
    # git clone https://github.com/Kubuxu/go-ipfs-swarm-key-gen.git .
    cd ipfs-swarm-key-gen
    go run main.go > ./swarm.key
    # cat ./swarm.key > ~/.ipfs/swarm.key
    echo "[ipfs-setup] Swarm key updated"
else
    echo "[ipfs-setup] Not generate the swarm key setup block on this node."
fi

# IPFS Daemon
while [ ! -f /vol/swarm/keygen/ipfs-swarm-key-gen/swarm.key ]; do
    echo "[ipfs-setup] Waiting for swarm key to be ready..."
    sleep 1
done

echo "[ipfs-setup] Swarm key is ready"
cat ./swarm.key > ~/.ipfs/swarm.key
cd /
echo "[ipfs-setup] Start IPFS Daemon"
bash ./ipfs-daemon.sh
echo "[ipfs-setup] IPFS Daemon started"

# Disable debugging output
set +x
