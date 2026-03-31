FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive
ARG MRS_TOOLCHAIN_URL="https://github.com/Jiu-xiao/mounriver-toolchain-mirror/releases/download/v240/MRS_Toolchain_Linux_X64_V240.tar.xz"

LABEL maintainer="2592509183@qq.com"
LABEL description="This is a Docker Image for XRobot build."

RUN apt update && apt upgrade -y --no-install-recommends && \
apt install -y --no-install-recommends xz-utils git curl sudo wget zip make && apt install -y net-tools usbutils nano gdb cmake ninja-build file clang-18 clangd clang-tidy gcc g++ python3-tk libhidapi-hidraw0 libjaylink0 && apt clean

RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-18 100 && \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-18 100

RUN sudo mv /usr/lib/python3.12/EXTERNALLY-MANAGED /usr/lib/python3.12/EXTERNALLY-MANAGED.bk

RUN set -eux; \
curl -L --fail --retry 3 -o /tmp/mrs_toolchain.tar.xz "$MRS_TOOLCHAIN_URL"; \
mkdir -p /opt/wch-gcc15-v240; \
tar -xf /tmp/mrs_toolchain.tar.xz -C /opt/wch-gcc15-v240; \
rm -f /tmp/mrs_toolchain.tar.xz; \
test -x "/opt/wch-gcc15-v240/Toolchain/RISC-V Embedded GCC15/bin/riscv32-wch-elf-gcc"; \
test -x "/opt/wch-gcc15-v240/Toolchain/RISC-V Embedded GCC15/bin/riscv32-wch-elf-g++"; \
test -x "/opt/wch-gcc15-v240/OpenOCD/OpenOCD/bin/openocd"

RUN bash -c 'ln -sf "/opt/wch-gcc15-v240/Toolchain/RISC-V Embedded GCC15/bin/"* /usr/bin/' && \
    bash -c 'ln -sf "/opt/wch-gcc15-v240/OpenOCD/OpenOCD/bin/"* /usr/bin/'
