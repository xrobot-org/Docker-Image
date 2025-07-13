FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

LABEL maintainer="2592509183@qq.com"
LABEL description="This is a Docker Image for XRobot build."

RUN apt update

RUN apt upgrade -y --no-install-recommends && apt install -y --no-install-recommends xz-utils git curl sudo wget zip unzip make && apt install -y net-tools usbutils util-linux expect nano gdb cmake ninja-build file clang-tidy gcc g++ python3-tk && apt clean

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        xz-utils git curl sudo wget zip unzip make \
        net-tools usbutils util-linux expect expect-dev nano gdb cmake ninja-build file clang-tidy gcc g++ python3-tk && \
    apt-get clean

RUN curl -L -o stm32cube-ide-core.vsix \
      -H "Accept: application/octet-stream" \
      -A "Mozilla/5.0" \
      "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/stmicroelectronics/vsextensions/stm32cube-ide-core/latest/vspackage" && \
    mv stm32cube-ide-core.vsix stm32cube-ide-core.vsix.gz && \
    gunzip stm32cube-ide-core.vsix.gz && \
    unzip stm32cube-ide-core.vsix && \
    cat > download.exp <<'EOF'
spawn extension/resources/binaries/linux/x86_64/cube bundle download st-arm-clang
set timeout -1
expect {
  -re "Proceed with download.*" {
    send "yes\r"
    exp_continue
  }
  eof
}
EOF

RUN script -q -c "expect download.exp" /dev/null && \
    rm download.exp && \
    BUNDLE_FILE=$(ls -t *.bundle | head -n1) && \
    mkdir -p /opt/st-arm-clang && \
    unzip "$BUNDLE_FILE" -d /opt/st-arm-clang && \
    rm -rf extension *.bundle *.vsix stm32cube-ide-core.vsix.gz

RUN for exe in /opt/st-arm-clang/bin/*; do \
      ln -sf "$exe" /usr/bin/$(basename "$exe"); \
    done


RUN sudo mv /usr/lib/python3.12/EXTERNALLY-MANAGED /usr/lib/python3.12/EXTERNALLY-MANAGED.bk

RUN wget https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel1/binrel/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz && tar -xvf arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz && rm arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz && mv arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi /opt && sudo ln -s /opt/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi/bin/* /usr/bin

RUN ln -s /usr/bin/python3 /usr/bin/python && curl -sS https://bootstrap.pypa.io/get-pip.py | python3
