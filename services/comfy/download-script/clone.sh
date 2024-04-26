#!/usr/bin/env bash

set -Eeuox pipefail

if [ ! -d "/data/config/comfy/custom_nodes/$1" ]; then
  mkdir -p /data/config/comfy/custom_nodes/"$1"
  cd /data/config/comfy/custom_nodes/"$1"
  git init
  git remote add origin "$2"
  git fetch origin "$3" --depth=1
  git reset --hard "$3"
  rm -rf .git
fi
