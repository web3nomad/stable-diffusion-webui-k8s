FROM python:3.10.9-slim

ENV DEBIAN_FRONTEND=noninteractive PIP_PREFER_BINARY=1

RUN --mount=type=cache,target=/var/cache/apt \
  apt-get update && \
  # we need those
  apt-get install -y fonts-dejavu-core rsync git jq moreutils aria2 \
  # extensions needs those
  ffmpeg libglfw3-dev libgles2-mesa-dev pkg-config libcairo2 libcairo2-dev build-essential

RUN --mount=type=cache,target=/root/.cache/pip \
  pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

# install stable-fast
# RUN aria2c -x 5 --dir / --out stable_fast-0.0.13.post3+torch210cu118-cp310-cp310-manylinux2014_x86_64.whl 'https://github.com/chengzeyi/stable-fast/releases/download/v0.0.13.post3/stable_fast-0.0.13.post3+torch210cu118-cp310-cp310-manylinux2014_x86_64.whl'
# RUN pip3 install /stable_fast-0.0.13.post3+torch210cu118-cp310-cp310-manylinux2014_x86_64.whl
RUN aria2c -x 5 --dir / --out stable_fast-0.0.13.post3+torch210cu121-cp310-cp310-manylinux2014_x86_64.whl 'https://github.com/chengzeyi/stable-fast/releases/download/v0.0.13.post3/stable_fast-0.0.13.post3+torch210cu121-cp310-cp310-manylinux2014_x86_64.whl'
RUN pip3 install /stable_fast-0.0.13.post3+torch210cu121-cp310-cp310-manylinux2014_x86_64.whl

# install xformers and triton
RUN --mount=type=cache,target=/root/.cache/pip \
  pip3 install xformers triton

RUN --mount=type=cache,target=/root/.cache/pip \
  git clone https://github.com/bmrlab/muse-lcm.git /muse-lcm && \
  cd /muse-lcm && \
  git reset --hard 3204e428874750e8f72bf7d814512bf2175bfd8e && \
  pip3 install -r requirements.txt

COPY . /docker

WORKDIR /muse-lcm
ENV NVIDIA_VISIBLE_DEVICES=all
ENV PYTHONUNBUFFERED 1

EXPOSE 8080

CMD ["python3", "main.py"]
