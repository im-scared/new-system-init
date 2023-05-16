#!/bin/bash

header "Configuring SSH key"

key_file="$HOME/.ssh/id_rsa"

if [[ -f "$key_file" ]]; then
  echo "SSH key already exists."
else
  echo "SSH key does not exist. Generating a new one..."
  ssh-keygen -N '' -f "$key_file"
fi

cat <<NOTICE


If you have not added your SSH key to your github account, yet, please do so now by navigating to:

  https://github.com/settings/keys

key:
$(cat "${key_file}.pub")


NOTICE
