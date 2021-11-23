#!/bin/bash

header "Configuring xmodmap"
ensure-link "$CONFIG_DIR/Xmodmap" "$HOME/.Xmodmap"
