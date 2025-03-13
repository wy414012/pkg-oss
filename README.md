# Nginx 定制化构建脚本说明

## 一、脚本概述
本脚本用于构建包含特定模块的 Nginx，并生成 RPM 和 DEB 包。此脚本为自用定制版本，非通用脚本，使用时需根据实际情况调整。

## 二、依赖模块说明
1. **ngx-fancyindex**：目录访问美化模块，默认用于 DEB 包构建。若要使用 RPM 包，需自行将该模块克隆到`rpm make`脚本目录中。若不使用此模块，可自行注释相关代码。
2. **boringssl**：QUIC 依赖模块。
    - 对于 Red Hat 和 Debian 系统，需在`/root/`目录中构建。脚本默认配置为构建后的依赖地址，若不使用，可自行注释相关代码。
    - 对于 Alpine 系统，需在当前用户根目录中构建。同样，脚本默认配置为构建后的依赖地址，若不使用，可自行注释相关代码。

## 三、添加 Docker 基础镜像构建环境脚本
1. `Dockerfile.debian`：用于构建 Debian 基础镜像的构建环境镜像。

## 四、构建环境镜像步骤
1. 执行以下命令构建环境镜像：
   ```shell
   docker build --build-arg BASE_IMAGE=debian:12 -f Dockerfile.debian -t Ngxin-deb-debian12/v3.
   ```
2. 可选基础镜像：`debian:11`, `debian:12`, `debian:latest`, `ubuntu:22.04`, `ubuntu:latest(24.04)`已测试通过。若要使用其他基础镜像，可在`BASE_IMAGE=debian:11`此处定义调用镜像，例如：
   ```shell
   docker build --build-arg BASE_IMAGE=debian:11 -f Dockerfile.debian -t Ngxin-deb-debian11/v3.
   ```
3. 直接拉取基于GitHub成品镜像可选版本：`pkg-oss:latest-debian12-amd64`,`pkg-oss:latest-debian11-amd64`
```shell
docker pull ghcr.io/wy414012/pkg-oss:latest-debian12-amd64
```
4. 使用成品镜像进行deb包构建
```shell
git clone https://github.com/wy414012/pkg-oss.git
cd pkg-oss
docker run --rm -v $(pwd):/host/pkg-oss pkg-oss:latest-debian12-amd64 或 docker run --rm -v $(pwd):/host/pkg-oss pkg-oss:latest-debian12-amd64
```
## 五、构建 deb 包脚本及启动参数
1. `build_all.sh`：用于构建出 deb 包的脚本，在容器启动时默认执行。
2. 启动参数：
   - 基于自己构建出来的镜像名称：
     ```shell
     docker run --rm -v $(pwd):/host/pkg-oss pkg-oss:latest-debian12-amd64
     ```
   - 若处于需要代理才能正常访问的网络环境，请使用以下参数：
     ```shell
     docker run --rm -v $(pwd):/host/pkg-oss -e http_proxy=http://ip:port -e https_proxy=http://ip:port pkg-oss:latest-debian12-amd64
     ```

## 六、注意事项
1. 由于可能存在访问`docker`不方便的情况，所以环境镜像不支持直接调用，只能自行构建。若有权限，可以构建后 push 到`docker.io`。构建出来的环境镜像大小约为 1.6GB。

2. 默认使用[boringssl](https://boringssl.googlesource.com/boringssl)构建 QUIC 支持，并添加了目录访问美化模块。请根据自己的网络环境和需求进行调整。

3. 目录美化模块[ngx-fancyindex](https://github.com/wy414012/ngx-fancyindex),请在该仓库克隆，也可以自行使用其它版本的目录美化模块。

4. 构建出的deb包在当前目录下的`pkg-output`中

[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Community Support](https://badgen.net/badge/support/community/cyan?icon=awesome)](https://github.com/nginx/pkg-oss/blob/master/SUPPORT.md)

# About this Repo

## Maintained by: [the NGINX packaging maintainers](https://github.com/nginx/pkg-oss)

This is the Git repo of the [official packages](https://nginx.org/en/linux_packages.html) for [`NGINX Open Source`](https://nginx.org/).  It is used as a source of truth to build binary packages for all supported Linux distributions and their variants.

The changelog for NGINX releases is available at [nginx.org changes page](https://nginx.org/en/CHANGES).

## Contributing

Please see the [contributing guide](https://github.com/nginx/pkg-oss/blob/master/CONTRIBUTING.md) for guidelines on how to best contribute to this project.

## License

[BSD 2-Clause](https://github.com/nginx/pkg-oss/blob/master/LICENSE)

&copy; [F5, Inc.](https://www.f5.com/) 2025
