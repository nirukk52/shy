#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 2 ]]; then
  echo "Usage: $(basename "$0") <agent-id> <message...>"
  echo "Example: $(basename "$0") personal-agent \"Plan my day\""
  exit 1
fi

AGENT_ID="$1"
shift
MESSAGE="$*"

openclaw agent --agent "$AGENT_ID" --message "$MESSAGE"
