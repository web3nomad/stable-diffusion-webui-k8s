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

# install stable-fast
# RUN aria2c -x 5 --dir / --out stable_fast-0.0.13.post3+torch210cu118-cp310-cp310-manylinux2014_x86_64.whl 'https://github.com/chengzeyi/stable-fast/releases/download/v0.0.13.post3/stable_fast-0.0.13.post3+torch210cu118-cp310-cp310-manylinux2014_x86_64.whl'
# RUN pip3 install /stable_fast-0.0.13.post3+torch210cu118-cp310-cp310-manylinux2014_x86_64.whl
RUN aria2c -x 5 --dir / --out stable_fast-0.0.13.post3+torch210cu121-cp310-cp310-manylinux2014_x86_64.whl 'https://github.com/chengzeyi/stable-fast/releases/download/v0.0.13.post3/stable_fast-0.0.13.post3+torch210cu121-cp310-cp310-manylinux2014_x86_64.whl'
RUN pip3 install /stable_fast-0.0.13.post3+torch210cu121-cp310-cp310-manylinux2014_x86_64.whl

# install triton
RUN --mount=type=cache,target=/root/.cache/pip \
  pip3 install triton
# install xformers
RUN --mount=type=cache,target=/root/.cache/pip \
  pip3 install -U xformers --index-url https://download.pytorch.org/whl/cu121

RUN --mount=type=cache,target=/root/.cache/pip \
  git clone https://github.com/bmrlab/muse-lcm.git /muse-lcm && \
  cd /muse-lcm && \
  git reset --hard a4d944bf0d0942548df1943bb57cde8645594cea && \
  pip3 install -r requirements.txt

COPY . /docker

WORKDIR /muse-lcm
ENV NVIDIA_VISIBLE_DEVICES=all
ENV PYTHONUNBUFFERED 1

EXPOSE 8080

CMD ["python3", "main.py"]
