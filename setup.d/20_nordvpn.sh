#!/bin/bash

header "Installing NordVPN"

if command -v nordvpn &> /dev/null; then
  echo "NordVPN already installed. Nothing to do."
else
  sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)
fi

