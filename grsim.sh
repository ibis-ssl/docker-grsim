#!/bin/bash

OPT=${DOCKER_OPTION} ## -it --cpuset-cpus 0-2
iname=${DOCKER_IMAGE:-"ibis/grsim"}
cname=${DOCKER_CONTAINER:-"grsim"}

VAR=${@:-"/grsim_ws/grSim/bin/grSim"}

NET_OPT="--net=host"
# for gdb
# NET_OPT="--net=host --cap-add=SYS_PTRACE --security-opt=seccomp=unconfined"
# NET_OPT="--net=host --env=NVIDIA_DRIVER_CAPABILITIES --env=NVIDIA_VISIBLE_DEVICES"

xhost +si:localuser:root

if [ "$(docker container ls -aq -f name=${cname})" ]; then
    echo "'docker rm ${cname}' is executed."
    docker rm ${cname}
fi

ARG="${OPT}    \
    --privileged     \
    ${NET_OPT}       \
    --env=DISPLAY  \
    --env=QT_X11_NO_MITSHM=1 \
    --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw \
    --name=${cname} \
    -w=/userdir \
    ${iname} ${VAR}"

if type nvidia-smi; then
    echo "Nvidia driver environment detected."
    docker run --gpus=all ${ARG}
else
    docker run ${ARG}
fi

