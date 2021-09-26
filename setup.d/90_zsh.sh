#!/bin/bash

# source setup scirpt to get utils
source "$1"
REPO_DIR="$2"
CONFIG_DIR="$3"

SYSTEM_RC="$HOME/.zshrc"
BACKUP_RC="$HOME/.zshrc.bak"
TRACKED_RC="$CONFIG_DIR/zshrc"
SYSTEM_PL10K="$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
BACKUP_PL10K="$HOME/.oh-my-zsh/custom/themes/powerlevel10k.bak"
TRACKED_PL10K="$CONFIG_DIR/powerlevel10k"

header "Configuring zsh"

if [[ ! -e "$HOME/.oh-my-zsh" ]]; then
  echo "Oh My Zsh not found. Installing..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh found."
fi

ensure_link "$TRACKED_RC" "$SYSTEM_RC" "$BACKUP_RC"

ensure_link "$TRACKED_PL10K" "$SYSTEM_PL10K" "$BACKUP_PL10K"

