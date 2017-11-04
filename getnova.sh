#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname $0)" && pwd)
NRE_MNT_HOST=$SCRIPT_DIR/NRE
NRE_MNT_DOCKER=/mnt/NRE
NRE_DEFAULT_DOCKER=/opt/NRE/nre

docker run --rm -it -p 5901:5901 -v $NRE_MNT_HOST:$NRE_MNT_DOCKER -w=$NRE_DEFAULT_DOCKER mariobarbareschi/nova-nre
