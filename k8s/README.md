
## Install

```shell
# test env
export KUBECONFIG=~/.kube/config-azure-muse-ai-test
helm install stable-diffusion ./stable-diffusion-chart -f stable-diffusion-chart/values-test.yaml --dry-run
# prod env
export KUBECONFIG=~/.kube/config-azure-muse-ai-prod
helm install stable-diffusion ./stable-diffusion-chart -f stable-diffusion-chart/values-prod.yaml --dry-run
```

正式安装的时候去掉 `--dry-run` 参数

## Upgrade

```shell
# test env
export KUBECONFIG=~/.kube/config-azure-muse-ai-test
helm upgrade stable-diffusion ./stable-diffusion-chart -f stable-diffusion-chart/values-test.yaml --dry-run
# prod env
export KUBECONFIG=~/.kube/config-azure-muse-ai-prod
helm upgrade stable-diffusion ./stable-diffusion-chart -f stable-diffusion-chart/values-prod.yaml --dry-run
```

记得去掉 `--dry-run` 参数

## 首次下载模型

有两种方式

**部署 download job**

```shell
kubectl apply -f download-job.yaml
```

**进入 download-script 容器人工触发**

```shell
cd docker
./download.sh
```
