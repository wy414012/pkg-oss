#!/bin/bash

# 克隆项目
cd /root/ && \
git clone https://boringssl.googlesource.com/boringssl &&\
cd boringssl && \
mkdir build && \
cd build && \

# 执行 CMake 和 make
cmake -DCMAKE_BUILD_TYPE=Release .. && \

make -j $(nproc)

# 克隆目录美化模块
cd /root/ && \
git clone https://github.com/wy414012/ngx-fancyindex.git

# 进入 pkg-oss/debian 目录并构建 deb 包
cd /host/pkg-oss/debian

make base module-auth-spnego module-lua module-njs module-image-filter module-geoip2 module-geoip module-subs-filter module-rtmp module-set-misc module-perl module-fips-check module-brotli module-xslt module-ndk module-headers-more module-otel module-encrypted-session module-opentracing

# 清理构建完毕的缓存
cd /host/pkg-oss/debian/ && \
make clean

# 将生成的包同步指定到目录存储
mkdir -p /host/pkg-oss/pkg-output/

rsync -avz /host/pkg-oss/../nginx* /host/pkg-oss/pkg-output/

# 删除依赖目录
rm -rf /root/boringssl 
rm -rf /root/ngx-fancyindex
