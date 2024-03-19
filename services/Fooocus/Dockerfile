FROM python:3.10.9-slim

ENV DEBIAN_FRONTEND=noninteractive PIP_PREFER_BINARY=1

RUN apt-get update -y && \
	apt-get install -y curl libgl1 libglib2.0-0 python3-pip python-is-python3 git rsync jq moreutils && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN --mount=type=cache,target=/root/.cache/pip \
    git clone https://github.com/bmrlab/Fooocus.git /Fooocus && \
    cd /Fooocus && \
    git reset --hard e97b90b84acafcdfb2b273bbe3e49b7fed9e26c0 && \
    pip3 install -r requirements_docker.txt && \
    pip3 install -r requirements_versions.txt && \
    pip3 install -r requirements_api.txt

RUN --mount=type=cache,target=/root/.cache/pip  \
  pip3 install xformers==0.0.23 --no-dependencies

COPY . /docker

WORKDIR /Fooocus
ENV NVIDIA_VISIBLE_DEVICES=all
ENV PYTHONUNBUFFERED 1

ENV CLI_ARGS=""

ENTRYPOINT ["/docker/entrypoint.sh"]
CMD python3 api.py ${CLI_ARGS}
