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
./clone.sh efficiency-nodes-comfyui https://github.com/jags111/efficiency-nodes-comfyui.git a6df20f4c60af49f08bbe122bc486c286f5d0745
./clone.sh ComfyUI_Base64_Image https://github.com/web3nomad/ComfyUI_Base64_Image.git 1bf9bc2237e800f8c2058310d6dc8bca1d92b40c
./clone.sh ComfyUI_Invisible_Watermark https://github.com/web3nomad/ComfyUI_Invisible_Watermark.git f5eeaff9e36d1cc51f1d21a0e881316536e26466
./clone.sh ComfyUI_Comfyroll_CustomNodes https://github.com/Suzie1/ComfyUI_Comfyroll_CustomNodes.git d78b780ae43fcf8c6b7c6505e6ffb4584281ceca
./clone.sh ComfyUI-BrushNet https://github.com/nullquant/ComfyUI-BrushNet.git dbd64b46bfbf13ea6b5f27c0109f09e9b59db076
./clone.sh ComfyUI-Easy-Use https://github.com/yolain/ComfyUI-Easy-Use.git 119f706779789ab34ad60e77995999f4e5b6c115
# ./clone.sh ComfyUI-Manager https://github.com/ltdrdata/ComfyUI-Manager.git 1577682fb9a61f413fe28e8e3899c45f6d52a866
./clone.sh rgthree-comfy https://github.com/rgthree/rgthree-comfy.git 2613da28c639b90b310e35c6ffde9ee0a3d60bfe
./clone.sh comfyui-mixlab-nodes https://github.com/shadowcz007/comfyui-mixlab-nodes.git 6d004c61fc3d971375fde6a428e9ec88dbe15e2d
# ./clone.sh ComfyUI_IPAdapter_plus https://github.com/cubiq/ComfyUI_IPAdapter_plus.git df8c78b6bfe8450bdeed1209dfb3f94c9c59773a
./clone.sh comfyui-art-venture https://github.com/sipherxyz/comfyui-art-venture.git c241bdb6ff009fd9a51125d480ce46e7593ae332
./clone.sh ComfyUI_IPAdapter_plus https://github.com/owenrao/ComfyUI_IPAdapter_plus_with_toggle.git 9ae2d24fbffd426a1c8886dc9487351a8f936d35 # Made customization through forking, pull request not yet replied by the author
./clone.sh ComfyUI_LayerStyle https://github.com/owenrao/ComfyUI_LayerStyle.git 7014e87a80b1af69a8e645e5e2434178750bf9e6 # Made customization through forking, pull request not yet replied by the author

echo "Downloading, this might take a while..."

aria2c -x 10 --disable-ipv6 --input-file ./links.txt --dir /data/comfy --continue

echo "Checking SHAs..."

parallel --will-cite -a ./checksums.sha256 "echo -n {} | sha256sum -c"
