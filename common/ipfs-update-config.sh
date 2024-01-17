#!/bin/bash

echo "[ipfs-update-config] Update IPFS Config"

# Parameters
# $1 - ip address of current node
CURRENT_NODE_IP_ADDRESS=$1

# Create IPFS Config replica file to volume
mkdir -p /vol/swarm/$CURRENT_NODE_IP_ADDRESS/ipfs
cp ~/.ipfs/config /vol/swarm/$CURRENT_NODE_IP_ADDRESS/ipfs/config

# Update the Addresses.API and Addresses.Gateway fields in the config replica file
jq --arg eth0_ip "$CURRENT_NODE_IP_ADDRESS" '.Addresses.API = "/ip4/\($eth0_ip)/tcp/5001" | .Addresses.Gateway = "/ip4/\($CURRENT_NODE_IP_ADDRESS)/tcp/8080"' /vol/swarm/$CURRENT_NODE_IP_ADDRESS/ipfs/config > /vol/swarm/$CURRENT_NODE_IP_ADDRESS/ipfs/updated-config

# Replace the original config file with the updated one
mv /vol/swarm/$CURRENT_NODE_IP_ADDRESS/updated-config ~/.ipfs/config

echo "[ipfs-update-config] Configuration file updated with eth0 IP address: $CURRENT_NODE_IP_ADDRESS"
