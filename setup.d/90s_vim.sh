#!/bin/bash

VUNDLE_PATH="/usr/share/vim/bundle/Vundle.vim"

header "Configuring vim"

ensure-link "$CONFIG_DIR/vimrc.local" "/etc/vim/vimrc.local"

echo "Looking for Vundle..."
if [[ ! -e "$VUNDLE_PATH" ]]; then
  echo "Vundle not found. Downloading..."
  mkdir -p /usr/share/vim/bundle
  git clone https://github.com/VundleVim/Vundle.vim.git "$VUNDLE_PATH"
else
  echo "Vundle is already installed. Updating..."
  cd "$VUNDLE_PATH"
  git pull --ff-only
fi
echo "Installing configured vim plugins..."
vim +PluginInstall +qall

