#!/bin/bash -e

bundler="$(which bundler || echo not installed)"
if [ "$bundler" == "not installed" ]; then
  gem install bundler
fi

bundle install

KEY="$HOME/.ssh/vagrant_insecure"

if [ ! -f $KEY ]; then
  curl https://s3.amazonaws.com/launchandlearn/twu/vagrant_insecure -o $KEY
  chmod 600 $KEY
  echo "Added vagrant_insecure ssh key to ~/.ssh"
fi

