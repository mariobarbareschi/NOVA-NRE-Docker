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
    apt-get install -y scons && \
    apt-get install -y qemu

RUN cd /opt && \
    git clone https://github.com/ironista/NRE && \
    cd NRE/cross && \
    ./build.sh x86_32 && \
    cd .. && \
    git submodule init && git submodule update && \
    cd nre/ && \
    ./dist/download.sh && \
    (./b qemu boot/vmmng || true)

ENTRYPOINT  cd /opt/NRE/nre/build/x86_32-release && \
            qemu-system-x86_64 '-vnc' '0.0.0.0:1' '-name' 'vmmng' '-m' '1024' '-smp' '4' '-netdev' 'user,id=mynet0' '-device' 'ne2k_pci,netdev=mynet0' '-cpu' 'phenom' '-kernel' 'bin/apps/hypervisor' '-append' 'spinner serial' '-initrd' 'bin/apps/root,bin/apps/acpi provides=acpi,bin/apps/keyboard provides=keyboard,bin/apps/reboot provides=reboot,bin/apps/pcicfg provides=pcicfg,bin/apps/timer provides=timer,bin/apps/console provides=console,bin/apps/network provides=network,bin/apps/sysinfo,bin/apps/vmmng mods=all lastmod,bin/apps/vancouver,dist/imgs/escape.bin,dist/imgs/escape_romdisk.bin,dist/imgs/escape_rtc.bin,dist/imgs/escape_fs.bin,dist/imgs/escape.iso,bin/apps/guest_munich,dist/imgs/bzImage-3.1.0-32,dist/imgs/initrd-js.lzma,dist/imgs/tinycore-vmlinuz,dist/imgs/tinycore-core.gz,escape.vmconfig,linux.vmconfig,tinycore-linux.vmconfig' '-serial' 'stdio'
