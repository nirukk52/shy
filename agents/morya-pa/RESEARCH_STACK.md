# Morya PA Research Stack

## Recommended persistence setup (practical)

### 1) Google Sheets = source of truth (recommended)
Use a shared Google Sheet first. Fast to edit, easy for VA/editor/founder collaboration, and easy to ingest into your scheduler platform.

Suggested tabs:
1. `accounts` — client + competitors metadata
2. `reels_raw` — scraped post/reel rows
3. `patterns` — hook/caption/audio/cta patterns
4. `assets` — approved hooks, captions, VO scripts, hashtag clusters
5. `calendar` — scheduled content plan
6. `performance` — weekly KPI snapshots (DMs, interested comments, saves, reach)

### 2) Workspace files = versioned snapshots
Store exports and summaries in this repo for reproducibility.

Path convention:
- `research/morya-pa/YYYY-MM-DD/raw/`
- `research/morya-pa/YYYY-MM-DD/analysis/`
- `research/morya-pa/YYYY-MM-DD/brief.md`

### 3) Platform DB = production runtime
Once templates stabilize, sync approved rows from Sheets into your platform DB.

---

## Minimal schema (for your scheduler/generation system)
Each content unit should have:
- `client_id`
- `persona` (groom | groom_squad | festive_buyer)
- `objective` (dm | comment | save | share)
- `pillar` (product_detail | transformation | occasion | testimonial | bts)
- `hook_text`
- `voiceover_text`
- `caption_template`
- `cta_type`
- `cta_keyword`
- `hashtag_cluster`
- `visual_recipe`
- `language_mix` (mr | mr-en)
- `status` (draft | approved | scheduled | posted)
- `kpi_result` (json)

---

## Decision
For now: **Google Sheets + repo snapshots** is the best combo.
- Sheets for collaboration and speed
- Repo for audit trail and deterministic prompts
