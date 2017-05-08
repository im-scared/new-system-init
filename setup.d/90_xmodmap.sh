#!/bin/bash

# source setup scirpt to get utils
source "$1"
REPO_DIR="$2"
CONFIG_DIR="$3"

SYSTEM_PATH="$HOME/.Xmodmap"
BACKUP_PATH="$HOME/.Xmodmap.bak"
VERSIONED_PATH="$CONFIG_DIR/Xmodmap"

header "Configuring xmodmap"

ensure_link "$VERSIONED_PATH" "$SYSTEM_PATH" "$BACKUP_PATH"
