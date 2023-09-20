FROM ubuntu:22.04

LABEL maintainer="2592509183@qq.com"
LABEL description="This is a Docker Image for XRobot build."

RUN apt update
RUN apt upgrade -y

RUN apt install -y git curl sudo wget

RUN apt install -y cmake gcc-arm-none-eabi ninja-build clang clangd clang-tidy gcc g++ gdb python3-tk python3-pip

RUN git clone https://github.com/ithewei/libhv.git && cd libhv && ./configure && make && sudo make install

RUN wget https://github.com/xrobot-org/XRobot/raw/master/hw/mcu/esp/Shell/install_esp-idf.sh && bash install_esp-idf.sh
RUN wget https://github.com/xrobot-org/XRobot/raw/master/hw/mcu/esp/Shell/set-idf-path.sh && bash set-idf-path.sh
RUN wget https://github.com/cyberbotics/webots/releases/download/R2023a/webots_2023a_amd64.deb -O ./webots.deb && apt install ./webots.deb -y
