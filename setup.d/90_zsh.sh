#!/bin/bash

header "Configuring shell"

if [[ ! -e "$HOME/.oh-my-zsh" ]]; then
  echo "Oh My Zsh not found. Installing..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh found."
fi

ensure-link "$CONFIG_DIR/zshrc" "$HOME/.zshrc"
ensure-link "$CONFIG_DIR/powerlevel10k" "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"

