---
title: "Fast Data Transfer for rewrites between your team's projects is now free - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/fast-data-transfer-for-rewrites-between-a-teams-projects-is-now-free"
date: "2025-02-27"
scraped_at: "2026-03-02T09:35:38.325543682+00:00"
language: "en-zh"
translated: true
description: "External rewrites between projects within the same team have been optimized internally, lowering the Fast Data Transfer they use and their associated costs."
---
{% raw %}

Feb 27, 2025

2025 年 2 月 27 日

同一团队内各项目之间的外部 [重写（rewrites）](https://vercel.com/docs/edge-network/rewrites) 现在仅对目标请求（destination request）启用快速数据传输（Fast Data Transfer）。此项变更使原始请求（original request）的快速数据传输变为免费。

重写功能常被用作 [反向代理（reverse proxy）](https://vercel.com/guides/vercel-reverse-proxy-rewrites-external)，或用于实现 [微前端架构（microfrontend architectures）](https://vercel.com/blog/how-vercel-adopted-microfrontends)。您可在 `vercel.json`、中间件（middleware）或 `next.config.ts` 中配置重写规则，从而在相同或不同的 Vercel 项目之间路由请求，且无需更改用户所见的 URL。

同一团队内外部重写的使用说明：

- 原始请求与目标请求所使用的 [快速数据传输（Fast Data Transfer）](https://vercel.com/docs/pricing/networking#fast-data-transfer) 已经经过优化并整合为单一流（single stream），从而降低了整体数据传输量。

- 每次外部重写均会触发一次完整的请求生命周期（full request lifecycle），包括路由（routing）和 Web 应用防火墙（WAF）检查，确保每个项目的安全部署策略均得到严格执行；同时，每次重写也会计为一次独立的 [边缘请求（Edge Request）](https://vercel.com/docs/edge-network/overview)。

了解有关 [重写（rewrites）](https://vercel.com/docs/edge-network/rewrites) 的更多信息，并监控您的快速数据传输 [用量（usage）](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fusage&title=Go+to+Fast+Data+Transfer+Usage) 和 [可观测性（observability）](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fobservability%2Ffast-data-transfer&title=Go+to+Fast+Data+Transfer+Observability)。
{% endraw %}
