FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

LABEL maintainer="2592509183@qq.com"
LABEL description="This is a Docker Image for XRobot build."

RUN apt update

RUN apt upgrade -y --no-install-recommends & apt install -y --no-install-recommends git curl sudo wget zip make && apt install -y net-tools usbutils nano gdb cmake ninja-build clang clangd clang-tidy gcc g++ python3-tk python3-pip && apt clean

RUN git clone https://github.com/ithewei/libhv && cd libhv && ./configure && make && sudo make install && cd .. && rm -rf libhv

RUN ln -s /usr/bin/python3 /usr/bin/python
