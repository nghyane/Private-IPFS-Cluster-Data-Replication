#!/bin/bash

# Prepare directory based on IP address of the current node
CURRENT_NODE_IP_ADDRESS=$(ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
mkdir -p /vol/swarm/$CURRENT_NODE_IP_ADDRESS/ipfs

# Swarm key
mkdir -p /vol/swarm/keygen
cd /vol/swarm/keygen
go mod init keygen
go install github.com/Kubuxu/go-ipfs-swarm-key-gen/ipfs-swarm-key-gen@latest
go run main.go > ./swarm.key
cp ./swarm.key ~/.ipfs/swarm.key

# IPFS init
echo "[ipfs-setup] Setup IPFS"
ipfs init

# IPFS id to file
ipfs id > /vol/swarm/manager/ipfs-id.json
echo "[ipfs-setup] IPFS initialized"

# IPFS config
echo "[ipfs-setup] Setup IPFS config"
chmod +x ./ipfs-update-config.sh
bash ./ipfs-update-config.sh $CURRENT_NODE_IP_ADDRESS
echo "[ipfs-setup] IPFS config updated"

# IPFS bootstrap
echo "[ipfs-setup] Setup IPFS bootstrap"
chmod +x ./ipfs-update-bootstrap.sh
bash ./ipfs-update-bootstrap.sh
echo "[ipfs-setup] IPFS bootstrap updated"