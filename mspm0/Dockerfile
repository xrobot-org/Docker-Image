FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive
# Pin the last STM32Cube IDE core package that still ships the Linux cube
# downloader. Newer 1.2.x packages currently only contain win32/cube.exe,
# which would otherwise build a silently broken image without starm-clang.
ARG STM32CUBE_IDE_CORE_VERSION=1.1.0
ARG STM32CUBE_IDE_CORE_VSIX_URL="https://stmicroelectronics.gallerycdn.vsassets.io/extensions/stmicroelectronics/stm32cube-ide-core/1.1.0/1765810657223/Microsoft.VisualStudio.Services.VSIXPackage"

ARG MSPM0_SDK_TAG="mspm0_sdk_2_11_00_07"
ARG SYSCONFIG_VERSION="1.28.1"
ARG SYSCONFIG_BUILD="4785"

LABEL maintainer="2592509183@qq.com"
LABEL description="Docker Image for XRobot MSPM0 builds: the stm32 image content (GNU Arm toolchain, starm-clang) plus the MSPM0 SDK and SysConfig."

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

# MSPM0 SDK: only source/ and .metadata/ are needed by the BSPs (sparse checkout, no blobs elsewhere).
ENV MSPM0_SDK_INSTALL_DIR=/opt/ti/mspm0_sdk_2_11_00_07

RUN set -eux; \
    mkdir -p /opt/ti; \
    git clone --depth 1 --filter=blob:none --sparse --branch "${MSPM0_SDK_TAG}" \
      https://github.com/TexasInstruments/mspm0-sdk "${MSPM0_SDK_INSTALL_DIR}"; \
    git -C "${MSPM0_SDK_INSTALL_DIR}" sparse-checkout set source .metadata; \
    rm -rf "${MSPM0_SDK_INSTALL_DIR}/.git"; \
    test -f "${MSPM0_SDK_INSTALL_DIR}/.metadata/product.json"; \
    test -d "${MSPM0_SDK_INSTALL_DIR}/source/ti/driverlib"

# SysConfig (Node based CLI) for the .syscfg files of the MSPM0 BSPs.
ENV SYSCONFIG_TOOL=/opt/ti/sysconfig_1.28.1/sysconfig_cli.sh

RUN set -eux; \
    installer="/tmp/sysconfig-${SYSCONFIG_VERSION}_${SYSCONFIG_BUILD}-setup.run"; \
    curl -L --fail --retry 3 -o "${installer}" \
      "https://downloads.ti.com/ccs/esd/sysconfig/sysconfig-${SYSCONFIG_VERSION}_${SYSCONFIG_BUILD}-setup.run"; \
    chmod +x "${installer}"; \
    "${installer}" --mode unattended --prefix "/opt/ti/sysconfig_${SYSCONFIG_VERSION}"; \
    rm -f "${installer}"; \
    test -x "${SYSCONFIG_TOOL}"; \
    "${SYSCONFIG_TOOL}" --version
