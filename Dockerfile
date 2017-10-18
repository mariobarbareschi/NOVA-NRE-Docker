FROM ubuntu:14.04

MAINTAINER Mario Barbareschi <mario.barbareschi@unina.it>

ENV NRE_BUILD release
ENV NRE_TARGET x86_32
ENV TERM xterm

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y build-essential && \
    apt-get install -y git wget && \
    apt-get install -y texinfo && \
    apt-get install -y libmpcdec-dev libmpfr-dev libgmp-dev libmpc-dev && \
    apt-get install -y scons

RUN cd /opt && \
    git clone --branch v2.0.0 https://github.com/qemu/qemu && \
    cd qemu && \
    git submodule update --init dtc && \
    cd /opt && \
    git clone https://github.com/ironista/NRE && \
    cd NRE/cross && \
    ./build.sh x86_32 && \
    cd .. && \
    git submodule init && git submodule update && \
    cd nre/ && \
    ./dist/download.sh && \
    (./b qemu boot/vmmng || true)
