---
title: "Bot Protection is now generally available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/bot-protection-is-now-generally-available"
date: "2025-06-05"
scraped_at: "2026-03-02T09:33:18.037215289+00:00"
language: "en"
translated: false
description: "Vercel's Bot Protection managed ruleset allows users to mitigate unwanted bot activity on their projects in a single click"
---




Jun 5, 2025

![](images/bot-protection-is-now-generally-available-vercel/img_001.jpg)![](images/bot-protection-is-now-generally-available-vercel/img_002.jpg)

Vercel Web Application Firewall's [Bot Protection managed ruleset](https://vercel.com/docs/bot-management#bot-protection-managed-ruleset) is now generally available for all users, at no additional cost.

Bot Protection helps reduce automated traffic from non-browser sources and allows you to respond based on two action choices:

- **Log Only Action:** Logs identified bot traffic in the Firewall tab without blocking requests

- **Challenge Action:** Serves a [browser challenge](https://vercel.com/docs/vercel-firewall/firewall-concepts#challenge) to traffic from non-browser sources. [Verified bots](https://vercel.com/docs/bot-protection#verified-bots) are automatically excluded


During the beta period, Bot Protection challenged over 650 million requests of potential non-browser requests.

Bot Protection complements Vercel's existing mitigations, which already block common threats like DDoS attacks, low quality traffic, and spoofed traffic. It adds an extra layer of protection for any automated traffic that is not clearly malicious.

Learn more about the [Bot Protection managed ruleset](https://vercel.com/docs/vercel-waf/managed-rulesets) and the [Vercel Firewall.](https://vercel.com/docs/vercel-firewall) If you'd like your [bot to be verified as well, head over to bots.fyi.](https://bots.fyi/new-bot)