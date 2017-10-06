FROM ubuntu:14.04

MAINTAINER Mario Barbareschi <mario.barbareschi@unina.it>

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y build-essential && \
    apt-get install -y git wget && \
    apt-get install -y texinfo && \
    apt-get install -y libmpcdec-dev libmpfr-dev libgmp-dev libmpc-dev && \
    apt-get install -y scons

