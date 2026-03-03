---
title: "New one-click AI bot managed ruleset - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/new-one-click-ai-bot-managed-ruleset"
date: "2025-05-13"
scraped_at: "2026-03-02T09:33:26.843175829+00:00"
language: "en"
translated: false
description: " Protect your content from unauthorized AI crawlers with Vercel's new AI bot managed ruleset, offering one-click protection against known AI bots while automatically updating to catch new crawlers wit..."
---




May 13, 2025

![](images/new-one-click-ai-bot-managed-ruleset-vercel/img_001.jpg)![](images/new-one-click-ai-bot-managed-ruleset-vercel/img_002.jpg)

You can now block AI crawlers and scrapers like GPTBot (OpenAI), ClaudeBot (Anthropic), PerplexityBot, Bytespider (ByteDance), and others with a single toggle using the AI bot managed ruleset. Now available for free on all plans.

The ruleset is managed by Vercel and updates automatically as new crawlers appear, with no additional action required. This protection operates with zero latency impact to legitimate traffic.

For more complete coverage, combine with [**Bot Filter**](https://vercel.com/docs/vercel-firewall/vercel-waf/managed-rulesets#configure-bot-filter-managed-ruleset) to catch AI bots that attempt to spoof user agents to disguise themselves as legitimate browsers or omit proper identification headers.

AI crawlers now generate more traffic than human users on many popular sites, driving up infrastructure costs and raising copyright and data usage concerns. Many of these crawlers do not respect robots.txt or similar directives, making manual solutions unreliable.

[Enable the ruleset](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Ffirewall%2Fconfigure&title=Enable%20AI%20Bot%20Filter) or learn more [in the documentation](https://vercel.com/docs/vercel-firewall/vercel-waf/managed-rulesets).

If you previously used the Block AI Bots template, we recommend switching to this new managed ruleset to benefit from the updated bot lists.

[**Need more control?**\\
\\
Combine the one-click AI Bot filter with granular conditions or rate-limits for customized protection.\\
\\
Customize](https://vercel.com/docs/vercel-firewall/vercel-waf/custom-rules)