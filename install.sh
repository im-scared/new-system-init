#!/bin/bash

set -euo pipefail

SYS_CONF="$HOME/.sys-conf"

if [[ -e "$SYS_CONF" ]]; then
  echo "Looks like you already initialized the project :D. If you wish to update it, please run 'update-egg-configs' rather than this init script. If you wish to re-initialize, then delete $SYS_CONF and rerun this script."
  exit 0
fi

echo "Updating package manager..."
sudo apt update
echo "Installing git..."
sudo apt install -y git

echo "Cloning repo..."
git clone https://github.com/im-scared/new-system-init.git "$SYS_CONF"
cd "$SYS_CONF"
echo "Initializing submodules..."
git submodule update --init --recursive

echo "Running setup..."
bin/update-egg-configs
