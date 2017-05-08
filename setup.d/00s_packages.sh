#!/bin/bash

# source setup scirpt to get utils
source "$1"

header "Updating package db"
apt update
header "Installing packages"
apt install -y \
  i3 \
  i3blocks \
  dunst \
  compton \
  curl \
  fonts-mplus \
  fonts-noto \
  golang-chroma \
  hsetroot \
  httpie \
  imagemagick \
  jq \
  lxappearance \
  neovim \
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
  # rxvt-unicode \

header "Installing snaps"
snap install alacritty --classic
