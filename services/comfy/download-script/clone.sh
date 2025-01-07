#!/usr/bin/env bash

set -Eeuox pipefail

if [ ! -d "/data/comfy/config/custom_nodes/$1" ]; then
  mkdir -p /data/comfy/config/custom_nodes/"$1"
fi
cd /data/comfy/config/custom_nodes/"$1"
git init
git remote add origin "$2"
git fetch origin
git reset --hard origin/HEAD
rm -rf .git