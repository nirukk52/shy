# ROUTING_BLUEPRINT.md

## Source of truth for skills
- Primary catalog for selecting new skills: https://github.com/VoltAgent/awesome-openclaw-skills
- Before adding any new skill, validate relevance + security posture (review README entry + source + risk).

## Approval policy
- No external action unless user reply is exactly: `APPROVED`
- Until then, planning, local file edits, and dry-run prep only.

## Phase 1 Core Pods (drafted, not yet activated)

Each pod is a single sub-agent candidate with 6–9 skills max.

### 1) Client Engine Pod (7 skills)
Goal: outreach pipeline, follow-ups, CRM hygiene, meeting prep

Skills (from awesome-openclaw-skills):
1. attio
2. apollo
3. campaign-orchestrator
4. calendly
5. gog
6. communication-skill
7. apple-notes

### 2) Delivery Pod (7 skills)
Goal: project tracking, deadlines, status updates, blockers

Skills (from awesome-openclaw-skills):
1. asana
2. atlassian-mcp
3. github
4. cron-scheduling
5. project-context-sync
6. gog
7. apple-reminders

### 3) Income Pod (7 skills)
Goal: rank projects by revenue velocity, prioritize/kill low-ROI

Skills (from awesome-openclaw-skills):
1. business-development
2. business-model-canvas
3. trend-watcher
4. financial-calculator
5. blog-writer
6. ceo-advisor
7. notion

### 4) Life Ops Pod (7 skills)
Goal: diet routines, groceries, recurring personal planning

Skills (from awesome-openclaw-skills):
1. diet-tracker
2. calorie-counter
3. bring-recipes
4. cookidoo
5. apple-reminders
6. goplaces
7. apple-notes

## Constraints
- Main router: Niranjan PA (high-level routing only)
- Max 4 sub-agents per agent
- Max 6–9 skills per sub-agent
