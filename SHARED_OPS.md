# SHARED_OPS.md — MoryaPA ↔ Video Editor Handoff Protocol

## Shared Workspace
Both `morya-pa` and `video-editor` operate in the same workspace.

## Directory Convention
```
assets/          → source files (logos, fonts, brand assets)
briefs/          → morya-pa writes briefs here for video-editor
output/          → video-editor writes finished files here
tmp/             → scratch frames, intermediate files
scripts/         → reusable ffmpeg/python scripts
```

## Handoff Flow
1. **morya-pa** creates `briefs/<YYYY-MM-DD>-<slug>.md` with:
   - Content type (reel/post/story)
   - Hook text + VO script
   - Shot list / source files
   - Output specs (resolution, duration, format)
   - CTA overlay text
2. **video-editor** reads the brief, produces output, saves to `output/<slug>.<ext>`
3. **video-editor** reports back: file path, file size, duration, resolution
4. **morya-pa** reviews output and uploads to Google Drive

## Google Drive Assets Folder
https://drive.google.com/drive/folders/1P-G24z7rehbS5UzgX8JkQRcRA6P-KAKk

## Instagram Output Specs
- Reels: 9:16, 1080x1920, <60s, H.264, AAC
- Posts: 1:1 (1080x1080) or 4:5 (1080x1350)
- Stories: 9:16, 1080x1920, <15s per slide
- Thumbnails: 1080x1080, PNG or JPG
