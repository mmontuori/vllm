#!/bin/bash

source scripts/setenv.sh

if ! docker volume inspect ${workspace_volume}>/dev/null; then
    echo "volume ${workspace_volume} not found! Creating it..."
    docker volume create ${workspace_volume}
fi

cmd="$1"

if [ "$cmd" == "" ]; then
    cmd="vllm-cpu-env --model=${model} --dtype=bfloat16"
else
    cmd="-ti --entrypoint ${cmd} vllm-cpu-env"
fi

docker run --rm \
    --privileged=true \
    --shm-size=4g \
    --detach \
    --volume ${workspace_volume}:/workspace \
    --name lvvm-cpu \
    -p 8000:8000 \
    -p 8888:8888 \
    -e VLLM_CPU_KVCACHE_SPACE=${VLLM_CPU_KVCACHE_SPACE} \
    -e VLLM_CPU_OMP_THREADS_BIND=${VLLM_CPU_OMP_THREADS_BIND} \
    ${cmd}