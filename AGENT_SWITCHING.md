# Agent Switching (Current Practical Setup)

## Reality today
The Control UI left sidebar is session-first, not a dedicated agent picker.

## Fast switch command
Use terminal helper:

```bash
./scripts/agent-chat.sh main "Summarize open tasks"
./scripts/agent-chat.sh personal-agent "Draft family check-in"
```

This explicitly chooses the target agent for each turn.

## Optional convenience aliases
Add to your shell profile:

```bash
alias oc-main='openclaw agent --agent main --message'
alias oc-pa='openclaw agent --agent personal-agent --message'
```

Usage:

```bash
oc-main "Status"
oc-pa "Plan groceries for this week"
```

## Next step for true selection behavior
Add routing bindings so specific channels/peers always land on `personal-agent`.
For example: one WhatsApp group or one DM peer -> personal-agent.
