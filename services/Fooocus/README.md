# Fooocus

参考了

https://github.com/lllyasviel/Fooocus
https://github.com/lllyasviel/Fooocus/issues/98#issuecomment-1682796350


## 初始化

### 1. 下载模型

```bash
apt-get install aria2
bash /docker/download.sh
```

### 2. 其他

如果安装 aria2 遇到网络问题，可以切一下源

```bash
mv /etc/apt/sources.list /etc/apt/sources.list.back
cat << EOF > /etc/apt/sources.list
deb http://mirrors.aliyun.com/debian/ bullseye main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ bullseye main non-free contrib
deb http://mirrors.aliyun.com/debian-security/ bullseye-security main
deb-src http://mirrors.aliyun.com/debian-security/ bullseye-security main
deb http://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib
deb http://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib
EOF
```
