# AEO Visibility Tracker

A small, public version of the AI-search checks I run weekly at work. Two parts:

## 1. Technical readiness: `aeo-check.ps1`

```powershell
.\aeo-check.ps1 -Site https://example.com -Pages /,/pricing,/blog/what-is-xyz
```

Reports whether `llms.txt` exists, whether robots.txt blocks AI crawlers, and for each page: JSON-LD types, H1 count, meta description length and question-style H2s. Writes `aeo-results.csv`.

## 2. Visibility log: `prompt-log.csv`

A fixed list of buyer questions, run weekly in ChatGPT, Perplexity, Gemini, Google AI Overviews and Copilot. For each answer, record whether the brand is mentioned, whether its site is cited, and which competitors appear. The week-over-week change is the metric; one run on its own tells you little.

| Column | Meaning |
|---|---|
| week | Monday of the run |
| engine | chatgpt / perplexity / gemini / ai-overviews / copilot |
| prompt | the exact question |
| brand_mentioned | yes / no |
| brand_cited | yes / no (link to our site in sources) |
| competitors | names that appeared |
| cited_domains | domains in the sources list |

Pair it with GA4: a custom channel group or a filter on session source matching `chatgpt|perplexity|gemini|copilot` shows AI-referral sessions and which landing pages they hit.
