#!/bin/bash

THIS="$(realpath -s ${BASH_SOURCE[0]})"
THIS_PATH="$(dirname ${BASH_SOURCE[0]})"
REPO_DIR="$THIS_PATH"
CONFIG_DIR="$REPO_DIR/config"

header() {
  echo -e "\n"
  echo "#################################"
  echo "##  $1"
  echo "#################################"
}

regtest() {
  echo "$1" | grep -E "$2" > /dev/null
  return $?
}

with_sudo() {
  if [[ "$1" == "-s" || -z "$1" ]]; then
    echo "s[$1|$2]"
    shift
    sudo "$@"
  else
    echo "n[$1]"
    "$@"
  fi
}

backup() {
  local w_sudo
  if [[ "$1" == "-s" ]]; then
    w_sudo="$1"
    shift
  elif [[ -z "$1" ]]; then
    shift
  fi
  local source="$1"
  local target="${2}_$(date +'%s')"

  echo "Moving [$source] to [$target]..."
  with_sudo "$w_sudo" mv "$source" "$target"
  #mv "$source" "$target"
}

link() {
  local w_sudo
  if [[ "$1" == "-s" ]]; then
    w_sudo="$1"
    shift
  elif [[ -z "$1" ]]; then
    shift
  fi
  local source="$1"
  local target="$2"

  echo "Symlinking [$source] to [$target]..."
  with_sudo "$w_sudo" ln -s "$source" "$target"
  #ln -s "$source" "$target"
}

ensure_link() {
  local w_sudo
  if [[ "$1" == "-s" ]]; then
    w_sudo="$1"
    shift
  elif [[ -z "$1" ]]; then
    shift
  fi
  local source="$(realpath "$1")"
  local target="$2"
  local bak="$3"

  if [[ -e "$target" && "$(readlink -nm $target)" == "$source" ]]; then
    echo "[$target] is already linked to version controlled version: $source"
    return
  fi

  if [[ -e "$target" || -L "$target" ]]; then
    echo "[$target] already exists but doesn't link to [$source]."
    backup "$w_sudo" "$target" "$bak" "$root"
    link "$w_sudo" "$source" "$target" "$root"
    return
  fi

  local target_dir="$(dirname "$target")"
  if [[ ! -e "$target_dir" ]]; then
    echo "Containing dir [$target_dir] does not exist. Creating..."
    with_sudo "$w_sudo" mkdir -p "$target_dir"
  fi

  if [[ ! -e "$target" ]]; then
    echo "Symlinking [$source] to [$target]..."
    with_sudo "$w_sudo" ln -s "$source" "$target"
    #ln -s "$source" "$target"
    return
  fi
}

main() {
  for script in $REPO_DIR/setup.d/*; do
    local script_basename="$(basename "$script")"
    local script_name="${script_basename#*_}"
    script_name="${script_name%.*}"
    if regtest "$script_basename" '^[[:digit:]]{2}s_'; then
      sudo "$script" "$THIS" "$REPO_DIR" "$CONFIG_DIR/$script_name"
    else
      "$script" "$THIS" "$REPO_DIR" "$CONFIG_DIR/$script_name"
    fi
  done
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main
