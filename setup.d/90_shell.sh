#!/bin/bash

# source setup scirpt to get utils
source "$1"
REPO_DIR="$2"
CONFIG_DIR="$3"

SYSTEM_KCONF="$HOME/.config/kitty/kitty.conf"
TRACKED_KCONF="$CONFIG_DIR/kitty.conf"


header "Configuring shell"

ensure_link "$TRACKED_KCONF" "$SYSTEM_KCONF"

