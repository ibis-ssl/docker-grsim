#!/bin/bash

# TODO use $ ubuntu-drivers devices
if type nvidia-smi; then
    echo "A nvidia driver environment detected."
    docker build . -f ./Dockerfile.nvidia -t ibis/grsim
else
    echo "Non nvidia driver environment detected."
    docker build . -f ./Dockerfile.intel -t ibis/grsim
fi

