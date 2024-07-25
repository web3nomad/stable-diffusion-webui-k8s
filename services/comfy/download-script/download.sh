#!/usr/bin/env bash

set -Eeuo pipefail

# TODO: maybe just use the .gitignore file to create all of these
mkdir -vp \
  /data/comfy/embeddings \
  /data/comfy/models/ \
  /data/comfy/models/Stable-diffusion \
  /data/comfy/models/GFPGAN \
  /data/comfy/models/RealESRGAN \
  /data/comfy/models/LDSR \
  /data/comfy/models/VAE \
  /data/comfy/models/ControlNet \

echo "Clone the repositories of custom nodes..."

./clone.sh comfyui-tooling-nodes https://github.com/Acly/comfyui-tooling-nodes.git 7fc46f18f9f9751865588a9c74d0e058ba7afd90
./clone.sh efficiency-nodes-comfyui https://github.com/jags111/efficiency-nodes-comfyui.git b0ab993a33f5bec86b13806dcc1a9b41b76cb174
./clone.sh ComfyUI_Base64_Image https://github.com/web3nomad/ComfyUI_Base64_Image.git 1bf9bc2237e800f8c2058310d6dc8bca1d92b40c
./clone.sh ComfyUI_Invisible_Watermark https://github.com/web3nomad/ComfyUI_Invisible_Watermark.git f5eeaff9e36d1cc51f1d21a0e881316536e26466
./clone.sh ComfyUI_Comfyroll_CustomNodes https://github.com/Suzie1/ComfyUI_Comfyroll_CustomNodes.git d78b780ae43fcf8c6b7c6505e6ffb4584281ceca
./clone.sh ComfyUI-BrushNet https://github.com/nullquant/ComfyUI-BrushNet.git dbd64b46bfbf13ea6b5f27c0109f09e9b59db076
./clone.sh ComfyUI-Easy-Use https://github.com/yolain/ComfyUI-Easy-Use.git 119f706779789ab34ad60e77995999f4e5b6c115
./clone.sh ComfyUI-Manager https://github.com/ltdrdata/ComfyUI-Manager.git 1577682fb9a61f413fe28e8e3899c45f6d52a866
./clone.sh rgthree-comfy https://github.com/rgthree/rgthree-comfy.git 2613da28c639b90b310e35c6ffde9ee0a3d60bfe

echo "Downloading, this might take a while..."

aria2c -x 10 --disable-ipv6 --input-file /docker/links.txt --dir /data/comfy --continue

echo "Checking SHAs..."

parallel --will-cite -a /docker/checksums.sha256 "echo -n {} | sha256sum -c"
