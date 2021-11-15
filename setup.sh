#!/bin/bash

THIS="$(realpath -s ${BASH_SOURCE[0]})"
THIS_PATH="$(dirname ${BASH_SOURCE[0]})"
REPO_DIR="$THIS_PATH"
CONFIG_DIR="$REPO_DIR/config"

regtest() {
  echo "$1" | grep -E "$2" > /dev/null
  return $?
}

PATH="$REPO_DIR/setup-tools:$PATH"

for script in $REPO_DIR/setup.d/*; do
  local script_basename="$(basename "$script")"
  local script_name="${script_basename#*_}"
  script_name="${script_name%.*}"
  
  if regtest "$script_basename" '^[[:digit:]]{2}s_'; then
    sudo PATH="$PATH" REPO_DIR="$REPO_DIR" CONFIG_DIR="$CONFIG_DIR/$script_name" "$script"
  else
    PATH="$PATH" REPO_DIR="$REPO_DIR" CONFIG_DIR="$CONFIG_DIR/$script_name" "$script"
  fi
done
