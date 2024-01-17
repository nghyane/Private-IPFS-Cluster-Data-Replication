#!/bin/bash

echo "[ipfs-update-bootstrap] IPFS Update Bootstrap"

MANAGER_IPFS_ID=$(cat /vol/swarm/manager/ipfs-id.json | jq -r '.ID')
MANAGER_IP_ADDRESS=$(cat /vol/swarm/manager/ip_address)
MANAGER_BOOTSTRAP=/ip4/$MANAGER_IP_ADDRESS/tcp/4001/ipfs/$MANAGER_IPFS_ID

# remove all bootstrap nodes
echo "[ipfs-update-bootstrap] Remove all bootstrap nodes"
ipfs bootstrap rm --all
echo "[ipfs-update-bootstrap] Add bootstrap node: $MANAGER_BOOTSTRAP"
# add bootstrap nodes
ipfs bootstrap add $MANAGER_BOOTSTRAP

echo "[ipfs-update-bootstrap] IPFS Update Bootstrap Complete"