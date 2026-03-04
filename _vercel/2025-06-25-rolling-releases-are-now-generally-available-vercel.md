---
title: "Rolling Releases are now generally available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/rolling-releases-are-now-generally-available"
date: "2025-06-25"
scraped_at: "2026-03-02T09:32:19.733549389+00:00"
language: "en-zh"
translated: true
description: "Rolling Releases are now generally available, enabling incremental rollouts of new production deployments. Advance through defined rollout stages for safer deploys. Available now for Pro and Enterpris..."
---
{% raw %}

Jun 25, 2025

2025年6月25日

![](images/rolling-releases-are-now-generally-available-vercel/img_001.jpg)![](images/rolling-releases-are-now-generally-available-vercel/img_002.jpg)

Rolling Releases are now generally available, allowing safe, incremental rollouts of new deployments with built-in monitoring, rollout controls, and no custom routing required.

滚动发布（Rolling Releases）现已正式上线，支持安全、渐进式地部署新版本，内置监控能力、发布控制机制，且无需配置自定义路由。

Each rollout starts at a defined stage and can either progress automatically or be manually promoted to a full release. You can configure rollout stages per project and decide how each stage progresses, with updates propagating globally in under 300ms through our fast propagation pipeline.

每次发布均从预设阶段开始，既可自动推进，也可手动升级为完整发布。您可按项目配置发布阶段，并自主决定各阶段的推进方式；所有更新将通过我们的高速传播管道，在 300 毫秒内同步至全球。

Rolling releases also include:

滚动发布还包含以下特性：

- **Real-time monitoring**: Track and compare error rates and [Speed Insights](https://vercel.com/docs/speed-insights) (like [Core Web Vitals](https://web.dev/articles/vitals#core-web-vitals), Time to First Byte, and more) between versions

- **实时监控**：跨版本追踪并对比错误率及 [Speed Insights](https://vercel.com/docs/speed-insights)（例如 [Core Web Vitals](https://web.dev/articles/vitals#core-web-vitals)、首字节时间（Time to First Byte）等指标）

- **Flexible controls**: Rollouts can be managed via REST API, CLI, the project dashboard, or the Vercel Terraform provider

- **灵活的控制方式**：可通过 REST API、命令行工具（CLI）、项目仪表板或 Vercel Terraform Provider 管理发布流程

- **Version-labeled logs**: Logs and telemetry are labeled by deployment for easier debugging

- **带版本标签的日志**：日志与遥测数据均按部署打上版本标签，便于调试

Pro and Enterprise teams can enable Rolling Releases on one project at no additional cost. Enterprise customers can upgrade to unlimited projects.

Pro 和 Enterprise 团队可在单个项目中免费启用滚动发布功能；Enterprise 客户可升级至支持无限数量项目。

Learn more about [Rolling Releases](https://vercel.com/docs/rolling-releases) or [enable it on your project](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fbuild-and-deployment&title=Go+to+Rolling+Releases).

了解更多关于 [滚动发布（Rolling Releases）](https://vercel.com/docs/rolling-releases) 的信息，或立即 [在您的项目中启用该功能](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fbuild-and-deployment&title=Go+to+Rolling+Releases)。
{% endraw %}
