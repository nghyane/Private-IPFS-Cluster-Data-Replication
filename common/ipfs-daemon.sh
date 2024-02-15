#!/bin/bash

echo "[ipfs-daemon] IPFS Daemon"

rc-status -a
rc-service ipfs start
touch /run/openrc/softlevel
rc-service ipfs restart
rc-update add ipfs default
sleep 1
rc-status -a

echo "[ipfs-daemon] IPFS Daemon Started"