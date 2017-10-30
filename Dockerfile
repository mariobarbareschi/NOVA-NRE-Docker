FROM ubuntu:14.04

MAINTAINER Mario Barbareschi <mario.barbareschi@unina.it>

ENV NRE_BUILD release
ENV NRE_TARGET x86_64
ENV TERM xterm

RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y git wget && \
  apt-get install -y texinfo && \
  apt-get install -y libmpcdec-dev libmpfr-dev libgmp-dev libmpc-dev && \
  apt-get install -y scons && \
  apt-get install -y qemu

RUN \
  cd /opt && \
  git clone https://github.com/ironista/NRE && \
  cd NRE/cross && \
  ./build.sh $NRE_TARGET && \
  cd .. && \
  git submodule init && git submodule update && \
  cd nre/ && \
  ./dist/download.sh
