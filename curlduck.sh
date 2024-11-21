#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Error: No question provided."
  echo "Example: $0 \"What is the distance between the Earth and the Moon?\" "
  exit 1
fi

check_commands() {
  for cmd in "$@"; do
    if ! command -v "$cmd" &> /dev/null; then
      echo "$cmd is not installed or not available in the system's PATH."
    fi
  done
}
check_commands curl sed tr awk grep echo

DUCKDUCKGO_STATUS_URL='https://duckduckgo.com/duckchat/v1/status'
DUCKDUCKGO_CHAT_URL='https://duckduckgo.com/duckchat/v1/chat'
VQD_RESPONSE=$(curl -s -D - -H "x-vqd-accept: 1" $DUCKDUCKGO_STATUS_URL)
VQD_VALUE=$(echo "$VQD_RESPONSE" | grep -i "x-vqd-4:" | awk '{print $2}' | tr -d '\r')
MODEL="meta-llama/Meta-Llama-3.1-70B-Instruct-Turbo"

msg=$(curl -s -X POST "$DUCKDUCKGO_CHAT_URL" \
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
}' -o - | grep -Po '(?<="message":)([[:print:]])+(?=,"created){1}')

# we need this to avoid param expansion
set -f

text=$(echo ${msg})
echo -e ${text//\" \"/}
set +f
