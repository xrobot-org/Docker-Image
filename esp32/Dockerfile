FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

LABEL maintainer="2592509183@qq.com"
LABEL description="This is a Docker Image for XRobot build."

RUN apt update

RUN apt upgrade -y --no-install-recommends & apt install -y --no-install-recommends git curl sudo wget zip make && apt install -y net-tools usbutils nano gdb cmake ninja-build file clang-15 clangd clang-tidy gcc g++ python3-tk python3-pip && apt clean

RUN ln -s /usr/bin/clang++-15 /usr/bin/clang++ && ln -s /usr/bin/clang-15 /usr/bin/clang

RUN wget https://github.com/xrobot-org/XRobot/raw/dev/hw/mcu/esp/Shell/install_esp-idf.sh && bash install_esp-idf.sh && wget https://github.com/xrobot-org/XRobot/raw/dev/hw/mcu/esp/Shell/set-idf-path.sh && bash set-idf-path.sh

RUN ln -s /usr/bin/python3 /usr/bin/python && pip install --upgrade pip
