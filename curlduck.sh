#!/bin/bash
#TODO:
# 1. check_commands curl grep awk sed jq tr
# 2. available models

DUCKDUCKGO_STATUS_URL='https://duckduckgo.com/duckchat/v1/status'
DUCKDUCKGO_CHAT_URL='https://duckduckgo.com/duckchat/v1/chat'
VQD_RESPONSE=$(curl -s -D - -H "x-vqd-accept: 1" $DUCKDUCKGO_STATUS_URL)
VQD_VALUE=$(echo "$VQD_RESPONSE" | grep -i "x-vqd-4:" | awk '{print $2}' | tr -d '\r')
MODEL="meta-llama/Meta-Llama-3.1-70B-Instruct-Turbo"

curl -s -X POST "$DUCKDUCKGO_CHAT_URL" \
-H "Content-Type: application/json" \
-H "x-vqd-4: $VQD_VALUE" \
-d '{
    "model": "'$MODEL'",
    "messages": [
        {
            "content": "'"$1"'",
            "role": "user"
        }
    ]
}' -o - | sed -e '/^$/d' -e "s/data://g" -e '/\[DONE\]/d' | jq -r .message | tr -d '\n'
echo -e "\n"
