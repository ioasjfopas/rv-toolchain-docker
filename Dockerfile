FROM ubuntu:24.04

RUN groupadd riscv && useradd -m -g riscv riscv

ENV PATH=/opt/riscv/bin:${PATH}

RUN apt-get update
RUN apt-get install -y git

RUN git clone https://github.com/riscv/riscv-gnu-toolchain --recursive --depth 1 /riscv/

RUN apt-get install -y \
    autoconf \
    automake \
    autotools-dev \
    curl \
    libmpc-dev \
    libmpfr-dev  \
    libgmp-dev  \
    gawk  \
    build-essential  \
    bison  \
    flex  \
    texinfo  \
    gperf  \
    libtool  \
    patchutils  \
    bc  \
    zlib1g-dev  \
    libexpat-dev \
    python3 \
    qemu-system-misc \
    opensbi \
    u-boot-qemu \
    qemu-utils

RUN cd /riscv/ && ./configure --prefix=/opt/riscv --enable-multilib
RUN cd /riscv/ && make linux -j4
RUN rm -rf /riscv

USER riscv
WORKDIR /home/riscv
