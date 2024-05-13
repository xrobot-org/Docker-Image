FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

LABEL maintainer="2592509183@qq.com"
LABEL description="This is a Docker Image for XRobot build."

RUN apt update && apt upgrade -y --no-install-recommends &
apt install -y --no-install-recommends git curl sudo wget zip make && apt install -y gcc-arm-none-eabi net-tools usbutils nano gdb cmake ninja-build clang clangd clang-tidy gcc g++ python3-tk python3-pip && apt clean

RUN git clone https://github.com/ithewei/libhv && cd libhv && ./configure && make && sudo make install && cd .. && rm -rf libhv

RUN wget https://github.com/xrobot-org/XRobot/raw/dev/hw/mcu/esp/Shell/install_esp-idf.sh && bash install_esp-idf.sh &&
    wget https://github.com/xrobot-org/XRobot/raw/dev/hw/mcu/esp/Shell/set-idf-path.sh && bash set-idf-path.sh

RUN wget https://github.com/cyberbotics/webots/releases/download/R2023a/webots_2023a_amd64.deb -O ./webots.deb && apt install ./webots.deb -y --no-install-recommends && rm webots.deb

RUN ln -s /usr/bin/python3 /usr/bin/python
