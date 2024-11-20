#!/bin/sh

check_commands() {
  for cmd in "$@"; do
    if command -v "$cmd" &> /dev/null; then
      true
    else
      echo "$cmd is not installed or not available in the system's PATH."
    fi
  done
}
check_commands curl jq sed tr awk grep echo

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
