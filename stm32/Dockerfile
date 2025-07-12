FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

LABEL maintainer="2592509183@qq.com"
LABEL description="This is a Docker Image for XRobot build."

RUN apt update

RUN apt upgrade -y --no-install-recommends && apt install -y --no-install-recommends xz-utils git curl sudo wget zip make && apt install -y net-tools usbutils nano gdb cmake ninja-build file clang-tidy gcc g++ python3-tk && apt clean

RUN wget https://github.com/ARM-software/LLVM-embedded-toolchain-for-Arm/releases/download/release-19.1.5/LLVM-ET-Arm-19.1.5-Linux-x86_64.tar.xz && tar -xvf LLVM-ET-Arm-19.1.5-Linux-x86_64.tar.xz && rm LLVM-ET-Arm-19.1.5-Linux-x86_64.tar.xz && mv LLVM-ET-Arm-19.1.5-Linux-x86_64 /opt && sudo ln -s /opt/LLVM-ET-Arm-19.1.5-Linux-x86_64/bin/* /usr/bin

RUN for pair in \
      "clang:clang" \
      "clang++:clang++" \
      "llvm-objcopy:objcopy" \
      "llvm-size:size" \
      "llvm-ar:ar" \
      "llvm-nm:nm" \
      "llvm-strip:strip"; do \
    src=$(echo $pair | cut -d: -f1); \
    tgt=$(echo $pair | cut -d: -f2); \
    ln -sf /opt/LLVM-ET-Arm-19.1.5-Linux-x86_64/bin/$src /usr/bin/starm-$tgt; \
  done

RUN sudo mv /usr/lib/python3.12/EXTERNALLY-MANAGED /usr/lib/python3.12/EXTERNALLY-MANAGED.bk

RUN wget https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel1/binrel/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz && tar -xvf arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz && rm arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz && mv arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi /opt && sudo ln -s /opt/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi/bin/* /usr/bin

RUN ln -s /usr/bin/python3 /usr/bin/python && curl -sS https://bootstrap.pypa.io/get-pip.py | python3
