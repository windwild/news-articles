---
title: "Bot Protection is now generally available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/bot-protection-is-now-generally-available"
date: "2025-06-05"
scraped_at: "2026-03-02T09:33:18.037215289+00:00"
language: "en-zh"
translated: true
description: "Vercel's Bot Protection managed ruleset allows users to mitigate unwanted bot activity on their projects in a single click"
---
&#123;% raw %}

Jun 5, 2025

2025年6月5日

![](images/bot-protection-is-now-generally-available-vercel/img_001.jpg)![](images/bot-protection-is-now-generally-available-vercel/img_002.jpg)

Vercel Web Application Firewall 的 [Bot Protection 托管规则集](https://vercel.com/docs/bot-management#bot-protection-managed-ruleset) 现已面向所有用户正式发布（Generally Available），且无需额外付费。

Bot Protection 有助于减少来自非浏览器来源的自动化流量，并支持您根据以下两种操作方式进行响应：

- **仅记录操作（Log Only Action）：** 在“防火墙”（Firewall）标签页中记录被识别为机器人的流量，但不拦截请求；  
- **质询操作（Challenge Action）：** 向来自非浏览器来源的流量提供 [浏览器质询（browser challenge）](https://vercel.com/docs/vercel-firewall/firewall-concepts#challenge)。[已验证机器人（Verified bots）](https://vercel.com/docs/bot-protection#verified-bots) 将自动豁免该质询。

在公测（beta）阶段，Bot Protection 已对超过 6.5 亿次疑似非浏览器请求发起质询。

Bot Protection 是对 Vercel 现有防护能力的重要补充——后者已能有效拦截 DDoS 攻击、低质量流量及伪造流量等常见威胁。Bot Protection 进一步增强了对“非明显恶意但属自动化”的流量的防护能力。

了解更多关于 [Bot Protection 托管规则集](https://vercel.com/docs/vercel-waf/managed-rulesets) 和 [Vercel 防火墙（Vercel Firewall）](https://vercel.com/docs/vercel-firewall) 的信息。如果您希望自己的 [机器人也获得官方验证，请访问 bots.fyi 提交申请](https://bots.fyi/new-bot)。
&#123;% endraw %}
