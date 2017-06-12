#!/bin/bash -e

KEY="$HOME/.ssh/vagrant_insecure"

if [ ! -f $KEY ]; then
  curl https://s3.amazonaws.com/launchandlearn/twu/vagrant_insecure -o $KEY
  chmod 600 $KEY
  echo "Added vagrant_insecure ssh key to ~/.ssh"
fi

