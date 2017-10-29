#!/bin/sh

nova_dir=$(cd `dirname $0` && pwd)
local_ip=$(ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}')

socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" &
docker run -e DISPLAY=$local_ip:0 -it mariobarbareschi/nova-nre
pkill socat
