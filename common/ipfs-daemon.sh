#!/bin/bash

echo "[ipfs-daemon] IPFS Daemon"

mkdir -p /run/openrc || true
touch /run/openrc/softlevel
rc-update add ipfs default
rc-service ipfs start --dry-run
# rc-service ipfs start
sleep 1
rc-status -a

echo "[ipfs-daemon] IPFS Daemon Started"