#!/bin/bash

set -Eeuox pipefail

mkdir -p /repositories/"$1"
cd /repositories/"$1"
git init
git remote add origin "$2"
git fetch origin "$3" --depth=1
git reset --hard "$3"

# rm -rf .git
# DO NOT REMOVE /.git, see https://github.com/lllyasviel/Fooocus/blob/b42e96a52d92265fb966954090aa43340f199008/modules/launch_util.py#L41
