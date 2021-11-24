#!/bin/bash

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

