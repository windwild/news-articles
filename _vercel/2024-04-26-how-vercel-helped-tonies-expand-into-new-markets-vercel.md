---
title: "How Vercel helped Tonies expand into new markets - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-vercel-helped-tonies-expand-into-new-markets"
date: "2024-04-26"
scraped_at: "2026-03-02T09:45:24.135919261+00:00"
language: "en-zh"
translated: true
description: "By embracing a headless stack powered by Vercel and Contentful, Tonies was able to scale their ecommerce presence, expand into new markets, and improve UX."
---
&#123;% raw %}

Apr 26, 2024

2024年4月26日

Tonies 的前端架构依托 Vercel、Next.js 和 Contentful，已带来巨大的商业价值，并显著提升了用户体验（UX）与开发者体验（DX）。

[Tonies](https://us.tonies.com/)（专为儿童打造智能音频系统的创造者）希望拓展至新市场，但其现有平台显然无法支撑这一增长目标。为此，Tonies 启动了一项战略性迁移，全面转向由 Vercel 前端云（Frontend Cloud）与 Contentful 内容管理系统（CMS）驱动的新一代前端平台。

Tonies 团队此前采用两套彼此独立的技术栈：一套是高度定制化的 PHP CMS，用于对接 Commercetools 实现线上商城功能；另一套则是部署在 AWS 上的 React 单页应用（SPA）。全面采用现代化的、基于 React 的无头架构（headless stack），覆盖其全部 Web 业务场景，对 Tonies 至关重要——此举不仅推动了多个开发团队整合为统一的 Web 团队，还实现了工具链与 UI 资源的共享，同时减少了所需团队成员数量。

## Improvements in UX and DX

## 用户体验（UX）与开发者体验（DX）的提升

Vercel 前端云迅速带来了多项切实收益。借助 Vercel 的 [预览部署（Preview Deployments）](https://vercel.com/docs/deployments/preview-deployments)，Tonies 团队大幅优化了开发流程、持续交付（CD）及质量保证（QA）环节。在预览部署环境中即可测试登录与支付等关键功能，极大加快了 QA 进程，确保每次新版本发布都具备更高的健壮性与可靠性。

得益于几乎全部页面均在服务端完成预渲染，并通过 Vercel 的 [CDN 缓存](https://vercel.com/docs/edge-network/caching#cdn-cache-control)进行分发，Tonies 显著降低了网络延迟，在流量高峰时段（如“黑色星期五”）展现出卓越的可扩展性，同时全面提升了终端用户的浏览体验。此外，Vercel 提供的 [监控（Monitoring）](https://vercel.com/docs/observability/monitoring) 与日志（Logging）工具，使团队得以深入洞察应用性能表现，并显著加速问题排查与调试过程。

## The business impact

## 商业影响

采用 Vercel 对 Tonies 产生了深远的商业影响。首先，Tonies 能够以快速、迭代的方式完成向新技栈的迁移，最大限度地降低了对业务运营及终端用户的干扰。在此次迁移过程中，Tonies 顺利地从原先仅服务两个市场（德国与英国），轻松扩展至覆盖四个市场。

尤为值得一提的是，迁移完成后，Tonies 观察到转化率（conversion rates）实现了可观提升，充分印证了此次战略转型的有效性。团队的发布节奏也发生根本性转变：从过去极低频次的发布（有时间隔超过一个月），跃升为每周多次部署，从而更敏捷地向用户交付全新功能与更新内容。

With these advancements in place, Tonies is well-positioned not only to scale within Europe, but also to extend its reach beyond European markets. This successful transition underscores the importance of selecting robust frontend solutions like Vercel's Frontend Cloud.

在这些技术进步的支撑下，Tonies 不仅能够顺利实现欧洲市场的规模化扩张，更有能力将业务拓展至欧洲以外的全球市场。此次成功的转型进一步印证了选择 Vercel 前端云（Frontend Cloud）等强大前端解决方案的重要性。

[**Ready for the future of ecommerce?**  
[**您是否已为电商的未来做好准备？**

Break free from the monolith. Learn how the Vercel stack can accelerate your digital success.  
摆脱单体架构的束缚。了解 Vercel 技术栈如何加速您的数字化成功。
&#123;% endraw %}
