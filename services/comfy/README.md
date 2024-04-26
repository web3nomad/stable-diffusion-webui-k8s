# Comfy

参考了 https://github.com/AbdBarho/stable-diffusion-webui-docker/tree/master/services/comfy


## 初始化

### 1. 下载模型

部署 `download-script` 服务，挂载 `/data` 目录，然后运行 `/docker/download.sh`。
`download-script` 的 CMD 是个一次性的 job 命令，需要修改启动命令为 `bash -c "sleep 3600"` 才能常驻，方便进入容器。

### 2. 只下载 ComfyUI 所需的 models 和 custom nodes

> 单独部署 ComfyUI 的时候，可以忽略 **1. 下载模型** 直接进行这一步

挂载 `/data` 目录依然是必须的。

复制 `download-script` 目录下的 [checksums.sha256](download-script/checksums.sha256) [clone.sh](download-script/clone.sh) [download.sh](download-script/download.sh) [links.txt](download-script/links.txt) 到容器中的 `/docker` 目录下，然后执行 `/docker/download.sh`

```bash
cd /docker

wget https://raw.githubusercontent.com/bmrlab/stable-diffusion-webui-k8s/main/services/comfy/download-script/checksums.sha256
wget https://raw.githubusercontent.com/bmrlab/stable-diffusion-webui-k8s/main/services/comfy/download-script/clone.sh
wget https://raw.githubusercontent.com/bmrlab/stable-diffusion-webui-k8s/main/services/comfy/download-script/download.sh
wget https://raw.githubusercontent.com/bmrlab/stable-diffusion-webui-k8s/main/services/comfy/download-script/links.txt

chmod u+x download.sh
chmod u+x clone.sh

apt-get install parallel

./download.sh
```
