FROM ubuntu:14.04

LABEL maintainer="Mario Barbareschi <mario.barbareschi@unina.it>"

EXPOSE 5901

ENV NRE_PATH /opt/NRE/nre
ENV NRE_BUILD debug
ENV NRE_TARGET x86_64
ENV TERM xterm
ENV QEMU_FLAGS -vnc 0.0.0.0:1
ENV BUILD_DIR ${NRE_PATH}/build/${NRE_TARGET}-${NRE_BUILD}


# OS Packages
RUN \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y build-essential && \
    apt-get install -y git wget && \
    apt-get install -y texinfo && \
    apt-get install -y libmpcdec-dev libmpfr-dev libgmp-dev libmpc-dev && \
    apt-get install -y scons && \
    apt-get install -y qemu

# NOVA Runtime Environment
RUN \
    cd /opt && \
    git clone https://github.com/ironista/NRE && \
    cd NRE/cross && \
    ./build.sh ${NRE_TARGET} && \
    cd .. && \
    git submodule init && git submodule update && \
    cd nre/ && \
    ./dist/download.sh

# Building all tester scripts
RUN \
    export QEMU_FLAGS="" && \
    cd ${NRE_PATH} && \
    for file in ./boot/*; do \
        script=$(basename $file); \
        (./b qemu boot/$script && true); \
    done