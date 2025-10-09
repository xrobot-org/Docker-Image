FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

LABEL maintainer="2592509183@qq.com" \
      description="Docker Image for XRobot build with Webots and OpenCV 4.10.0"

RUN apt-get update && \
    apt-get upgrade -y --no-install-recommends && \
    apt-get install -y --no-install-recommends \
      xz-utils git curl sudo wget zip unzip make file nano gdb \
      net-tools usbutils \
      cmake ninja-build \
      clang-18 clangd clang-tidy \
      gcc g++ \
      python3 python3-venv python3-tk \
      libwpa-client-dev libnm-dev libudev-dev \
      ca-certificates pkg-config && \
    rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-18 100 && \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-18 100

RUN mv /usr/lib/python3.12/EXTERNALLY-MANAGED /usr/lib/python3.12/EXTERNALLY-MANAGED.bk || true && \
    ln -sf /usr/bin/python3 /usr/bin/python && \
    curl -sS https://bootstrap.pypa.io/get-pip.py | python3

RUN set -eux; \
    apt-get update; \
    wget -O /tmp/webots.deb https://github.com/cyberbotics/webots/releases/download/R2025a/webots_2025a_amd64.deb; \
    apt-get install -y --no-install-recommends /tmp/webots.deb; \
    rm -f /tmp/webots.deb; \
    rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
      libjpeg-dev libpng-dev libtiff-dev \
      libavcodec-dev libavformat-dev libswscale-dev \
      libv4l-dev libxvidcore-dev libx264-dev \
      libgtk-3-dev libcanberra-gtk3-module \
      libtbb-dev libdc1394-dev libopenexr-dev \
      libeigen3-dev && \
    rm -rf /var/lib/apt/lists/* && \
    cd /tmp && \
    wget -O opencv.zip https://github.com/opencv/opencv/archive/4.10.0.zip && \
    unzip -q opencv.zip && \
    mkdir -p opencv-4.10.0/build && \
    cd opencv-4.10.0/build && \
    cmake .. \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_C_COMPILER=clang \
      -DCMAKE_CXX_COMPILER=clang++ \
      -DCMAKE_CXX_STANDARD=14 \
      -DBUILD_TESTS=OFF \
      -DBUILD_PERF_TESTS=OFF && \
    make -j"$(nproc)" && \
    make install && \
    ldconfig && \
    cd / && rm -rf /tmp/opencv.zip /tmp/opencv-4.10.0
