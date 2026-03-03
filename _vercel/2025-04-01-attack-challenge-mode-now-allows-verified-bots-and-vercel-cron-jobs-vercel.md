---
title: "Attack Challenge Mode now allows verified bots and Vercel cron jobs - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/attack-challenge-mode-now-allows-verified-bots-and-vercel-cron-jobs"
date: "2025-04-01"
scraped_at: "2026-03-02T09:35:12.229909631+00:00"
language: "en-zh"
translated: true
description: "Vercel's Attack Challenge Mode blocks attacks while securely allowing verified webhooks, search engines, and analytics tools."
---

Apr 1, 2025

2025 年 4 月 1 日

Verified webhook providers—including Stripe and PayPal—are now automatically allowed in Attack Challenge Mode, ensuring uninterrupted payment processing. Well-behaved bots from major search engines, such as Googlebot, and analytics platforms are also supported.

经验证的 Webhook 服务提供商（包括 Stripe 和 PayPal）现已在攻击挑战模式（Attack Challenge Mode）下自动获准通行，确保支付处理不受中断。来自主流搜索引擎（例如 Googlebot）及分析平台的行为良好的机器人（bots）也同样受支持。

Vercel [Cron Jobs](https://vercel.com/docs/cron-jobs) are now exempt from challenges when running in the same account. Like other trusted internal traffic, they bypass Attack Challenge Mode automatically.

Vercel [定时任务（Cron Jobs）](https://vercel.com/docs/cron-jobs) 现在在同账户内运行时将免于接受挑战。与其他受信任的内部流量一样，它们会自动绕过攻击挑战模式（Attack Challenge Mode）。

To block specific known bots, create [a custom rule](https://vercel.com/docs/vercel-waf/custom-rules) that matches their User Agent. Known bots are validated to be authentic and cannot be spoofed to bypass Attack Challenge Mode.

如需屏蔽特定的已知机器人，请创建一条[自定义规则](https://vercel.com/docs/vercel-waf/custom-rules)，使其匹配对应机器人的 User Agent。所有已知机器人均经过真实性验证，无法通过伪造 User Agent 的方式绕过攻击挑战模式（Attack Challenge Mode）。

Learn more about [Attack Challenge Mode](https://vercel.com/docs/attack-challenge-mode) and how [Vercel maintains its directory of legitimate bots](https://vercel.com/docs/attack-challenge-mode#known-bots-support).

了解更多关于[攻击挑战模式（Attack Challenge Mode）](https://vercel.com/docs/attack-challenge-mode) 的信息，以及 [Vercel 如何维护其合法机器人目录](https://vercel.com/docs/attack-challenge-mode#known-bots-support)。