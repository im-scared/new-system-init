#!/bin/bash

# source setup scirpt to get utils
source "$1"
REPO_DIR="$2"
CONFIG_DIR="$3"

SYSTEM_PATH="$HOME/.local/bin"
BACKUP_PATH="$HOME/.local/bin.bak"
VERSIONED_PATH="$REPO_DIR/bin"

header "Configuring bin"

ensure_link "$VERSIONED_PATH" "$SYSTEM_PATH" "$BACKUP_PATH"
