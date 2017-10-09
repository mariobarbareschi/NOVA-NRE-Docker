FROM ubuntu:14.04

MAINTAINER Mario Barbareschi <mario.barbareschi@unina.it>

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y build-essential && \
    apt-get install -y git wget && \
    apt-get install -y texinfo && \
    apt-get install -y libmpcdec-dev libmpfr-dev libgmp-dev libmpc-dev && \
    apt-get install -y scons

RUN cd /opt && \
    git clone https://github.com/TUD-OS/NRE && \
    cd NRE/cross && \
    ./build.sh x86_32 && \
    cd .. && \
    git submodule init && git submodule update && \
    export NRE_BUILD=release && \
    export NRE_TARGET=x86_32
