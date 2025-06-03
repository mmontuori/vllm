#!/bin/bash

docker build -f docker/Dockerfile.arm -t vllm-cpu-env --shm-size=4g .
