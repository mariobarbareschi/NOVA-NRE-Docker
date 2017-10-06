# NOVA-NRE-Docker
A lightweight environment which provides a minimal configuration to let you compile the Nova micro-hypervisor and NRE 

## Getting started
The Nova-NRE compilation environment is released as a docker image. You can build it by your own just typing

    docker build -t <container-name> .
    
Otherwise, if you aren't a docker enthusiast, just pull it from the docker hub

    docker pull mariobarbareschi/nova-nre
    
Run the container into an image sharing the NOVA folder

    docker run -it -v $PWD/NOVA:/opt mariobarbareschi/nova-nre

Once you are into the docker container, just execute the getnova.sh script.

### (UN)LICENSE ###
--------

Actually, this project is unlicensed.

### Contributing ###
----------

Github is for social coding: if you want to write code, I encourage contributions through pull requests from forks of this repository.
