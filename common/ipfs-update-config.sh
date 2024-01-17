#!/bin/bash

echo "[ipfs-update-config] Update IPFS Config"

# Parameters
# $1 - ip address of current node
CURRENT_NODE_IP_ADDRESS=$1

# Create IPFS Config replica file to volume
mkdir -p /vol/swarm/$CURRENT_NODE_IP_ADDRESS/ipfs
cp ~/.ipfs/config /vol/swarm/$CURRENT_NODE_IP_ADDRESS/ipfs/config

# Update the Addresses.API and Addresses.Gateway fields in the config replica file
jq --arg ip_address "$CURRENT_NODE_IP_ADDRESS" '.Addresses.API = ["/ip4/\($ip_address)/tcp/5001", "/ip6/::/tcp/5001"] | .Addresses.Gateway = ["/ip4/\($ip_address)/tcp/8080", "/ip6/::/tcp/8080"]' /vol/swarm/$CURRENT_NODE_IP_ADDRESS/ipfs/config > /vol/swarm/$CURRENT_NODE_IP_ADDRESS/ipfs/updated-config

# Overwrite the original config file with the updated one
cat /vol/swarm/$CURRENT_NODE_IP_ADDRESS/ipfs/updated-config > ~/.ipfs/config

echo "[ipfs-update-config] Configuration file updated with eth0 IP address: $CURRENT_NODE_IP_ADDRESS"
