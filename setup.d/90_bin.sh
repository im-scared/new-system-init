#!/bin/bash

header "Configuring bin"
ensure_link "$REPO_DIR/bin" "$HOME/.local/bin"
