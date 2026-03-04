---
render_with_liquid: false
title: "New firewall challenge metrics now available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/new-firewall-challenge-metrics-now-available"
date: "2025-06-03"
scraped_at: "2026-03-02T09:33:02.005600581+00:00"
language: "en-zh"
translated: true
description: "You can now monitor and query for challenge outcomes with two new metrics, available in the Firewall and Observability dashboards."
---
render_with_liquid: false
render_with_liquid: false

Jun 3, 2025

2025 年 6 月 3 日

You can now monitor and query [Vercel Firewall challenge](https://vercel.com/docs/vercel-firewall/firewall-concepts#challenge) outcomes using two new metrics:

您现在可以使用以下两个新指标来监控和查询 [Vercel Firewall 挑战](https://vercel.com/docs/vercel-firewall/firewall-concepts#challenge) 的结果：

- **`challenge-solved`** – Visitor solved the challenge and was granted access (indicates a real user)

- **`challenge-solved`** — 访问者成功完成挑战并获准访问（表明为真实用户）

- **`challenge-failed`** – Visitor submitted an invalid challenge solution (the request was blocked)

- **`challenge-failed`** — 访问者提交了无效的挑战答案（该请求被拦截）

These metrics help evaluate rule effectiveness and reduce friction when users are unnecessarily challenged (high success rates).

这些指标有助于评估规则的有效性，并在用户被不必要地发起挑战时降低体验摩擦（高成功率）。

Now available in the Firewall [dashboard](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Ffirewall&title=Go%20to%20Firewall) and in the Observability Plus' [query builder](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fobservability?builder=true&title=Go%20to%20Observability%20Plus%20Query%20Builder) with no additional setup required.

现已在 Firewall [控制台](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Ffirewall&title=Go%20to%20Firewall) 和 Observability Plus 的 [查询构建器](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fobservability?builder=true&title=Go%20to%20Observability%20Plus%20Query%20Builder) 中上线，无需额外配置。

Learn more about [custom rules](https://vercel.com/docs/vercel-firewall/vercel-waf/custom-rules) and [managed rulesets](https://vercel.com/docs/vercel-firewall/vercel-waf/managed-rulesets).

了解更多关于 [自定义规则](https://vercel.com/docs/vercel-firewall/vercel-waf/custom-rules) 和 [托管规则集](https://vercel.com/docs/vercel-firewall/vercel-waf/managed-rulesets) 的信息。