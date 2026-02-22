---
name: social-connect-mastra-agent
description: Connect to the SocialConnect Mastra Copilot runtime and collaborate with its tool-enabled agent via POST /copilot/agent. Use when a user asks to route work through the repo’s Mastra agent, run AvailableAgents, send GenerateCopilotResponse chat turns, preserve threadId across turns, or operate with cookie/header auth (auth/showorg).
---

# SocialConnect Mastra Agent

Use this skill to delegate work to the SocialConnect backend agent runtime.

## Endpoint

- Base URL (default): `http://localhost:3000`
- Endpoint: `POST /copilot/agent`

## Auth

Use one mode per request:

1. Cookie mode (preferred)
- `Cookie: auth=<JWT>; showorg=<ORG_ID>` (showorg optional)

2. Header mode (NOT_SECURED)
- `auth: <JWT>`
- `showorg: <ORG_ID>` (optional)

## Required payload contract

Always include:
- `variables.properties.integrations`
- `variables.properties.videoEnhancementSettings`

## Workflow

1. Discover available agents
- Call `AvailableAgents`
- Pick best `name` for requested task (content/marketing when relevant)

2. Start or continue thread
- New conversation: `threadId: "new"`
- Existing conversation: reuse saved `threadId`

3. Send turn via `GenerateCopilotResponse`
- Put user text in `variables.data.messages[0].textMessage.content`
- Set `variables.data.agentSession.agentName`
- Save returned `threadId` for next turn

4. Return only useful output
- Prefer latest assistant `TextMessageOutput.content`
- If status failed, return reason/details and suggest retry

## Commands

Use bundled scripts:
- `scripts/mastra_chat.sh discover`
- `scripts/mastra_chat.sh chat "<agentName>" "<message>" [threadId]`
- `scripts/mastra_thread_chat.sh "<conversationKey>" "<agentName>" "<message>"`
  - Auto-loads/saves thread IDs in `data/threads.json` (override with `MASTRA_THREAD_STORE`)

Read `references/payloads.md` for exact request bodies.
