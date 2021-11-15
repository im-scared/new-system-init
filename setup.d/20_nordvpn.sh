#!/bin/bash

# source setup scirpt to get utils
source "$1"


header "Installing NordVPN"

if which nordvpn; then
  echo "NordVPN already installed. Nothing to do."
else
  sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)
fi

