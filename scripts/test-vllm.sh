model="facebook/opt-125m"
question="what is the capital of italy"
max_tokens="7"
temperature="0"

curl -X 'POST'   'http://192.168.1.50:8000/v1/completions' \
    -H 'accept: application/json' \
    -H 'Content-Type: application/json' \
    -d "{ \
        \"model\": \"${model}\", \
        \"prompt\": \"${question}\", \
        \"max_tokens\": ${max_tokens}, \
        \"temperature\": ${temperature} \
    }"