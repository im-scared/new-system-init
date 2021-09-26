#!/bin/bash

# source setup scirpt to get utils
source "$1"
REPO_DIR="$2"
CONFIG_DIR="$3"

header "Loading dependencies"

cd "$REPO_DIR"

echo "Initializing submodules..."
git submodule update --init --recursive

echo "Pulling latest changes..."
git submodule update --remote
