FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive
ARG HPM_TOOLCHAIN_VERSION="v0.1.0"
ARG HPM_TOOLCHAIN_ARCHIVE_BASENAME="hpm-riscv32-unknown-elf-linux-x64"
ARG HPM_TOOLCHAIN_URL=""
ARG HPM_TOOLCHAIN_SHA256="6a14d30ac29da5a23185db249d5f7b1f9e20bb2deb8d26302ba2baff0442f108"

LABEL maintainer="2592509183@qq.com" \
      description="Docker Image for XRobot HPM builds with the published mainline riscv32-unknown-elf GNU toolchain." \
      org.opencontainers.image.version="${HPM_TOOLCHAIN_VERSION}"

RUN apt-get update && \
    apt-get upgrade -y --no-install-recommends && \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      xz-utils \
      git \
      curl \
      sudo \
      wget \
      zip \
      make \
      net-tools \
      usbutils \
      nano \
      gdb \
      cmake \
      ninja-build \
      file \
      clang-18 \
      clangd \
      clang-tidy \
      gcc \
      g++ \
      python3 \
      python3-tk \
      python3-venv \
      libgpiod-dev && \
    rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-18 100 && \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-18 100

RUN mv /usr/lib/python3.12/EXTERNALLY-MANAGED /usr/lib/python3.12/EXTERNALLY-MANAGED.bk || true

RUN ln -sf /usr/bin/python3 /usr/bin/python && \
    curl -sS https://bootstrap.pypa.io/get-pip.py | python3

ENV XR_HPM_TOOLCHAIN_ROOT=/opt/hpm-riscv32-unknown-elf
ENV PATH=${XR_HPM_TOOLCHAIN_ROOT}/bin:${PATH}

RUN set -eux; \
    toolchain_url="${HPM_TOOLCHAIN_URL:-https://github.com/Jiu-xiao/hpm-linux-gcc-release/releases/download/${HPM_TOOLCHAIN_VERSION}/${HPM_TOOLCHAIN_ARCHIVE_BASENAME}.tar.xz}"; \
    archive="/tmp/${HPM_TOOLCHAIN_ARCHIVE_BASENAME}.tar.xz"; \
    curl -L --fail --retry 3 -o "${archive}" "${toolchain_url}"; \
    echo "${HPM_TOOLCHAIN_SHA256}  ${archive}" | sha256sum -c -; \
    tar -xf "${archive}" -C /opt; \
    rm -f "${archive}"; \
    mv "/opt/${HPM_TOOLCHAIN_ARCHIVE_BASENAME}" "${XR_HPM_TOOLCHAIN_ROOT}"; \
    test -x "${XR_HPM_TOOLCHAIN_ROOT}/bin/riscv32-unknown-elf-gcc"; \
    test -x "${XR_HPM_TOOLCHAIN_ROOT}/bin/riscv32-unknown-elf-g++"; \
    test -x "${XR_HPM_TOOLCHAIN_ROOT}/bin/riscv32-unknown-elf-gdb"; \
    for exe in "${XR_HPM_TOOLCHAIN_ROOT}"/bin/*; do \
      ln -sf "$exe" "/usr/bin/$(basename "$exe")"; \
    done; \
    riscv32-unknown-elf-gcc --version | head -n 1; \
    riscv32-unknown-elf-g++ --version | head -n 1; \
    riscv32-unknown-elf-gdb --version | head -n 1
