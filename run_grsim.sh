#!/bin/bash

OPT=${DOCKER_OPTION} ## -it --cpuset-cpus 0-2
iname=${DOCKER_IMAGE:-"ibis/grsim"} ## name of image (should be same as in build.sh)
cname=${DOCKER_CONTAINER:-"grsim"} ## name of container (should be same as in exec.sh)

DEFAULT_USER_DIR="$(pwd)"

VAR=${@:-"/grsim_ws/grSim/bin/grsim"}

## --net=mynetworkname
## docker inspect -f '{{.NetworkSettings.Networks.mynetworkname.IPAddress}}' ${cname}
## docker inspect -f '{{.NetworkSettings.Networks.mynetworkname.Gateway}}' ${cname}

NET_OPT="--net=host"
# for gdb
# NET_OPT="--net=host --cap-add=SYS_PTRACE --security-opt=seccomp=unconfined"
# NET_OPT="--net=host --env=NVIDIA_DRIVER_CAPABILITIES --env=NVIDIA_VISIBLE_DEVICES"

xhost +si:localuser:root

if [ "$(docker container ls -aq -f name=${cname})" ]; then
    echo "'docker rm ${cname}' is executed."
    docker rm ${cname}
fi

docker run ${OPT}    \
    --privileged     \
    --runtime=nvidia \
    ${NET_OPT}       \
    --env="DISPLAY"  \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --name=${cname} \
    -w="/userdir" \
    ${iname} ${VAR}
