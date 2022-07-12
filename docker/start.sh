#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: sh start.sh DATA_DIR_PATH"
    echo "Where DATA_DIR_PATH - path to dir to be mount to container"
exit 1
fi

get_real_path(){
  if [ "${1:0:1}" == "/" ]; then
    echo "$1"
  else
    echo realpath -m "$PWD"/"$1"
  fi
}


DATA_DIR=$1

orange=`tput setaf 3`
reset_color=`tput sgr0`

export ARCH=`uname -m`

echo "Running on ${orange}${ARCH}${reset_color}"

if [ "$ARCH" == "x86_64" ] 
then
    ARGS="--ipc host --gpus all -e NVIDIA_DRIVER_CAPABILITIES=all"
elif [ "$ARCH" == "aarch64" ] 
then
    ARGS="--runtime nvidia"
else
    echo "Arch ${ARCH} not supported"
    exit
fi


docker run -it -d --rm \
        --env="DISPLAY=$DISPLAY" \
        --env="QT_X11_NO_MITSHM=1" \
        --privileged \
        --name openroaded \
        --net "host" \
        -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
        -v "$DATA_DIR":/workspace/data:rw \
        ${ARCH}.openroaded:latest

    # "$ARGS" \
