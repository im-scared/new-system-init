#!/bin/bash

header "Configuring bin"
ensure-link "$REPO_DIR/bin" "$HOME/.local/bin"
