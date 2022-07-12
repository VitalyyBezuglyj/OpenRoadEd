#!/bin/bash

NUM_THREADS=6
echo "Building OpenRoadEd..."

docker build .. \
    -f Dockerfile \
    --build-arg UID=$(id -g) \
    --build-arg GID=$(id -g) \
    --build-arg NUM_THREADS=${NUM_THREADS} \
    -t open-road-ed:latest
