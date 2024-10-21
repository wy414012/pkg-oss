pkg-oss nginx构建脚本
# 基于nginx官方的构建rpm和deb包脚本
-----------------------------------
### 定制的自用脚本非通用，如需使用，请自行改变脚本依赖的模块目录

- 1、 [ngx-fancyindex](https://github.com/wy414012/ngx-fancyindex) 目录访问，美化模块，默认deb包，脚本自动拉取，rpm包，请自行克隆到`rpm make`脚本目录中，不使用请自行注释

- 2、 [boringssl](https://boringssl.googlesource.com/boringssl) quic依赖，rehat,debian请在`/root/`目录中构建，默认脚本配置为构建后的依赖地址，如不使用请自行注释掉。

- 3、 [boringssl](https://boringssl.googlesource.com/boringssl) quic依赖，alpine请在`当前用户`根目录中构建，默认脚本配置为构建后的依赖地址，如不使用请自行注释掉。

### 添加docker基础镜像构建环境脚本

- Dockerfile.debian 用于Debian基础镜像构建环境镜像

### 开始构建环境镜像：

```shell
docker build --build-arg BASE_IMAGE=debian:12 -f Dockerfile.debian -t Ngxin-deb-debian12/v3 .
```
### 可选基础镜像`debian:11,debian:12,debian:latest,ubuntu:20.04,ubuntu:22.04,ubuntu:latest(24.04)已测试通过，按照下面配置指定，在BASE_IMAGE=debian:11 此处定义调用镜像`：

```shell
docker build --build-arg BASE_IMAGE=debian:11 -f Dockerfile.debian -t Ngxin-deb-debian11/v3 .
```
### `build_all.sh`用于构建出deb包的脚本，在容器启动时候默认执行

- 启动参数可选，基于自己构建出来的镜像名称：

```shell
docker run --rm -v $(pwd):/host/pkg-oss Ngxin-deb-debian12/v3
```
- 如果需要代理才能正常访问的网络环境请使用下面的参数：

```shell
docker run --rm -v $(pwd):/host/pkg-oss -e http_proxy=http://ip:port -e https_proxy=http://ip:port Ngxin-deb-debian12/v3
```

### 注意自己网络环境默认使用的[boringssl](https://boringssl.googlesource.com/boringssl) 来构建quic支持，并且添加了目录访问美化模块！

### 由于我访问`docker`不是很方便，所以环境镜像不支持直接调用，只能自己构建，或者有权限的可以构建一个push到docker.io,构建出来的环境镜像1.6GB大小
