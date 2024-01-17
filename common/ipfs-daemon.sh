#!/bin/bash

echo "[ipfs-daemon] IPFS Daemon"

mkdir -p /run/openrc || true
touch /run/openrc/softlevel
rc-update add ipfs default
rc-service ipfs start --dry-run

echo "[ipfs-daemon] IPFS Daemon Started"