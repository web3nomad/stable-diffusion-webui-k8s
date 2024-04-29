#!/usr/bin/env bash

set -Eeuo pipefail

# TODO: maybe just use the .gitignore file to create all of these
mkdir -vp \
  /data/embeddings \
  /data/models/ \
  /data/models/Stable-diffusion \
  /data/models/GFPGAN \
  /data/models/RealESRGAN \
  /data/models/LDSR \
  /data/models/VAE \
  /data/models/ControlNet \

echo "Clone the repositories of custom nodes..."

./clone.sh comfyui-tooling-nodes https://github.com/Acly/comfyui-tooling-nodes.git 7fc46f18f9f9751865588a9c74d0e058ba7afd90
./clone.sh efficiency-nodes-comfyui https://github.com/jags111/efficiency-nodes-comfyui.git b0ab993a33f5bec86b13806dcc1a9b41b76cb174
./clone.sh ComfyUI_Base64_Image https://github.com/web3nomad/ComfyUI_Base64_Image.git 1bf9bc2237e800f8c2058310d6dc8bca1d92b40c
./clone.sh ComfyUI_Invisible_Watermark https://github.com/web3nomad/ComfyUI_Invisible_Watermark.git f5eeaff9e36d1cc51f1d21a0e881316536e26466

echo "Downloading, this might take a while..."

aria2c -x 10 --disable-ipv6 --input-file /docker/links.txt --dir /data --continue

echo "Checking SHAs..."

parallel --will-cite -a /docker/checksums.sha256 "echo -n {} | sha256sum -c"
