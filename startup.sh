#!/bin/bash

# Run the existing POWDER demo setup if needed
echo "[startup] Running custom startup..."

# Optional: wait for ue1 namespace to be created
echo "[startup] Waiting for ue1 namespace..."
timeout=30
while ! ip netns list | grep -q ue1 && [ $timeout -gt 0 ]; do
  sleep 1
  timeout=$((timeout - 1))
done

if [ $timeout -eq 0 ]; then
  echo "[startup] ue1 namespace not found. Exiting veth setup."
  exit 1
fi

# Run veth setup
bash /opt/srsRAN_Project/scripts/setup_veth.sh
