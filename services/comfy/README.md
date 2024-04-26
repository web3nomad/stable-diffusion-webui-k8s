# Comfy

参考了 https://github.com/AbdBarho/stable-diffusion-webui-docker/tree/master/services/comfy


## 初始化

### 1. 下载模型

部署 `download-script` 服务，挂载 `/data` 目录，然后运行 `/docker/download.sh`。

`download-script` 的 CMD 是个一次性的 job 命令，需要修改启动命令为 `bash -c "sleep 3600"` 才能常驻，方便进入容器。
