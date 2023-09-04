FROM alpine/git:2.36.2 as download
COPY clone.sh /clone.sh
RUN . /clone.sh ComfyUI-from-StabilityAI-Official https://github.com/comfyanonymous/ComfyUI.git 2bc12d3d22efb5c63ae3a7fc342bb2dd16b31735


FROM alpine:3.17 as xformers
RUN apk add --no-cache aria2
RUN aria2c -x 5 --dir / --out wheel.whl 'https://github.com/AbdBarho/stable-diffusion-webui-docker/releases/download/6.0.0/xformers-0.0.21.dev544-cp310-cp310-manylinux2014_x86_64-pytorch201.whl'


# FROM nvidia/cuda:12.2.0-runtime-ubuntu22.04

# RUN --mount=type=cache,target=/var/cache/apt \
#     apt-get update && \
#     apt-get install --no-install-recommends -y python3 python3-pip python3-dev python3-venv git && \
#     rm -rf /var/lib/apt/lists/*

# RUN python3 -m venv /venv

FROM python:3.10.9-slim

ENV DEBIAN_FRONTEND=noninteractive PIP_PREFER_BINARY=1

RUN --mount=type=cache,target=/var/cache/apt \
  apt-get update && \
  # we need those
  apt-get install -y fonts-dejavu-core rsync git jq moreutils aria2 \
  # extensions needs those
  ffmpeg libglfw3-dev libgles2-mesa-dev pkg-config libcairo2 libcairo2-dev build-essential

RUN --mount=type=cache,target=/cache --mount=type=cache,target=/root/.cache/pip \
  aria2c -x 5 --dir /cache --out torch-2.0.1-cp310-cp310-linux_x86_64.whl -c \
  https://download.pytorch.org/whl/cu118/torch-2.0.1%2Bcu118-cp310-cp310-linux_x86_64.whl && \
  pip install /cache/torch-2.0.1-cp310-cp310-linux_x86_64.whl torchvision --index-url https://download.pytorch.org/whl/cu118

RUN --mount=type=cache,target=/root/.cache/pip \
    git clone https://github.com/lllyasviel/Fooocus.git /Fooocus && \
    cd /Fooocus && \
    git reset --hard 09e0d1cb3ae5a1d74443009a41da9f96c1b54683 && \
    # . /venv/bin/activate && \
    # pip3 install --upgrade pip && \
    pip3 install -r requirements_versions.txt

RUN --mount=type=cache,target=/root/.cache/pip  \
  --mount=type=bind,from=xformers,source=/wheel.whl,target=/xformers-0.0.21.dev544-cp310-cp310-manylinux2014_x86_64.whl \
  pip install /xformers-0.0.21.dev544-cp310-cp310-manylinux2014_x86_64.whl

COPY --from=download /repositories/ /Fooocus/repositories/

WORKDIR /Fooocus

# ENTRYPOINT [ "bash", "-c", ". /venv/bin/activate && exec \"$@\"", "--" ]
CMD [ "python3", "launch.py", "--listen" ]
