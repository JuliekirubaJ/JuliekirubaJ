# LinkedIn Growth and Social Listening

**Role:** owner of two company LinkedIn pages · **When:** 2025-2026 · **Stack:** LinkedIn page analytics exports, Claude Code agents, PowerShell, Excel

## Context
I run two company LinkedIn pages with different audiences: one for enterprise planning on Microsoft Fabric, one for Power BI reporting and visuals. Reddit is used for listening first and promotion second.

## What I built
- **Post analysis that reads the export correctly.** LinkedIn's page export has a "Clicks" column that counts every interaction, not link clicks. Once that was handled, the pattern was clear: company milestone posts got about 3× the engagement of promotional posts, which changed the posting mix.
- **A growth and listening agent** for the Power BI visuals page. It reviews the website's assets, listens to LinkedIn conversations on Power BI, Fabric, reporting and FP&A, tracks competitor pages, and returns numbered post recommendations aimed at site visits and demo requests. Nothing is written to the social calendar until a recommendation ID is approved.
- **Recurring series** with a fixed format, for example a weekly "100 Charts Explained" carousel and weekly chart Shorts (see [creative](06-creative-automation.md) and [video](08-ai-video-production.md)).
- **Weekly follower tracking:** a Monday reminder plus a script that logs follower counts for both pages into the shared tracker, safely on a synced, co-authored file.
- **Reddit voice-of-customer research** across r/PowerBI, r/MicrosoftFabric, r/FPandA and related subreddits: the exact words people use for their problems, failed workarounds and objections, turned into post hooks, webinar angles and ad copy.

## Outcome
- Content decisions rest on what the data says, not on what was posted last month.
- Approval by ID keeps a human in charge of what goes on the calendar.
- Ad and post copy uses the audience's own language.
