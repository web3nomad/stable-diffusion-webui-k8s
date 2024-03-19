FROM alpine:3.17 as xformers
RUN apk add --no-cache aria2
RUN aria2c -x 5 --dir / --out wheel.whl 'https://github.com/AbdBarho/stable-diffusion-webui-docker/releases/download/6.0.0/xformers-0.0.21.dev544-cp310-cp310-manylinux2014_x86_64-pytorch201.whl'


FROM python:3.10.9-slim

ENV DEBIAN_FRONTEND=noninteractive PIP_PREFER_BINARY=1

RUN apt-get update -y && \
	apt-get install -y curl libgl1 libglib2.0-0 python3-pip python-is-python3 git && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN --mount=type=cache,target=/cache --mount=type=cache,target=/root/.cache/pip \
  aria2c -x 5 --dir /cache --out torch-2.0.1-cp310-cp310-linux_x86_64.whl -c \
  https://download.pytorch.org/whl/cu118/torch-2.0.1%2Bcu118-cp310-cp310-linux_x86_64.whl && \
  pip install /cache/torch-2.0.1-cp310-cp310-linux_x86_64.whl torchvision --index-url https://download.pytorch.org/whl/cu118

RUN --mount=type=cache,target=/root/.cache/pip \
    git clone https://github.com/bmrlab/Fooocus.git /Fooocus && \
    cd /Fooocus && \
    git reset --hard 11c7d8030884755033338d94f1cf8321b37d19ff && \
    pip3 install -r requirements_versions.txt && \
    pip3 install -r requirements_docker.txt && \
    pip3 install -r requirements_api.txt

RUN --mount=type=cache,target=/root/.cache/pip  \
  --mount=type=bind,from=xformers,source=/wheel.whl,target=/xformers-0.0.21.dev544-cp310-cp310-manylinux2014_x86_64.whl \
  pip install /xformers-0.0.21.dev544-cp310-cp310-manylinux2014_x86_64.whl

# 这里不太清楚是不是需要，但是Fooocus更新的Dockerfile里有，先复制过来
RUN curl -fsL -o /usr/local/lib/python3.10/dist-packages/gradio/frpc_linux_amd64_v0.2 https://cdn-media.huggingface.co/frpc-gradio-0.2/frpc_linux_amd64 && \
	chmod +x /usr/local/lib/python3.10/dist-packages/gradio/frpc_linux_amd64_v0.2

COPY . /docker

WORKDIR /Fooocus
ENV NVIDIA_VISIBLE_DEVICES=all
ENV PYTHONUNBUFFERED 1

ENV CLI_ARGS=""

ENTRYPOINT ["/docker/entrypoint.sh"]
CMD python3 api.py ${CLI_ARGS}
