FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

LABEL maintainer="2592509183@qq.com"
LABEL description="This is a Docker Image for XRobot build."

RUN apt update && apt upgrade -y --no-install-recommends

RUN apt install -y --no-install-recommends git curl sudo wget zip make && apt install -y gcc-arm-none-eabi net-tools usbutils nano unzip

RUN apt install -y --no-install-recommends cmake ninja-build clang clangd clang-tidy gcc g++ gdb python3-tk python3-pip python3-venv && apt clean

RUN git clone https://github.com/ithewei/libhv.git && cd libhv && ./configure && make && sudo make install && cd .. && rm -rf libhv

RUN ln -s /usr/bin/python3 /usr/bin/python

RUN wget https://github.com/xrobot-org/XRobot/raw/dev/hw/mcu/esp/Shell/install_esp-idf.sh && bash install_esp-idf.sh && \
    wget https://github.com/xrobot-org/XRobot/raw/dev/hw/mcu/esp/Shell/set-idf-path.sh && bash set-idf-path.sh

RUN wget https://github.com/cyberbotics/webots/releases/download/R2023a/webots_2023a_amd64.deb -O ./webots.deb && apt install ./webots.deb -y --no-install-recommends && rm webots.deb

RUN cd ~/esp/esp-idf/components && wget "https://components.espressif.com/api/download/?object_type=component&object_id=3a7a8cea-c960-424e-87aa-ccc4cabfaa1e" -O libhelix-mp3.zip && unzip -o libhelix-mp3.zip -d libhelix-mp3
RUN cd ~/esp/esp-idf/components && wget "https://components.espressif.com/api/download/?object_type=component&object_id=c7fc5cb0-2480-4262-9221-4513747ebee6" -O mdns.zip && unzip -o mdns.zip -d mdns
