
## 说明

这个不只是给 ppio 用的，暂时用 `comfy-ppio` 命名

这个版本包含完整的初始化脚本（包含模型下载），这样不需要依赖于 download-script 的部署

适合 comfy-ppio 等这种 serverless 服务或者单机部署，只需要拉取一个镜像，运行初始化脚本，还支持自定义挂载目录


## PPIO 配置

PPIO 的容器共享一个云存储，挂载的名字是 `ppio_net0`，这个名字没法修改。

### 1. ComfyUI 启动

```bash
bash -c "ln -s /ppio_net0 /data && /docker/entrypoint.sh"
```

如果 Dockerfile 里面没有删掉 `ENTRYPOINT ["/docker/entrypoint.sh"]`，会创建 `/data` 目录，这样要先要删了 `/data`，然后再创建 symlink，最后再重新运行 `/docker/entrypoint.sh`

```bash
bash -c "rm -rf /data && ln -s /ppio_net0 /data && /docker/entrypoint.sh && python -u main.py --l
isten --port 7860"
```

### 2. 初始化

下载模型

下载 Custom Nodes


## Build

```bash
docker buildx build --platform linux/amd64 -t image.paigpu.com/prod-[ppio account]/comfy-ppio:[tag] .
docker push image.paigpu.com/prod-[ppio account]/comfy-ppio:[tag]
```

**test**

```bash
docker run --platform linux/amd64 -p 7860:7860 -v ~/downloads/comfy-ppio/data:/data comfy-ppio /docker/entrypoint.sh
```
