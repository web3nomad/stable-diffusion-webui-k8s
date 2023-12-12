FROM python:3.10.9-slim

ENV DEBIAN_FRONTEND=noninteractive PIP_PREFER_BINARY=1

RUN --mount=type=cache,target=/var/cache/apt \
  apt-get update && \
  # we need those
  apt-get install -y fonts-dejavu-core rsync git jq moreutils aria2 \
  # extensions needs those
  ffmpeg python-dev libglfw3-dev libgles2-mesa-dev pkg-config libcairo2 libcairo2-dev build-essential && \
  apt-get clean

RUN --mount=type=cache,target=/root/.cache/pip \
  pip3 install torch==2.1.0 torchvision==0.16.0 torchaudio==2.1.0 --index-url https://download.pytorch.org/whl/cu121

# install stable-fast
RUN aria2c -x 5 --dir / --out stable_fast-0.0.13.post3+torch210cu121-cp310-cp310-manylinux2014_x86_64.whl 'https://github.com/chengzeyi/stable-fast/releases/download/v0.0.13.post3/stable_fast-0.0.13.post3+torch210cu121-cp310-cp310-manylinux2014_x86_64.whl'
RUN pip3 install /stable_fast-0.0.13.post3+torch210cu121-cp310-cp310-manylinux2014_x86_64.whl

# install triton
RUN --mount=type=cache,target=/root/.cache/pip \
  pip3 install triton
# install xformers
RUN --mount=type=cache,target=/root/.cache/pip \
  pip3 install -U xformers --index-url https://download.pytorch.org/whl/cu121

ENV ROOT=/stable-diffusion
RUN --mount=type=cache,target=/root/.cache/pip \
  git clone https://github.com/comfyanonymous/ComfyUI.git ${ROOT} && \
  cd ${ROOT} && \
  git reset --hard 777f6b15225197898a5f49742682a2be859072d7 && \
  python -m pip install -U pip && \
  pip3 install -U setuptools && \
  pip3 install -r requirements.txt && \
  pip3 install opencv-python matplotlib skimage simpleeval && \
  pip3 install onnx zstandard && \
  pip3 install --pre --upgrade --extra-index-url https://pypi.nvidia.com tensorrt && \
  pip3 install onnx-graphsurgeon polygraphy --extra-index-url https://pypi.ngc.nvidia.com

WORKDIR ${ROOT}

# add info
COPY . /docker/
RUN cp /docker/extra_model_paths.yaml ${ROOT}
RUN chmod u+x /docker/entrypoint.sh
RUN cp /docker/extra_model_paths.yaml ${ROOT}

ENV NVIDIA_VISIBLE_DEVICES=all
ENV PYTHONPATH="${PYTHONPATH}:${PWD}" CLI_ARGS=""
EXPOSE 7860
ENTRYPOINT ["/docker/entrypoint.sh"]
CMD python -u main.py --listen --port 7860 ${CLI_ARGS}
