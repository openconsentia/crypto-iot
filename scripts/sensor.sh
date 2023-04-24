#!/bin/bash

export SENSOR_IMAGE=oc/sensor:current
export GO_VER=golang:1.20

COMMAND=$1

function build(){
    docker-compose -f ./build/sensor/builder.yml build
}

function clean(){
    docker rmi -f ${SENSOR_IMAGE}
    docker rmi -f $(docker images --filter "dangling=true" -q)
}

case $COMMAND in
    "build")
        build
        ;;
    "clean")
        clean
        ;;
    *)
        echo "Usage: $0 [command]

command:
    build    sensor image
    clean    clear docker cache"
        ;;
esac