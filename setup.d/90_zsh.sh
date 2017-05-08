#!/bin/bash

# source setup scirpt to get utils
source "$1"
REPO_DIR="$2"
CONFIG_DIR="$3"

SYSTEM_RC="$HOME/.zshrc"
BAK_RC="$HOME/.zshrc.bak"
VERSIONED_RC="$CONFIG_DIR/zshrc"

header "Configuring zsh"

echo "Looking for Oh My Zsh..."
if [[ ! -e "$HOME/.oh-my-zsh" ]]; then
  echo "Oh My Zsh not found. Installing..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh found."
fi

ensure_link "$VERSIONED_RC" "$SYSTEM_RC" "$BAK_RC"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k

