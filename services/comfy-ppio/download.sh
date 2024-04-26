#!/usr/bin/env bash

set -Eeuo pipefail

# TODO: maybe just use the .gitignore file to create all of these
mkdir -vp /data/.cache \
  /data/embeddings \
  /data/config/ \
  /data/models/ \
  /data/models/Stable-diffusion \
  /data/models/GFPGAN \
  /data/models/RealESRGAN \
  /data/models/LDSR \
  /data/models/VAE \
  /data/models/ControlNet \
  /data/config/auto/extensions

echo "Downloading, this might take a while..."

echo 'git clone start-------------'
# 如果不存在sd-webui-controlnet 就clone
if [ ! -d "/data/config/auto/extensions/sd-webui-controlnet" ]; then
  ./clone.sh sd-webui-controlnet https://github.com/Mikubill/sd-webui-controlnet.git 5ae9b4a1a0c7d9a2938e75aaf052ab078623066f
fi

# ultimate sd upscale
if [ ! -d "/data/config/auto/extensions/ultimate-upscale-for-automatic1111" ]; then
  ./clone.sh ultimate-upscale-for-automatic1111 https://github.com/Coyote-A/ultimate-upscale-for-automatic1111.git 728ffcec7fa69c83b9e653bf5b96932acdce750f
fi

aria2c -x 10 --disable-ipv6 --input-file /docker/links.txt --dir /data --continue

echo "Checking SHAs..."

parallel --will-cite -a /docker/checksums.sha256 "echo -n {} | sha256sum -c"

cat <<EOF
By using this software, you agree to the following licenses:
https://github.com/AbdBarho/stable-diffusion-webui-docker/blob/master/LICENSE
https://github.com/CompVis/stable-diffusion/blob/main/LICENSE
https://github.com/AUTOMATIC1111/stable-diffusion-webui/blob/master/LICENSE.txt
https://github.com/invoke-ai/InvokeAI/blob/main/LICENSE
And licenses of all UIs, third party libraries, and extensions.
EOF
