# NOVA-NRE-Docker
A lightweight environment which provides a minimal configuration to let you compile the [Nova micro-hypervisor](https://github.com/TUD-OS/NOVA) and [NRE](https://github.com/TUD-OS/NRE) 

--------

## Getting started
The Nova-NRE compilation environment is released as a [docker](https://www.docker.com) image. You can build it by your own just typing

    docker build -t <container-name> .
    
Otherwise, if you aren't a docker enthusiast, just pull it from the [docker hub](https://hub.docker.com/r/mariobarbareschi/nova-nre/)

    docker pull mariobarbareschi/nova-nre
    
Run the container into an image sharing the NOVA folder

    docker run -it -v $PWD/NOVA:/opt mariobarbareschi/nova-nre

Once you have got the docker image, compile NOVA and NRE accordingly to your needs (architecture and debug/release compilation). The **b** command will compile everything, however some options may be fail, due to the fact that some dependencies cannot be provided inside the container, for instance **qemu**.

### Getting qemu
To be honest, I cannot see the problem of running NOVA onto a recent qemu. However, some incompatibilities with video/keyboard affects the latest qemu version. The most recent version which works with NOVA-NRE is the 2.0.0.

    git clone --branch v2.0.0 https://github.com/qemu/qemu
    git submodule update --init dtc
    ./configure
    make

Such commands will let you have the compiled qemu v2.0.0 on which NOVA-NRE should work properly.

### Complete running example
We need to run everything related to the compilation/configuration of the NOVA-NRE inside a docker container, the pull-out what we need to be executed into a qemu instance.

    docker run -it mariobarbareschi/nova-nre
    cd /opt/NRE/nre
    export NRE_BUILD=release
    export NRE_TARGET=x86_32
    ./dist/download.sh
    cd ./b qemu boot/vmmng
    
You will eventually get the error about the fact that qemu is not available into the container. Let us copy what has been compiled outside the container and just re-run the failing-command into a local shell:

    docker cp <container-id>:/opt/NRE/nre ./
    cd /NOVA/nre/build/x86_32-release
    ln -s ../../../dist/imgs ./imgs

Running the qemu command will let you see NOVA and NRE executing like that:
![Nova running into a quad-core phenom architecture](https://i.imgur.com/rpOzQ0B.png)

### (UN)LICENSE
Actually, this project is unlicensed.

### Contributing
Github is for social coding: if you want to write code, I encourage contributions through pull requests from forks of this repository.
