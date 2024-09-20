#!/bin/bash

set -Eeuo pipefail

rm -rf /app/ComfyUI/models
rm -rf /app/ComfyUI/input
rm -rf /app/ComfyUI/custom_nodes/comfyui_controlnet_aux/ckpts

if [ ! -d "$DATA_MOUNT_ROOT/models" ]; then
  mkdir -p "$DATA_MOUNT_ROOT/models"
fi
ln -s "$DATA_MOUNT_ROOT/models" /app/ComfyUI/models

if [ ! -d "$DATA_MOUNT_ROOT/models/controlnet_aux" ]; then
  mkdir -p "$DATA_MOUNT_ROOT/models/controlnet_aux"
fi
ln -s "$DATA_MOUNT_ROOT/models/controlnet_aux" /app/ComfyUI/custom_nodes/comfyui_controlnet_aux/ckpts

if [ ! -d "$DATA_MOUNT_ROOT/models/input" ]; then
  mkdir -p "$DATA_MOUNT_ROOT/models/input"
fi
ln -s "$DATA_MOUNT_ROOT/models/input" /app/ComfyUI/input

/app/comfy-router &

exec "$@"
