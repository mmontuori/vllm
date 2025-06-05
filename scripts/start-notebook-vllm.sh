#!/bin/bash

source scripts/setenv.sh

container_id=`docker ps | grep vllm-cpu-env | awk '{ print $1 }'`

if [ -z "$container_id" ]; then
    echo "No running container found for vllm-cpu-env. Please start the container first."
    exit 1
fi

echo "container is: $container_id"

docker exec $container_id pip install notebook
docker exec $container_id jupyter notebook --allow-root --ip=0.0.0.0