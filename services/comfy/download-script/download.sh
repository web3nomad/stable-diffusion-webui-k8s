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
  /data/comfy/models/unet \

echo "Updating ComfyUI..."
cd /stable-diffusion
git pull

echo "Clone the repositories of custom nodes..."
./clone.sh comfyui-tooling-nodes https://github.com/Acly/comfyui-tooling-nodes.git
./clone.sh efficiency-nodes-comfyui https://github.com/jags111/efficiency-nodes-comfyui.git
./clone.sh ComfyUI_Base64_Image https://github.com/web3nomad/ComfyUI_Base64_Image.git
./clone.sh ComfyUI_Invisible_Watermark https://github.com/web3nomad/ComfyUI_Invisible_Watermark.git
./clone.sh ComfyUI_Comfyroll_CustomNodes https://github.com/Suzie1/ComfyUI_Comfyroll_CustomNodes.git
./clone.sh ComfyUI-BrushNet https://github.com/nullquant/ComfyUI-BrushNet.git
./clone.sh ComfyUI-Easy-Use https://github.com/yolain/ComfyUI-Easy-Use.git
# ./clone.sh ComfyUI-Manager https://github.com/ltdrdata/ComfyUI-Manager.git
./clone.sh rgthree-comfy https://github.com/rgthree/rgthree-comfy.git
./clone.sh comfyui-mixlab-nodes https://github.com/shadowcz007/comfyui-mixlab-nodes.git
# ./clone.sh ComfyUI_IPAdapter_plus https://github.com/cubiq/ComfyUI_IPAdapter_plus.git
./clone.sh comfyui-art-venture https://github.com/sipherxyz/comfyui-art-venture.git
./clone.sh ComfyUI_IPAdapter_plus https://github.com/owenrao/ComfyUI_IPAdapter_plus.git # Made customization through forking, pull request not yet replied by the author
./clone.sh ComfyUI_LayerStyle https://github.com/chflame163/ComfyUI_LayerStyle.git
./clone.sh ComfyUI-KJNodes https://github.com/kijai/ComfyUI-KJNodes.git
./clone.sh ComfyUI-IC-Light-Native https://github.com/huchenlei/ComfyUI-IC-Light-Native.git
./clone.sh ComfyUI-IC-Light https://github.com/kijai/ComfyUI-IC-Light.git
./clone.sh comfyui_controlnet_aux https://github.com/Fannovel16/comfyui_controlnet_aux/
./clone.sh was-node-suite-comfyui https://github.com/WASasquatch/was-node-suite-comfyui.git
./clone.sh comfyUI_FrequencySeparation_RGB-HSV https://github.com/risunobushi/comfyUI_FrequencySeparation_RGB-HSV.git
./clone.sh ComfyUI-Image-Filters https://github.com/spacepxl/ComfyUI-Image-Filters.git
./clone.sh ComfyUI-Custom-Scripts https://github.com/pythongosssss/ComfyUI-Custom-Scripts.git
./clone.sh ComfyUI_essentials https://github.com/cubiq/ComfyUI_essentials.git
./clone.sh ComfyUI_AdvancedRefluxControl https://github.com/kaibioinfo/ComfyUI_AdvancedRefluxControl.git
echo "Downloading, this might take a while..."

aria2c -x 10 --disable-ipv6 --input-file ./links.txt --dir /data/comfy --continue

echo "Checking SHAs..."

parallel --will-cite -a ./checksums.sha256 "echo -n {} | sha256sum -c"
