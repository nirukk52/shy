#!/usr/bin/env bash
set -euo pipefail

WORKDIR="/Users/priyankalalge/.openclaw/workspace"
cd "$WORKDIR"

TODAY="$(date +%Y-%m-%d)"
NOW="$(date '+%Y-%m-%d %H:%M:%S %Z')"
mkdir -p memory

# Ensure core files exist
for f in SOUL.md AGENTS.md MEMORY.md TOOLS.md BOOTSTRAP.md; do
  [[ -f "$f" ]] || echo "# $f" > "$f"
done

# Daily memory note
DAILY="memory/${TODAY}.md"
if [[ ! -f "$DAILY" ]]; then
  cat > "$DAILY" <<EOF
# ${TODAY}

## Core docs update
- Initialized daily memory entry.
EOF
else
  if ! grep -q "Core docs update" "$DAILY"; then
    cat >> "$DAILY" <<EOF

## Core docs update
- Updated at ${NOW}
EOF
  fi
fi

# Long-term memory checkpoint (idempotent per day)
if ! grep -q "${TODAY} — Core docs sync checkpoint" MEMORY.md; then
  cat >> MEMORY.md <<EOF

## ${TODAY} — Core docs sync checkpoint
- Synchronized SOUL.md, AGENTS.md, MEMORY.md, TOOLS.md, and BOOTSTRAP.md with latest operating context.
EOF
fi

# Optional git commit if there are changes
if ! git diff --quiet -- SOUL.md AGENTS.md MEMORY.md TOOLS.md BOOTSTRAP.md "$DAILY"; then
  git add SOUL.md AGENTS.md MEMORY.md TOOLS.md BOOTSTRAP.md "$DAILY"
  git commit -m "Core docs sync (${TODAY})" || true
fi

echo "✅ Core docs sync complete"
echo "Updated files: SOUL.md AGENTS.md MEMORY.md TOOLS.md BOOTSTRAP.md ${DAILY}"
