---
title: "New one-click AI bot managed ruleset - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/new-one-click-ai-bot-managed-ruleset"
date: "2025-05-13"
scraped_at: "2026-03-02T09:33:26.843175829+00:00"
language: "en-zh"
translated: true
description: " Protect your content from unauthorized AI crawlers with Vercel's new AI bot managed ruleset, offering one-click protection against known AI bots while automatically updating to catch new crawlers wit..."
---

render_with_liquid: false
May 13, 2025

2025年5月13日

![](images/new-one-click-ai-bot-managed-ruleset-vercel/img_001.jpg)![](images/new-one-click-ai-bot-managed-ruleset-vercel/img_002.jpg)

You can now block AI crawlers and scrapers like GPTBot (OpenAI), ClaudeBot (Anthropic), PerplexityBot, Bytespider (ByteDance), and others with a single toggle using the AI bot managed ruleset. Now available for free on all plans.

您现在可通过 AI Bot 托管规则集（AI bot managed ruleset）一键启用，轻松屏蔽 GPTBot（OpenAI）、ClaudeBot（Anthropic）、PerplexityBot、Bytespider（字节跳动）等各类 AI 网络爬虫与数据采集器。该功能现已在所有套餐中免费提供。

The ruleset is managed by Vercel and updates automatically as new crawlers appear, with no additional action required. This protection operates with zero latency impact to legitimate traffic.

该规则集由 Vercel 全权维护，当新型爬虫出现时将自动更新，您无需执行任何额外操作。此防护机制对合法用户流量完全零延迟影响。

For more complete coverage, combine with [**Bot Filter**](https://vercel.com/docs/vercel-firewall/vercel-waf/managed-rulesets#configure-bot-filter-managed-ruleset) to catch AI bots that attempt to spoof user agents to disguise themselves as legitimate browsers or omit proper identification headers.

如需更全面的防护，建议将本规则集与 [**Bot Filter（机器人过滤器）**](https://vercel.com/docs/vercel-firewall/vercel-waf/managed-rulesets#configure-bot-filter-managed-ruleset) 配合使用，以识别并拦截那些试图伪造 User-Agent 冒充真实浏览器、或故意省略标准标识请求头的 AI 机器人。

AI crawlers now generate more traffic than human users on many popular sites, driving up infrastructure costs and raising copyright and data usage concerns. Many of these crawlers do not respect robots.txt or similar directives, making manual solutions unreliable.

目前，在众多热门网站上，AI 爬虫产生的流量已超过真实人类用户，不仅推高基础设施成本，也引发版权归属与数据使用合规性方面的担忧。许多此类爬虫并不遵守 `robots.txt` 或其他类似协议，导致人工配置的防护方案难以可靠生效。

[Enable the ruleset](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Ffirewall%2Fconfigure&title=Enable%20AI%20Bot%20Filter) or learn more [in the documentation](https://vercel.com/docs/vercel-firewall/vercel-waf/managed-rulesets).

[立即启用该规则集](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Ffirewall%2Fconfigure&title=Enable%20AI%20Bot%20Filter)，或前往 [文档中心](https://vercel.com/docs/vercel-firewall/vercel-waf/managed-rulesets) 了解详情。

If you previously used the Block AI Bots template, we recommend switching to this new managed ruleset to benefit from the updated bot lists.

若您此前曾使用过 “Block AI Bots” 模板，我们建议您切换至这一全新的托管规则集，以便及时获得持续更新的 AI 机器人名单。

[**Need more control?**\\
\\
Combine the one-click AI Bot filter with granular conditions or rate-limits for customized protection.\\
\\
Customize](https://vercel.com/docs/vercel-firewall/vercel-waf/custom-rules)

[**需要更精细的控制能力？**  
\\  
将一键式 AI Bot 过滤器与细粒度条件判断或速率限制相结合，实现高度定制化的防护策略。  
\\  
立即自定义](https://vercel.com/docs/vercel-firewall/vercel-waf/custom-rules)