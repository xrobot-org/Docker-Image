FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

LABEL maintainer="2592509183@qq.com"
LABEL description="This is a Docker Image for XRobot build."

RUN apt update

RUN apt upgrade -y --no-install-recommends & apt install -y --no-install-recommends xz-utils git curl sudo wget zip make && apt install -y net-tools usbutils nano gdb cmake ninja-build file clang-18 clangd clang-tidy gcc g++ python3-tk && apt clean

RUN sudo mv /usr/lib/python3.12/EXTERNALLY-MANAGED /usr/lib/python3.12/EXTERNALLY-MANAGED.bk

RUN ln -s /usr/bin/clang++-18 /usr/bin/clang++ && ln -s /usr/bin/clang-18 /usr/bin/clang

RUN git clone https://github.com/ithewei/libhv && cd libhv && ./configure && make && sudo make install && cd .. && rm -rf libhv

RUN ln -s /usr/bin/python3 /usr/bin/python && curl -sS https://bootstrap.pypa.io/get-pip.py | python3
