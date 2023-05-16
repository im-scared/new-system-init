#!/bin/bash

header "Installing NordVPN"

if command -v nordvpn &> /dev/null; then
  echo "NordVPN already installed. Skipping download."
else
  echo "NordVPN not found. Downloading..."
  sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)
fi

if [[ "$(groups $ORIG_USER)" =~ "nordvpn" ]]; then
  echo "User is already in the nordvpn group."
else
  echo "User is not in the nordvpn group. Adding them to it..."
  usermod -aG nordvpn $ORIG_USER
fi

# nordvpn whitelist add subnet 192.168.0.0/16
