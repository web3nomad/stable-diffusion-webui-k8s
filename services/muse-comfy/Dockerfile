FROM pytorch/pytorch:2.4.1-cuda12.1-cudnn9-runtime

ENV DEBIAN_FRONTEND=noninteractive PIP_PREFER_BINARY=1

# uncomment when using in China mainland
# RUN sed -i "s@archive.ubuntu.com@mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list && \
# 	sed -i "s@security.ubuntu.com@mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list

RUN apt-get update && \
  apt-get install -y git wget aria2 parallel vim python3-opencv ffmpeg && \
  apt-get clean

ENV ROOT=/app/ComfyUI
ENV COMMIT=0c7c98a965bff25f9398a4b28dfc274bedad9f6c
ENV PORT=8188
ENV CLI_ARGS=""
ENV DATA_MOUNT_ROOT=/network

# install requirements
RUN --mount=type=cache,target=/root/.cache/pip \
  git clone https://github.com/comfyanonymous/ComfyUI.git ${ROOT} && \
  cd ${ROOT} && \
  git reset --hard ${COMMIT} && \
  pip install -r requirements.txt

# install xformers
RUN --mount=type=cache,target=/root/.cache/pip \
  pip install xformers --index-url https://download.pytorch.org/whl/cu121 \
  --extra-index-url https://pypi.org/simple

WORKDIR ${ROOT}

COPY ./builder-scripts /docker/builder-scripts

# clone pre-defined custom-nodes and install requirements
RUN --mount=type=cache,target=/root/.cache/pip \
  chmod +x /docker/builder-scripts/custom_nodes.sh && \
  /docker/builder-scripts/custom_nodes.sh /docker/builder-scripts/custom_nodes.txt ${ROOT}/custom_nodes

COPY ./entrypoint.sh /docker/entrypoint.sh
COPY ./runner-scripts /docker/runner-scripts

# get comfy-router
RUN wget -O /app/comfy-router \
  https://github.com/bmrlab/comfy-router/releases/download/v0.2.0/comfy-router-x86_64-unknown-linux-gnu && \
  chmod +x /app/comfy-router

RUN chmod +x /docker/entrypoint.sh
ENTRYPOINT ["/docker/entrypoint.sh"]

CMD python main.py --listen --port ${PORT} ${CLI_ARGS}
