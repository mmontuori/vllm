#!/bin/bash

question="what is the capital of Frnce?"

source scripts/setenv.sh

curl -X 'POST'   'http://192.168.1.50:8000/v1/completions' \
    -H 'accept: application/json' \
    -H 'Content-Type: application/json' \
    -d "{ \
        \"model\": \"${model}\", \
        \"prompt\": \"${question}\", \
        \"max_tokens\": ${max_tokens}, \
        \"temperature\": ${temperature} \
    }"