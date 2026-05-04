FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive
ARG OPENCV_VERSION=4.13.0

LABEL maintainer="2592509183@qq.com"
LABEL description="Docker Image for XRobot Linux build with OpenCV 4.13.0"

RUN apt-get update && \
    apt-get upgrade -y --no-install-recommends && \
    apt-get install -y --no-install-recommends \
      xz-utils git curl sudo wget zip unzip make file nano gdb \
      net-tools usbutils \
      cmake ninja-build pkg-config ca-certificates \
      clang-18 clangd clang-tidy \
      gcc g++ \
      python3 python3-venv python3-tk \
      libwpa-client-dev libnm-dev libudev-dev libgpiod-dev \
      libjpeg-dev libpng-dev libtiff-dev \
      libavcodec-dev libavformat-dev libswscale-dev \
      libv4l-dev libxvidcore-dev libx264-dev \
      libgtk-3-dev libcanberra-gtk3-module \
      libtbb-dev libdc1394-dev libopenexr-dev \
      libeigen3-dev && \
    rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-18 100 && \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-18 100

RUN mv /usr/lib/python3.12/EXTERNALLY-MANAGED /usr/lib/python3.12/EXTERNALLY-MANAGED.bk || true && \
    ln -sf /usr/bin/python3 /usr/bin/python && \
    curl -sS https://bootstrap.pypa.io/get-pip.py | python3

RUN set -eux; \
    cd /tmp; \
    wget -O opencv.zip "https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip"; \
    wget -O opencv_contrib.zip "https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.zip"; \
    unzip -q opencv.zip; \
    unzip -q opencv_contrib.zip; \
    cmake -S "opencv-${OPENCV_VERSION}" -B "opencv-${OPENCV_VERSION}/build" -G Ninja \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_C_COMPILER=clang \
      -DCMAKE_CXX_COMPILER=clang++ \
      -DCMAKE_CXX_STANDARD=14 \
      -DOPENCV_EXTRA_MODULES_PATH="/tmp/opencv_contrib-${OPENCV_VERSION}/modules" \
      -DBUILD_LIST=core,imgproc,imgcodecs,videoio,highgui,calib3d,dnn,features2d,flann,objdetect,aruco \
      -DOPENCV_GENERATE_PKGCONFIG=ON \
      -DBUILD_TESTS=OFF \
      -DBUILD_PERF_TESTS=OFF \
      -DBUILD_EXAMPLES=OFF \
      -DBUILD_opencv_apps=OFF \
      -DBUILD_opencv_python3=OFF \
      -DBUILD_JAVA=OFF; \
    cmake --build "opencv-${OPENCV_VERSION}/build" -j"$(nproc)"; \
    cmake --install "opencv-${OPENCV_VERSION}/build"; \
    ldconfig; \
    cd /; \
    rm -rf "/tmp/opencv.zip" "/tmp/opencv_contrib.zip" "/tmp/opencv-${OPENCV_VERSION}" "/tmp/opencv_contrib-${OPENCV_VERSION}"

ENV OpenCV_DIR=/usr/local/lib/cmake/opencv4
ENV CMAKE_PREFIX_PATH=/usr/local/lib/cmake/opencv4:${CMAKE_PREFIX_PATH}
