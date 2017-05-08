#!/bin/bash

# source setup scirpt to get utils
source "$1"
REPO_DIR="$2"
CONFIG_DIR="$3"

SYSTEM_CONFIG="$HOME/.config/i3status"
BACKUP_PATH="$HOME/.config/i3status.bak"
VERSIONED_CONFIG="$CONFIG_DIR"

header "Configuring i3status"

ensure_link "$VERSIONED_CONFIG" "$SYSTEM_CONFIG" "$BACKUP_PATH"

