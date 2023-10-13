#!/bin/bash

set -Eeuo pipefail

for i in checkpoints loras inpaint vae_approx upscale_models prompt_expansion controlnet clip_vision; do
  mkdir -p /data/models/$i
done

rsync -a --info=NAME /Fooocus/models/prompt_expansion/ /data/models/prompt_expansion/

for i in checkpoints loras inpaint vae_approx upscale_models prompt_expansion controlnet clip_vision; do
  rm -rf /Fooocus/models/$i
  ln -s /data/models/$i /Fooocus/models/$i
done

exec "$@"
