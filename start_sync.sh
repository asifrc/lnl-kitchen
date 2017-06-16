#!/bin/bash -e

if [ -z "$1" ]; then
  echo "ERROR: no user/ip passed"
  echo "USAGE: ./start_sync.sh user@192.1.0.0"
  exit 1
fi

./stop_sync.sh

export WORKSTATION_IP=$1
echo "Starting sync with  $WORKSTATION_IP"
( bundle exec guard --no-interactions ) > /dev/null 2>&1  &
echo "Guard process started"
