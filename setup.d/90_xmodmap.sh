#!/bin/bash

header "Configuring xmodmap"
ensure_link "$CONFIG_DIR/Xmodmap" "$HOME/.Xmodmap"
