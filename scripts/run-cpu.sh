#!/bin/bash

source scripts/setenv.sh
    
docker run --rm \
    --privileged=true \
    --shm-size=4g \
    -p 8000:8000 \
    -e VLLM_CPU_KVCACHE_SPACE=${VLLM_CPU_KVCACHE_SPACE} \
    -e VLLM_CPU_OMP_THREADS_BIND=${VLLM_CPU_OMP_THREADS_BIND} \
    vllm-cpu-env \
    --model=${model} \
    --dtype=bfloat16