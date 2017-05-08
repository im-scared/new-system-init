#!/bin/bash

# source setup scirpt to get utils
source "$1"
REPO_DIR="$2"
CONFIG_DIR="$3"

SYSTEM_CONFIG="/etc/vim/vimrc.local"
BACKUP_PATH="/etc/vim/vimrc.local.bak"
VERSIONED_CONFIG="$CONFIG_DIR/vimrc.local"
BUNDLE_DIR="/usr/share/vim/bundle"
VUNDLE_PATH="$BUNDLE_DIR/Vundle.vim"

header "Configuring vim"

ensure_link "$VERSIONED_CONFIG" "$SYSTEM_CONFIG" "$BACKUP_PATH"

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

