
## 说明

这个不只是给 ppio 用的，暂时用 `comfy-ppio` 命名

这个版本包含完整的初始化脚本（包含模型下载），这样不需要依赖于 download-script 的部署

适合 comfy-ppio 等这种 serverless 服务或者单机部署，只需要拉取一个镜像，运行初始化脚本，还支持自定义挂载目录


## PPIO 配置

PPIO 的容器共享一个云存储，挂载的名字是 `ppio_net0`，这个名字没法修改。

**修改 comfyui 的启动命令**

```bash
bash -c ["rm -rf /data && ln -s /ppio_net0 && /docker/entrypoint.sh && python -u main.py --l
isten --port 7860"]
```
因为 `ENTRYPOINT ["/docker/entrypoint.sh"]` 会创建 `/data` 目录，这个首先要删了然后再重新运行 `/docker/entrypoint.sh`

**修改 download script 的启动命令**

```bash
rm -rf /data && ln -s /ppio_net0 && bash -c "sleep 3600"
```
