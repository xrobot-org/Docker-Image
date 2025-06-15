FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

LABEL maintainer="2592509183@qq.com"
LABEL description="This is a Docker Image for XRobot build."

RUN apt update && apt upgrade -y --no-install-recommends && \
apt install -y --no-install-recommends xz-utils git curl sudo wget zip make && apt install -y net-tools usbutils nano gdb cmake ninja-build file clang-18 clangd clang-tidy gcc g++ python3-tk && apt clean

RUN ln -s /usr/bin/clang++-18 /usr/bin/clang++ && ln -s /usr/bin/clang-18 /usr/bin/clang

RUN sudo mv /usr/lib/python3.12/EXTERNALLY-MANAGED /usr/lib/python3.12/EXTERNALLY-MANAGED.bk

RUN apt install -y --no-install-recommends \
gawk texinfo bison flex bzip2 zlib1g-dev libgmp-dev libmpfr-dev \
libexpat-dev autoconf automake autotools-dev \
python3-tomli libmpc-dev build-essential gperf libtool patchutils \
bc libglib2.0-dev libslirp-dev ninja-build cmake git && \
apt clean && \
git clone https://github.com/riscv-collab/riscv-gnu-toolchain && \
cd riscv-gnu-toolchain && \
./configure --with-arch=rv32gc --with-abi=ilp32 \
--prefix=/opt/riscv-rv32 \
--with-multilib-generator="rv32imac-ilp32--zicsr*zifencei*zaamo*zalrsc;rv32imafc-ilp32f--zicsr*zifencei*zaamo*zalrsc" && \
make -j$(nproc) && \
cd .. && rm -rf riscv-gnu-toolchain

# 链接 RISC-V 工具链至 PATH
RUN bash -c "ln -s /opt/riscv-rv32/bin/* /usr/bin/"
