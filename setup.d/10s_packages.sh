#!/bin/bash

set -euo pipefail

header "Updating package db"
apt update
header "Installing packages"
apt install -y \
  i3 \
  i3blocks \
  dunst \
  compton \
  apt-transport-https \
  curl \
  fonts-mplus \
  fonts-noto \
  golang-chroma \
  hsetroot \
  httpie \
  imagemagick \
  jq \
  kitty \
  lxappearance \
  neovim \
  nfs-common \
  nitrogen \
  pavucontrol \
  pulseaudio \
  pulseaudio-utils \
  redshift \
  redshift-gtk \
  ripgrep \
  rofi \
  scrot \
  viewnior \
  vim \
  vim-gtk \
  xsel \
  xsettingsd \
  zsh

header "Installing Brave browser"
brave_sources_file=/etc/apt/sources.list.d/brave-browser-release.list
if [[ -f "$brave_sources_file" ]]; then
  echo "Brave sources file found"
else
  echo "Adding Brave package source..."
  curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | tee "$brave_sources_file"
  apt update
fi
apt install -y brave-browser

header "Updating alternatives"
update-alternatives --set x-terminal-emulator /usr/bin/kitty
