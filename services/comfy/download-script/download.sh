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
./clone.sh comfyui-tooling-nodes https://github.com/Acly/comfyui-tooling-nodes.git e0d0c3cc2cbb1e055014d0b27851e61dd24748e4
./clone.sh efficiency-nodes-comfyui https://github.com/jags111/efficiency-nodes-comfyui.git 3ead4afd120833f3bffdefeca0d6545df8051798 
./clone.sh ComfyUI_Base64_Image https://github.com/web3nomad/ComfyUI_Base64_Image.git 1bf9bc2237e800f8c2058310d6dc8bca1d92b40c
./clone.sh ComfyUI_Invisible_Watermark https://github.com/web3nomad/ComfyUI_Invisible_Watermark.git f5eeaff9e36d1cc51f1d21a0e881316536e26466
./clone.sh ComfyUI_Comfyroll_CustomNodes https://github.com/Suzie1/ComfyUI_Comfyroll_CustomNodes.git d78b780ae43fcf8c6b7c6505e6ffb4584281ceca
./clone.sh ComfyUI-BrushNet https://github.com/nullquant/ComfyUI-BrushNet.git a510effde1ba9df8324f80bb5fc684b5a62792d4
./clone.sh ComfyUI-Easy-Use https://github.com/yolain/ComfyUI-Easy-Use.git e9439f0dc00656690ce5d46ce14df31ebcc4f729
# ./clone.sh ComfyUI-Manager https://github.com/ltdrdata/ComfyUI-Manager.git 1577682fb9a61f413fe28e8e3899c45f6d52a866
./clone.sh rgthree-comfy https://github.com/rgthree/rgthree-comfy.git cae8e2ad28ddb933a916b852d26b95726f60529f
./clone.sh comfyui-mixlab-nodes https://github.com/shadowcz007/comfyui-mixlab-nodes.git d94a8af35be34bbe932375eb17fbd3ba85b9ab72
# ./clone.sh ComfyUI_IPAdapter_plus https://github.com/cubiq/ComfyUI_IPAdapter_plus.git df8c78b6bfe8450bdeed1209dfb3f94c9c59773a
./clone.sh comfyui-art-venture https://github.com/sipherxyz/comfyui-art-venture.git c241bdb6ff009fd9a51125d480ce46e7593ae332
./clone.sh ComfyUI_IPAdapter_plus https://github.com/owenrao/ComfyUI_IPAdapter_plus.git 8cde9c212b37df7e90a290c26c7fc578ea20e143 # Made customization through forking, pull request not yet replied by the author
./clone.sh ComfyUI_LayerStyle https://github.com/chflame163/ComfyUI_LayerStyle.git c4368ba7352d4bf0de5bf3d349e525ea2d6abf2a
./clone.sh ComfyUI-KJNodes https://github.com/kijai/ComfyUI-KJNodes.git 7aa591b3a64a3f83ec2c3e92758d0bb0926a6fe0
./clone.sh ComfyUI-IC-Light-Native https://github.com/huchenlei/ComfyUI-IC-Light-Native.git cdc61bc84445a5c48144e33907eabf96bdf2dd52
./clone.sh ComfyUI-IC-Light https://github.com/kijai/ComfyUI-IC-Light.git 8a9f9c92c155e754a05840c7621443c5919a9b25
./clone.sh comfyui_controlnet_aux https://github.com/Fannovel16/comfyui_controlnet_aux/ 302a3891d15b4285d9c9e0a00f4d8daa2eb46f25
./clone.sh was-node-suite-comfyui https://github.com/WASasquatch/was-node-suite-comfyui.git df5133b59adf9b4c3841633462ce8ed900118647
./clone.sh comfyUI_FrequencySeparation_RGB-HSV https://github.com/risunobushi/comfyUI_FrequencySeparation_RGB-HSV.git 67a08c55ee6aa8e9140616f01497bd54d3533fa6
./clone.sh ComfyUI-Image-Filters https://github.com/spacepxl/ComfyUI-Image-Filters.git 8ba3fbd46c9ee17553717b4d18aed1a7da37d38d

echo "Downloading, this might take a while..."

aria2c -x 10 --disable-ipv6 --input-file ./links.txt --dir /data/comfy --continue

echo "Checking SHAs..."

parallel --will-cite -a ./checksums.sha256 "echo -n {} | sha256sum -c"
