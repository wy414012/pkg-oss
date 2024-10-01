pkg-oss nginx构建脚本
# 基于nginx官方的构建rpm和deb包脚本
-----------------------------------
## 定制的自用脚本非通用，如需使用，请自行改变脚本依赖的模块目录

1、 (ngx-fancyindex)[https://github.com/wy414012/ngx-fancyindex] 目录访问，美化模块，默认deb包，脚本自动拉取，rpm包，请自行克隆到rpm make脚本目录中，不使用请自行注释
2、 (boringssl)[https://boringssl.googlesource.com/boringssl] quic依赖，请在root目录中构建，默认脚本配置为构建后的依赖地址，如不使用请自行注释掉。
