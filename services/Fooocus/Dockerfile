FROM python:3.10.9-slim

ENV DEBIAN_FRONTEND=noninteractive PIP_PREFER_BINARY=1

RUN --mount=type=cache,target=/var/cache/apt \
  apt-get update && \
  # we need those
  apt-get install -y fonts-dejavu-core rsync git jq moreutils aria2 \
  # extensions needs those
  ffmpeg libglfw3-dev libgles2-mesa-dev pkg-config libcairo2 libcairo2-dev build-essential

RUN --mount=type=cache,target=/root/.cache/pip \
  pip3 install torch==2.1.0 torchvision==0.16.0 torchaudio==2.1.0 --index-url https://download.pytorch.org/whl/cu121

RUN --mount=type=cache,target=/root/.cache/pip \
    git clone https://github.com/bmrlab/Fooocus.git /Fooocus && \
    cd /Fooocus && \
    git reset --hard 26823aa27091fe61af13666d9cf0f15610939540 && \
    pip3 install -r requirements_versions.txt && \
    pip3 install -r requirements_api.txt

COPY . /docker

WORKDIR /Fooocus
ENV NVIDIA_VISIBLE_DEVICES=all
ENV PYTHONUNBUFFERED 1

ENV CLI_ARGS="--disable-xformers --unet-in-fp16 --clip-in-fp16"

ENTRYPOINT ["/docker/entrypoint.sh"]
CMD python3 api.py ${CLI_ARGS}
