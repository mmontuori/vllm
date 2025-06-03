#!/bin/bash

source scripts/setenv.sh

if ! docker volume inspect ${workspace_volume}>/dev/null; then
    echo "volume ${workspace_volume} not found! Creating it..."
    docker volume create ${workspace_volume}
fi
    
docker run -it \
             --rm \
             --network=host \
             --cpuset-cpus=<cpu-id-list, optional> \
             --cpuset-mems=<memory-node, optional> \
             vllm-cpu-env