#!/bin/bash

set -Eeuo pipefail

mkdir -vp /data/comfy/config/custom_nodes

declare -A MOUNTS

MOUNTS["/root/.cache"]="/data/comfy/.cache"
MOUNTS["${ROOT}/input"]="/data/comfy/config/input"
MOUNTS["${ROOT}/output"]="/output/comfy"
MOUNTS["${ROOT}/models/inpaint"]="/data/comfy/models/Inpaint"
MOUNTS["${ROOT}/models/lama"]="/data/lama-eraser-api"
MOUNTS["${ROOT}/models/sams"]="/data/comfy/models/sams"
MOUNTS["${ROOT}/models/bert-base-uncased"]="/data/comfy/models/bert-base-uncased"
MOUNTS["${ROOT}/models/grounding-dino"]="/data/comfy/models/grounding-dino"

for to_path in "${!MOUNTS[@]}"; do
  set -Eeuo pipefail
  from_path="${MOUNTS[${to_path}]}"
  rm -rf "${to_path}"
  if [ ! -f "$from_path" ]; then
    mkdir -vp "$from_path"
  fi
  mkdir -vp "$(dirname "${to_path}")"
  ln -sT "${from_path}" "${to_path}"
  echo Mounted $(basename "${from_path}")
done

if [ -f "/data/comfy/config/startup.sh" ]; then
  pushd ${ROOT}
  . /data/comfy/config/startup.sh
  popd
fi

exec "$@"
