[![](https://images.microbadger.com/badges/image/mariobarbareschi/nova-nre.svg)](https://microbadger.com/images/mariobarbareschi/nova-nre "Get your own image badge on microbadger.com")[![Build Status](https://travis-ci.org/mariobarbareschi/NOVA-NRE-Docker.svg?branch=master)](https://travis-ci.org/mariobarbareschi/NOVA-NRE-Docker)
# NOVA-NRE-Docker
A lightweight environment which provides a minimal configuration to let you compile the [Nova micro-hypervisor](https://github.com/TUD-OS/NOVA) and [NRE](https://github.com/TUD-OS/NRE)

--------

## Getting started
The Nova-NRE compilation environment is released as a [docker](https://www.docker.com) image. You can build it by your own just typing

    docker build -t <container-name> .

Otherwise, if you aren't a docker enthusiast, just pull it from the [docker hub](https://hub.docker.com/r/mariobarbareschi/nova-nre/)

    docker pull mariobarbareschi/nova-nre

Container is shipped with NOVA and NRE already compiled. This is achieved automatically by Dockerfile during the image building using the `b` command. Even if compilation is successfully done, it is no possible for `b` script to launch the virtual machine manager they provide, due to the fact that some **qemu** dependencies cannot be used inside the container.

Instead, you should deploy files generated into container on a qemu instance out of it.

### Getting qemu
To be honest, I cannot see the problem of running NOVA onto a recent qemu. However, some incompatibilities with video/keyboard affects the latest qemu version. The most recent version which works with NOVA-NRE is the 2.0.0.

    git clone --branch v2.0.0 https://github.com/qemu/qemu
    git submodule update --init dtc
    ./configure
    make

Such commands will let you have the compiled qemu v2.0.0 on which NOVA-NRE should work properly.

### Complete running example
In case of laziness you can simply use our `getnova.sh` script which will:
* download and compile qemu v2.0.0
* move the compiled runtime environment `NRE` from container to `NOVA` folder
* launch the virtual machine manager

If you are one of the good guys out there and already have a full working qemu v2.0.0 you can set the following variable before calling `getnova.sh`.

    export QEMU_BIN_x86_64=<path/qemu-system-x86_64>

Finally, we are able to launch the demo. You need a shell for docker

    docker -it mariobarbareschi/nova-nre

After that, in a different shell you need to run

    ./getnova.sh

Running those commands will let you see NOVA and NRE executing like that:
![Nova running into a quad-core phenom architecture](https://i.imgur.com/rpOzQ0B.png)

### (UN)LICENSE
Actually, this project is unlicensed.

### Contributing
Github is for social coding: if you want to write code, I encourage contributions through pull requests from forks of this repository.
