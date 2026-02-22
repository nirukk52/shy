#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${MASTRA_BASE_URL:-http://localhost:3000}"
ENDPOINT="$BASE_URL/copilot/agent"
FRONTEND_URL="${MASTRA_FRONTEND_URL:-http://localhost:4200/agents/new}"

build_headers() {
  local tmp
  tmp=$(mktemp)
  echo "Content-Type: application/json" > "$tmp"

  if [[ -n "${MASTRA_AUTH_COOKIE:-}" ]]; then
    if [[ -n "${MASTRA_SHOWORG:-}" ]]; then
      echo "Cookie: auth=${MASTRA_AUTH_COOKIE}; showorg=${MASTRA_SHOWORG}" >> "$tmp"
    else
      echo "Cookie: auth=${MASTRA_AUTH_COOKIE}" >> "$tmp"
    fi
  elif [[ -n "${MASTRA_AUTH_HEADER:-}" ]]; then
    echo "auth: ${MASTRA_AUTH_HEADER}" >> "$tmp"
    if [[ -n "${MASTRA_SHOWORG:-}" ]]; then
      echo "showorg: ${MASTRA_SHOWORG}" >> "$tmp"
    fi
  fi

  echo "$tmp"
}

post_json() {
  local body="$1"
  local headers_file
  headers_file=$(build_headers)
  curl -sS -X POST "$ENDPOINT" \
    --header @"$headers_file" \
    -d "$body"
  rm -f "$headers_file"
}

cmd_discover() {
  local body='{"operationName":"AvailableAgents","query":"query AvailableAgents { availableAgents { agents { id name description } } }","variables":{}}'
  post_json "$body"
}

cmd_chat() {
  local agent_name="$1"
  local message="$2"
  local thread_id="${3:-new}"
  local now
  now=$(date -u +"%Y-%m-%dT%H:%M:%S.000Z")

  local body
  body=$(cat <<JSON
{"operationName":"GenerateCopilotResponse","query":"mutation GenerateCopilotResponse(\$data: GenerateCopilotResponseInput!, \$properties: JSONObject) { generateCopilotResponse(data: \$data, properties: \$properties) { threadId runId status { code ... on FailedResponseStatus { reason details } } messages { __typename id createdAt ... on TextMessageOutput { role content } ... on ResultMessageOutput { actionName result } ... on ActionExecutionMessageOutput { name arguments } } } }","variables":{"properties":{"integrations":[],"videoEnhancementSettings":{}},"data":{"threadId":"$thread_id","metadata":{"requestType":"Chat"},"frontend":{"actions":[],"url":"$FRONTEND_URL"},"agentSession":{"agentName":"$agent_name"},"messages":[{"id":"msg-1","createdAt":"$now","textMessage":{"role":"user","content":"$message"}}]}}}
JSON
)
  post_json "$body"
}

usage() {
  cat <<EOF
Usage:
  $0 discover
  $0 chat "<agentName>" "<message>" [threadId]
EOF
}

main() {
  local cmd="${1:-}"
  case "$cmd" in
    discover)
      cmd_discover
      ;;
    chat)
      if [[ $# -lt 3 ]]; then
        usage; exit 1
      fi
      cmd_chat "$2" "$3" "${4:-new}"
      ;;
    *)
      usage; exit 1
      ;;
  esac
}

main "$@"
