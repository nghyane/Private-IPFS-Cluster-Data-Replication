#!/bin/bash

echo "[worker-setup] Setup Worker"

# Wait for manager ip address to be ready
while [ ! -f /vol/swarm/manager/ip_address ]; do
    echo "[worker-setup] Waiting for manager ip address to be ready..."
    sleep 1
done
echo "[worker-setup] Manager ip address is ready"

# Setup ipfs
bash ./ipfs-setup-worker.sh

# Redirect output and errors to a log file
exec > /vol/swarm/worker-setup.log 2>&1

# Keep the script running
tail -f /dev/null
