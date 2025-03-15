FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

LABEL maintainer="2592509183@qq.com"
LABEL description="This is a Docker Image for XRobot build."

RUN apt update

RUN apt upgrade -y --no-install-recommends & apt install -y --no-install-recommends git curl sudo wget zip make && apt install -y net-tools usbutils nano gdb cmake ninja-build clang clangd clang-tidy gcc g++ python3-tk python3-pip && apt clean

RUN wget https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel1/binrel/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz && tar -xvf arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz && rm arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz && mv arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi /opt && sudo ln -s /opt/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi/bin/* /usr/bin

RUN ln -s /usr/bin/python3 /usr/bin/python && pip install --upgrade pip
