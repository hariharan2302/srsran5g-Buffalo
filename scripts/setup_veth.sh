#!/bin/bash

echo "[veth-setup] Starting veth setup..."

# Check if already exists to avoid duplicate setup
ip link show veth-host >/dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "[veth-setup] veth-host already exists. Skipping setup."
  exit 0
fi

# Create veth pair
ip link add veth-host type veth peer name veth-ue

# Move one end into ue1 namespace
ip link set veth-ue netns ue1

# Assign IPs
ip addr add 192.168.100.1/24 dev veth-host
ip link set veth-host up

ip netns exec ue1 ip addr add 192.168.100.2/24 dev veth-ue
ip netns exec ue1 ip link set veth-ue up

echo "[veth-setup] veth pair configured successfully"
