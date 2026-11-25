# UTM Builder + GA4 Attribution Walkthrough

Open [`index.html`](index.html) in a browser (or via GitHub Pages). It builds a tagged campaign link and checks it against naming rules.

## Example: one webinar, four channels

| Channel | utm_source | utm_medium | utm_content |
|---|---|---|---|
| LinkedIn company post | linkedin | organic-social | post-announce |
| LinkedIn sponsored ad | linkedin | paid-social | ad-carousel-a |
| Google Search ad | google | cpc | rsa-1 (+ utm_term) |
| Pardot invite email | pardot | email | invite-1 |

All four share `utm_campaign=2026-12_fp-and-a-modernization-webinar`.

## How it shows up in GA4

1. **Key event:** the registration thank-you page fires `generate_lead` (or a custom `webinar_registration` event), marked as a key event in GA4 Admin.
2. **Report:** Advertising → Attribution → or Explore → Free form with *Session campaign* × *Session source / medium* as rows and *Key events (webinar_registration)* as the value.
3. **Read:** registrations by channel for the same campaign, on the same basis, so paid and organic can be compared with cost per registration.

## Common mistakes this prevents
- `LinkedIn` vs `linkedin` splitting one source into two rows
- Social traffic landing in "Unassigned" because the medium doesn't match GA4's channel rules
- Repeat webinars overwriting each other because campaign names aren't dated
