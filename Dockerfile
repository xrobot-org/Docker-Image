FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

LABEL maintainer="2592509183@qq.com"
LABEL description="This is a Docker Image for XRobot build."

RUN apt update

RUN apt upgrade -y --no-install-recommends && \
    apt install -y --no-install-recommends xz-utils git curl sudo wget zip make && apt install -y net-tools usbutils nano gdb cmake ninja-build file clang-18 clangd clang-tidy gcc g++ python3-tk python3.12-venv && apt clean

RUN ln -s /usr/bin/clang++-18 /usr/bin/clang++ && ln -s /usr/bin/clang-18 /usr/bin/clang

RUN sudo mv /usr/lib/python3.12/EXTERNALLY-MANAGED /usr/lib/python3.12/EXTERNALLY-MANAGED.bk

RUN wget https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel1/binrel/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz && tar -xvf arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz && rm arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz && mv arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi /opt && sudo ln -s /opt/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi/bin/* /usr/bin

RUN git clone https://github.com/ithewei/libhv && cd libhv && ./configure && make && sudo make install && cd .. && rm -rf libhv

RUN wget https://github.com/cyberbotics/webots/releases/download/R2023a/webots_2023a_amd64.deb -O ./webots.deb && apt install ./webots.deb -y --no-install-recommends && rm webots.deb

RUN ln -s /usr/bin/python3 /usr/bin/python && curl -sS https://bootstrap.pypa.io/get-pip.py | python3

RUN rm -rf ~/esp && \
    mkdir ~/esp && \
    cd ~/esp && \
    git clone --depth 1 --branch v5.4.1 https://github.com/espressif/esp-idf.git && \
    cd ./esp-idf && \
    git submodule update --init --recursive --recommend-shallow --depth 1 && \
    bash ./install.sh && \
    rm -rf .git && \
    chmod +x ./*sh

