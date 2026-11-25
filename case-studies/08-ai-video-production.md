# AI-Assisted Video Production

**Role:** producer and builder · **When:** Oct-Nov 2026 · **Stack:** Claude Code (webinar-snippets skill, video-producer agent), PowerShell, PowerPoint automation (COM), Zoom recordings, Google Search Console

## The problem
Every webinar produces an hour of good material, and the product teams wanted weekly short videos for LinkedIn and YouTube Shorts. There was no dedicated editor, and doing it by hand in a video tool took most of a day per clip.

## What I built

### 1. Webinar → short clips
- **AI picks the moments.** A `webinar-snippets` skill reads the transcript and abstract and returns 5-10 standalone snippets: exact start and end timestamps, the opening and closing words, the verbatim transcript, cut notes and a suggested outro.
- **A script makes the cuts.** It trims the Zoom recordings in PowerPoint (camera track for audio, screen share muted where needed) and builds vertical 1080×1920 clips with a kinetic headline, captions, stat cards and a logo outro, then exports MP4.
- **Fixed deliverables per webinar:** the full recording by T+1, then a best clip and snippets by T+2, tracked as three rows in the team tracker.

### 2. Weekly chart Shorts, chosen by search data
- Topics come from the chart keywords that already rank in Search Console (pie charts first), so each Short answers something people are searching for.
- 20-30 seconds, with the hook on the first frame.
- Built by script over real product screenshots, so the next Short is a change of data and copy, not a new edit.

### 3. Product explainers
- Longer animated explainers (for example an 8-scene, ~55-second chart explainer) in a light SaaS motion style: floating UI cards, kinetic type, cursor and highlight beats.
- A QA script pulls still frames at set times, so timing and framing can be checked without watching every render.

## Examples
- [Pie chart Short (MP4)](../assets/pie-chart-short.mp4)
- [Waterfall chart Short (MP4)](../assets/waterfall-short.mp4)

## What I learned
- Let the AI do selection and timestamps, which is slow for a person. Keep the cut and brand rules in code, so every clip looks the same.
- Automation has odd failure modes. One bug silently rounded every animation delay to a whole second; checking the saved file, not the script, found it.

## Reusable version
The pipeline and guides are in the public [marketing-agent-team](https://github.com/JuliekirubaJ/marketing-agent-team) repo under `pipelines/video-production` and `docs/video-production.md`.
