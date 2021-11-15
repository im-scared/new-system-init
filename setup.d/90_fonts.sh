#!/bin/bash

# source setup scirpt to get utils
source "$1"
REPO_DIR="$2"
CONFIG_DIR="$3"

SYSTEM_FONTS="$HOME/.fonts"
VERSIONED_FONTS="$CONFIG_DIR"


header "Configuring fonts"

ensure_link "$VERSIONED_FONTS" "$SYSTEM_FONTS"

