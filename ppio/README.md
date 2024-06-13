
Scripts

```bash
# 列出名字包含指定字符串的实例
node scripts/listInstance.mjs "Muse 模型训练"

# 启动实例
node scripts/startInstance.mjs --id 7a877f172676d126
node scripts/startInstance.mjs --name "Muse 模型训练"

# 关闭实例
node scripts/stopInstance.mjs --id 7a877f172676d126
node scripts/stopInstance.mjs --name "Muse 模型训练"
```

ppio 的容器里没有 `en_US.UTF-8`，运行 bash 的时候可以切换成它有的 locale

```bash
export LANG=C.UTF-8
export LC_ALL=C.UTF-8
```

ppio 默认的挂载路径是 `/ppio_net2`，在控制台上创建实例的时候无法修改，但是通过接口创建可以，参数是 `networkStorageMountPoint`，这个设置成 `/data`，然后就可以用 ComfyUI 默认的 CMD 来启动了
