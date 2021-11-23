#!/bin/bash

THIS="$(realpath -s ${BASH_SOURCE[0]})"
THIS_PATH="$(dirname ${BASH_SOURCE[0]})"
REPO_DIR="$THIS_PATH"
CONFIG_DIR="$REPO_DIR/config"

PATH="$REPO_DIR/setup-tools:$PATH"

regtest() {
  echo "$1" | grep -E "$2" > /dev/null
  return $?
}

usage() { echo "Usage: $0 [-h] [-n] [-s <scrip1,script2,etc.>]" 1>&2; exit 1; }

while getopts ":hns:" o; do
  case "${o}" in
    n)
      dry_run=1
      ;;
    s)
      scripts="${OPTARG}"
      ;;
    *)
      usage
      ;;
  esac
done
shift $((OPTIND-1))

if [[ ! -z "$dry_run" ]]; then echo "Dry run..."; fi

if [[ ! -z "$scripts" ]]; then
  prettyScripts="$(echo ",$scripts" | sed 's/,/\n  /g')"
  echo -e "Only running the following scripts:$prettyScripts"
fi

for script in $REPO_DIR/setup.d/*; do
  script_basename="$(basename "$script")"
  script_name="${script_basename#*_}"
  script_name="${script_name%.*}"
  if [[ ! ",$scripts," =~ ",$script_name," ]]; then
    continue
  fi
  
  if regtest "$script_basename" '^[[:digit:]]{2}s_'; then
    if [[ ! -z "$dry_run" ]]; then echo "Would run [$script] with sudo."; continue; fi
    sudo PATH="$PATH" REPO_DIR="$REPO_DIR" CONFIG_DIR="$CONFIG_DIR/$script_name" "$script"
  else
    if [[ ! -z "$dry_run" ]]; then echo "Would run [$script]."; continue; fi
    PATH="$PATH" REPO_DIR="$REPO_DIR" CONFIG_DIR="$CONFIG_DIR/$script_name" "$script"
  fi
done
