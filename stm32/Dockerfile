FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive
# Pin the last STM32Cube IDE core package that still ships the Linux cube
# downloader. Newer 1.2.x packages currently only contain win32/cube.exe,
# which would otherwise build a silently broken image without starm-clang.
ARG STM32CUBE_IDE_CORE_VERSION=1.1.0
ARG STM32CUBE_IDE_CORE_VSIX_URL="https://stmicroelectronics.gallerycdn.vsassets.io/extensions/stmicroelectronics/stm32cube-ide-core/1.1.0/1765810657223/Microsoft.VisualStudio.Services.VSIXPackage"

LABEL maintainer="2592509183@qq.com"
LABEL description="This is a Docker Image for XRobot build."

RUN apt update

RUN apt upgrade -y --no-install-recommends && apt install -y --no-install-recommends xz-utils git curl sudo wget zip unzip make && apt install -y net-tools usbutils util-linux nano gdb cmake ninja-build file clang-tidy gcc g++ python3-tk && apt clean

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        xz-utils git curl sudo wget zip unzip make \
        net-tools usbutils util-linux nano gdb cmake ninja-build file clang-tidy gcc g++ python3-tk libgpiod-dev && \
        apt-get clean

RUN curl -L -o stm32cube-ide-core.pkg \
      -H "Accept: application/octet-stream" \
      -A "Mozilla/5.0" \
      "${STM32CUBE_IDE_CORE_VSIX_URL}" && \
    if file stm32cube-ide-core.pkg | grep -qi "gzip compressed"; then \
      mv stm32cube-ide-core.pkg stm32cube-ide-core.vsix.gz && \
      gunzip stm32cube-ide-core.vsix.gz; \
    else \
      mv stm32cube-ide-core.pkg stm32cube-ide-core.vsix; \
    fi && \
    unzip -q stm32cube-ide-core.vsix && \
    test -x extension/resources/binaries/linux/x86_64/cube || \
      (echo "Linux STM32Cube downloader missing in stm32cube-ide-core ${STM32CUBE_IDE_CORE_VERSION}" >&2 && exit 1) && \
    extension/resources/binaries/linux/x86_64/cube bundle download --yes st-arm-clang && \
    BUNDLE_FILE=$(find . -maxdepth 1 -type f -name 'st-arm-clang*-linux.bundle' | head -n1) && \
    test -n "$BUNDLE_FILE" && \
    mkdir -p /opt/st-arm-clang && \
    unzip "$BUNDLE_FILE" -d /opt/st-arm-clang && \
    rm -rf extension *.bundle stm32cube-ide-core.pkg stm32cube-ide-core.vsix stm32cube-ide-core.vsix.gz

RUN test -x /opt/st-arm-clang/bin/starm-clang && \
    test -x /opt/st-arm-clang/bin/starm-clang++ && \
    for exe in /opt/st-arm-clang/bin/*; do \
      ln -sf "$exe" /usr/bin/$(basename "$exe"); \
    done && \
    command -v starm-clang && \
    command -v starm-clang++


RUN sudo mv /usr/lib/python3.12/EXTERNALLY-MANAGED /usr/lib/python3.12/EXTERNALLY-MANAGED.bk

RUN wget https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel1/binrel/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz && tar -xvf arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz && rm arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz && mv arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi /opt && sudo ln -s /opt/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi/bin/* /usr/bin

RUN ln -s /usr/bin/python3 /usr/bin/python && curl -sS https://bootstrap.pypa.io/get-pip.py | python3
