#!/bin/bash

model="facebook/opt-125m"
    
docker run --rm \
    --privileged=true \
    --shm-size=4g \
    -p 8000:8000 \
    -e VLLM_CPU_KVCACHE_SPACE=1 \
    -e VLLM_CPU_OMP_THREADS_BIND=0-4 \
    vllm-cpu-env \
    --model=${model} \
    --dtype=bfloat16