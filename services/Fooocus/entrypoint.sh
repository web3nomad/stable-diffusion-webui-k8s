#!/bin/bash

set -Eeuo pipefail

mkdir -p /data/models/checkpoints
mkdir -p /data/models/loras
mkdir -p /data/models/inpaint
mkdir -p /data/models/vae_approx
mkdir -p /data/models/upscale_models
mkdir -p /data/models/prompt_expansion

rsync -a --info=NAME /Fooocus/models/prompt_expansion/ /data/models/prompt_expansion/

rm -rf /Fooocus/models/checkpoints
rm -rf /Fooocus/models/loras
rm -rf /Fooocus/models/inpaint
rm -rf /Fooocus/models/vae_approx
rm -rf /Fooocus/models/upscale_models
rm -rf /Fooocus/models/prompt_expansion

ln -s /data/models/checkpoints /Fooocus/models/checkpoints
ln -s /data/models/loras /Fooocus/models/loras
ln -s /data/models/inpaint /Fooocus/models/inpaint
ln -s /data/models/vae_approx /Fooocus/models/vae_approx
ln -s /data/models/upscale_models /Fooocus/models/upscale_models
ln -s /data/models/prompt_expansion /Fooocus/models/prompt_expansion

exec "$@"
