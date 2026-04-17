# Docker image
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fxrobot-org%2FDocker-Image.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Fxrobot-org%2FDocker-Image?ref=badge_shield)

Docker image for XRobot build.

## Images

- `linux`: generic Ubuntu 24.04 development base for XRobot Linux-side builds
- `stm32`: STM32 build image with `arm-none-eabi` GNU Arm toolchain and `starm-clang`
- `mspm0`: alias of the `stm32` image for GNU Arm `arm-none-eabi` based MSPM0 builds
- `esp32`: ESP-IDF based image for ESP32 builds
- `ch32-riscv`: CH32 RISC-V image with the WCH `riscv32-wch-elf` toolchain
- `hpm`: HPM image with the published Linux x64 mainline GNU `riscv32-unknown-elf` toolchain from `https://github.com/Jiu-xiao/hpm-linux-gcc-release/releases/tag/v0.1.0`
- `webots`: Webots and OpenCV based simulation image

## Publishing

- GHCR: `ghcr.io/xrobot-org/docker-image-<name>:main`
- Docker Hub mirror: `docker.io/xrimage/xrimage-<name>:latest`

## License
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fxrobot-org%2FDocker-Image.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Fxrobot-org%2FDocker-Image?ref=badge_large)
