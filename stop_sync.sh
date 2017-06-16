#!/bin/bash

kill -2 $(ps | grep guard | grep -v grep | cut -d' ' -f1) > /dev/null 2>&1
echo "Guard processes terminated"
