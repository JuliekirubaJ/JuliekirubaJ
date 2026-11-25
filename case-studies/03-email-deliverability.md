# Email Deliverability Investigation

**Role:** analyst · **When:** mid-2026 · **Stack:** Salesforce Account Engagement (Pardot) exports, Excel

## The problem
Webinar email open rates fell by about half in one month across two brands that share a sending program. The first guess was subject lines and content.

## What I did
- Pulled six months of send-level data and lined up opens, click-to-open, hard bounces and opt-outs for each send.
- Click-to-open held steady, so people who opened still engaged. Content was not the cause.
- Found the break point: a large import of **product-engagement contacts** (people who had used a product, not people who had agreed to marketing email) merged into the master list. Sends to that segment hit hard-bounce rates of 6–10% and a spike in opt-outs within one week, which hurt sender reputation for every later send.
- Confirmed that suppression of non-openers was already in place, so the fix had to happen upstream, at import.

## Outcome
- New rule: any new segment is validated and warmed separately before it joins the master list.
- A repeatable deliverability check (authentication records, recent list changes, bounce and complaint rates, sending pattern) now runs before large sends and whenever open rates drop.

## Lesson
"Product-engaged" is not the same as "deliverable". List hygiene is a GTM decision, not only an ops task.
