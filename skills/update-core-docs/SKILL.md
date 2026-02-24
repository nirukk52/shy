---
name: update-core-docs
description: Update and sync workspace core docs (SOUL.md, AGENTS.md, MEMORY.md, TOOLS.md, BOOTSTRAP.md) and daily memory checkpoint. Use when user asks to refresh core docs, run /update-core-docs, or systematically sync documentation after research updates.
---

# Update Core Docs

Run this skill when the user asks to systematically refresh core workspace docs.

## Command

From workspace root:

```bash
bash scripts/update-core-docs.sh
```

## What it does

- Ensures these files exist: `SOUL.md`, `AGENTS.md`, `MEMORY.md`, `TOOLS.md`, `BOOTSTRAP.md`
- Ensures today's daily memory file exists at `memory/YYYY-MM-DD.md`
- Appends a daily core-doc sync checkpoint to `MEMORY.md` (idempotent per day)
- Creates a git commit when core docs changed

## After running

1. Report which files changed.
2. Share the commit hash if a commit was created.
3. If no changes were needed, say so explicitly.
