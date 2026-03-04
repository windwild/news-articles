---
render_with_liquid: false
title: "View & query bot verification data in Vercel Observability - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/view-and-query-bot-verification-data-in-vercel-observability"
date: "2025-09-30"
scraped_at: "2026-03-02T09:28:16.544268735+00:00"
language: "en-zh"
translated: true
description: "Analyze traffic to your Vercel projects by bot name, bot category, and bot verification status in Vercel Observability"
---
render_with_liquid: false
render_with_liquid: false

Sep 30, 2025

2025年9月30日

![](images/view-query-bot-verification-data-in-vercel-observability-vercel/img_001.jpg)![](images/view-query-bot-verification-data-in-vercel-observability-vercel/img_002.jpg)

Vercel inspects every request to identify bot traffic. For requests claiming to come from a verified source, Vercel cross-checks against its directory of [verified bots](https://vercel.com/docs/bot-management#verified-bots) and validates them against strict verification criteria.

Vercel 会检查每个请求，以识别机器人流量。对于声称来自已验证来源的请求，Vercel 将对照其[已验证机器人目录](https://vercel.com/docs/bot-management#verified-bots)进行交叉核验，并依据严格的验证标准进行校验。

We've added three new dimensions to the query builder when analyzing Edge Requests to help you understand bot activity to your projects:

我们在分析边缘请求（Edge Requests）时，为查询构建器（query builder）新增了三个维度，帮助您更深入地了解流向您项目的机器人活动：

- **Bot name:** Identify specific bots  
- **机器人名称**：识别特定机器人  

- **Bot category:** Group bots by type  
- **机器人类别**：按类型对机器人进行分组  

- **Bot verified:** Distinguish between verified, spoofed, and unverifiable bots  
- **机器人已验证状态**：区分已验证、伪造（spoofed）及无法验证的机器人  

Additionally, the Edge Requests dashboard in Observability now displays verification badges next to bot names.

此外，可观测性（Observability）中的“边缘请求”仪表板现在会在机器人名称旁显示验证徽章（verification badge）。

All users can view bot verification badge while Observability Plus subscribers can query this data at no extra cost.

所有用户均可查看机器人验证徽章；而订阅了“可观测性 Plus”（Observability Plus）的用户则可免费查询该数据。

[Try it out](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fobservability%2Fnotebooks) or learn more about [Observability](https://vercel.com/docs/observability) and [Observability Plus](https://vercel.com/docs/observability/observability-plus).

[立即试用](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fobservability%2Fnotebooks)，或进一步了解 [可观测性（Observability）](https://vercel.com/docs/observability) 和 [可观测性 Plus（Observability Plus）](https://vercel.com/docs/observability/observability-plus)。