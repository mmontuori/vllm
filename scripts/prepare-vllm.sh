#!/bin/bash

source scripts/setenv.sh

container_id=`docker ps | grep vllm-cpu-env | awk '{ print $1 }'`

echo "container is: $container_id"

# TBD prepare the empty container/volume
#docker exec -it $container_id "commands"