#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STORE_PATH="${MASTRA_THREAD_STORE:-$SCRIPT_DIR/../data/threads.json}"

usage() {
  cat <<EOF
Usage:
  $0 "<conversationKey>" "<agentName>" "<message>"

Example:
  $0 morya-main "Morya Content Agent" "Create 5 Instagram hooks"
EOF
}

if [[ $# -lt 3 ]]; then
  usage
  exit 1
fi

KEY="$1"
AGENT_NAME="$2"
MESSAGE="$3"

mkdir -p "$(dirname "$STORE_PATH")"
if [[ ! -f "$STORE_PATH" ]]; then
  echo '{}' > "$STORE_PATH"
fi

THREAD_ID=$(python3 - <<PY
import json
p = "$STORE_PATH"
k = "$KEY"
try:
    data = json.load(open(p))
except Exception:
    data = {}
print(data.get(k, "new"))
PY
)

RAW=$("$SCRIPT_DIR/mastra_chat.sh" chat "$AGENT_NAME" "$MESSAGE" "$THREAD_ID")

echo "$RAW" | python3 - <<PY
import json,sys
obj=json.loads(sys.stdin.read())
resp=obj.get('data',{}).get('generateCopilotResponse',{})
thread=resp.get('threadId')
msgs=resp.get('messages',[])
text=''
for m in reversed(msgs):
    if m.get('__typename')=='TextMessageOutput' and m.get('role')=='assistant':
        text=m.get('content','')
        break
print(json.dumps({"threadId": thread, "assistant": text}, ensure_ascii=False))
PY

NEW_THREAD=$(echo "$RAW" | python3 - <<PY
import json,sys
obj=json.loads(sys.stdin.read())
print(obj.get('data',{}).get('generateCopilotResponse',{}).get('threadId',''))
PY
)

if [[ -n "$NEW_THREAD" ]]; then
  python3 - <<PY
import json
p = "$STORE_PATH"
k = "$KEY"
v = "$NEW_THREAD"
try:
    data = json.load(open(p))
except Exception:
    data = {}
data[k]=v
with open(p,'w') as f:
    json.dump(data,f,indent=2)
PY
fi
