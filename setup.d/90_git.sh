#!/bin/bash

header "Configuring git"

git config --global user.email "thesourceofx@gmail.com"
git config --global user.name "ditzy"

cd "$REPO_DIR"
if [[ "$(git remote get-url origin)" =~ ^git ]]; then
  echo "Git repo origin correctly using git protocol."
else
  echo "Git repo origin is using https protocol. Switching to git protocol..."
  git remote set-url origin git@github.com:im-scared/new-system-init.git
fi
