# Stable Diffusion WebUI 下载脚本

## 本地下载

```shell
docker build -f services/download/Dockerfile services/download -t stable-diffusion-webui/dl-script
docker run -v $(pwd)/data:/data -it stable-diffusion-webui/dl-script
```

## 计算 sha256

```shell
shasum -a 256 models/VAE/vae-ft-mse-840000-ema-pruned.ckpt
```

## 上传到 OSS

```shell
cd data
kubectl cp models download-script-xxxxxx:/data/models -n stable-diffusion --parallel 10
kubectl cp config/auto/extensions/sd-webui-controlnet/models download-script-xxxxxx:/data/config/auto/extensions/sd-webui-controlnet/models -n stable-diffusion --parallel 10
```
