#!/bin/sh
cd /opt
mkdir NOVA
cd NOVA
git clone https://github.com/TUD-OS/NRE
cd NRE/cross
./build.sh x86_64
./build.sh x86_32
cd ..
git submodule init && git submodule update
cd nre
export NRE_BUILD=release
export NRE_TARGET=x86_32
./b
