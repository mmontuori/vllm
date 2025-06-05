#!/bin/bash

source scripts/setenv.sh

container_id=`docker ps | grep vllm-cpu-env | awk '{ print $1 }'`

echo "container is: $container_id"

docker logs -f $container_id