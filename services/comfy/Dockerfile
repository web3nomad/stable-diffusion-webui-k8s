FROM pytorch/pytorch:2.3.0-cuda12.1-cudnn8-runtime

ENV DEBIAN_FRONTEND=noninteractive PIP_PREFER_BINARY=1

RUN apt-get update && \
  apt-get install -y git aria2 parallel ffmpeg libsm6 libxext6 && \
  apt-get clean

ENV ROOT=/stable-diffusion
RUN --mount=type=cache,target=/root/.cache/pip \
  git clone https://github.com/comfyanonymous/ComfyUI.git ${ROOT} && \
  cd ${ROOT} && \
  git checkout master && \
  git reset --hard 00a5d081038b5c64c9076f06a2c95c4dee394e97 && \
  pip install -r requirements.txt

WORKDIR ${ROOT}
COPY . /docker/
RUN chmod u+x /docker/entrypoint.sh && cp /docker/extra_model_paths.yaml ${ROOT}
RUN chmod u+x /docker/download-script/download.sh
RUN chmod u+x /docker/download-script/clone.sh
# install additional requirements for custom nodes
RUN --mount=type=cache,target=/root/.cache/pip \
  pip install -r /docker/download-script/requirements.txt

ENV NVIDIA_VISIBLE_DEVICES=all PYTHONPATH="${PYTHONPATH}:${PWD}" CLI_ARGS="--preview-method auto"
EXPOSE 7860
ENTRYPOINT ["/docker/entrypoint.sh"]
CMD python -u main.py --listen --port 7860 ${CLI_ARGS}
