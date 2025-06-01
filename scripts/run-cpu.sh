#!/bin/bash

source scripts/setenv.sh

if ! docker volume inspect ${workspace_volume}>/dev/null; then
    echo "volume ${workspace_volume} not found! Creating it..."
    docker volume create ${workspace_volume}
fi
    
docker run --rm \
    --privileged=true \
    --shm-size=4g \
    --volume ${workspace_volume}:/workspace \
    -p 8000:8000 \
    -e VLLM_CPU_KVCACHE_SPACE=${VLLM_CPU_KVCACHE_SPACE} \
    -e VLLM_CPU_OMP_THREADS_BIND=${VLLM_CPU_OMP_THREADS_BIND} \
    vllm-cpu-env \
    --model=${model} \
    --dtype=bfloat16