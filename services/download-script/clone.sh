#!/bin/bash

set -Eeuox pipefail

mkdir -p /data/config/auto/extensions/"$1"
cd /data/config/auto/extensions/"$1"
git init
git remote add origin "$2"
git fetch origin "$3" --depth=1
git reset --hard "$3"
rm -rf .git
