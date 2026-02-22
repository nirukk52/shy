# Payloads

## Environment variables used by script

- `MASTRA_BASE_URL` (default `http://localhost:3000`)
- `MASTRA_AUTH_COOKIE` (JWT for cookie mode)
- `MASTRA_SHOWORG` (optional org)
- `MASTRA_AUTH_HEADER` (JWT for header mode)
- `MASTRA_FRONTEND_URL` (default `http://localhost:4200/agents/new`)

## AvailableAgents body

```json
{
  "operationName": "AvailableAgents",
  "query": "query AvailableAgents { availableAgents { agents { id name description } } }",
  "variables": {}
}
```

## GenerateCopilotResponse body template

```json
{
  "operationName": "GenerateCopilotResponse",
  "query": "mutation GenerateCopilotResponse($data: GenerateCopilotResponseInput!, $properties: JSONObject) { generateCopilotResponse(data: $data, properties: $properties) { threadId runId status { code ... on FailedResponseStatus { reason details } } messages { __typename id createdAt ... on TextMessageOutput { role content } ... on ResultMessageOutput { actionName result } ... on ActionExecutionMessageOutput { name arguments } } } }",
  "variables": {
    "properties": {
      "integrations": [],
      "videoEnhancementSettings": {}
    },
    "data": {
      "threadId": "new",
      "metadata": { "requestType": "Chat" },
      "frontend": { "actions": [], "url": "http://localhost:4200/agents/new" },
      "agentSession": { "agentName": "<AGENT_NAME>" },
      "messages": [
        {
          "id": "msg-1",
          "createdAt": "2026-02-21T00:00:00.000Z",
          "textMessage": { "role": "user", "content": "<USER_MESSAGE>" }
        }
      ]
    }
  }
}
```
