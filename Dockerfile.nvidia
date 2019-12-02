FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu18.04

ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES},display


RUN apt-get update -q -qq && apt-get upgrade -y && apt-get install -q -qq -y \
    git build-essential cmake qt5-default libqt5opengl5-dev libgl1-mesa-dev libglu1-mesa-dev libprotobuf-dev protobuf-compiler libode-dev libboost-dev
RUN git clone https://github.com/jpfeltracco/vartypes.git &&\
    cd vartypes && mkdir build && cd build &&\
    cmake .. &&\
    make &&\
    make install
RUN mkdir /grsim_ws &&\
    cd grsim_ws &&\
    git clone https://github.com/RoboCup-SSL/grSim.git &&\
    cd grSim &&\
    mkdir build &&\
    cd build &&\
    cmake .. &&\
    make
