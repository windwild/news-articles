---
title: "Observe your feature flags with the Vercel DX platform - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/observe-your-feature-flags-with-the-vercel-dx-platform"
date: "2024-05-23"
scraped_at: "2026-03-02T09:44:40.479494529+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

May 23, 2024

2024 年 5 月 23 日

![Flags are directly integrated with Vercel Web Analytics and Runtime Logs.](images/observe-your-feature-flags-with-the-vercel-dx-platform-vercel/img_001.jpg)![Flags are directly integrated with Vercel Web Analytics and Runtime Logs.](images/observe-your-feature-flags-with-the-vercel-dx-platform-vercel/img_002.jpg)

![标志已直接集成至 Vercel Web Analytics 和运行时日志中。](images/observe-your-feature-flags-with-the-vercel-dx-platform-vercel/img_001.jpg)![标志已直接集成至 Vercel Web Analytics 和运行时日志中。](images/observe-your-feature-flags-with-the-vercel-dx-platform-vercel/img_002.jpg)

The Vercel DX Platform now has a deep understanding of the feature flags you use and create in third-party providers. This beta integration provides better insights into your applications and streamlines your development workflow.

Vercel DX 平台现已深度理解您在第三方服务商（如 LaunchDarkly、Statsig 或 Split）中使用和创建的各类功能标志（Feature Flags）。此次 Beta 版集成可为您提供更深入的应用洞察，并显著优化开发工作流。

- **Web Analytics integration:** Break down page views and custom events by feature flags in Web Analytics, gaining granular insights into user interactions.

- **Web Analytics 集成**：在 Web Analytics 中按功能标志对页面浏览量与自定义事件进行细分，从而获得关于用户交互行为的精细化洞察。

- **Enhanced Log visibility:** The platform now displays feature flags in logs, making it easier to understand the conditions under which errors occur.

- **增强的日志可见性**：平台现可在日志中直接显示功能标志，帮助您更清晰地理解错误发生的上下文条件。

- `reportValue`: Reports an evaluated feature flag from the server for runtime logs and Custom Analytics Events (server-side).

- `reportValue`：从服务端上报已求值的功能标志，用于运行时日志及自定义分析事件（服务端）。

- `<FlagValues />`: Surfaces a feature flags value on the client for usage in Analytics.

- `<FlagValues />`：在客户端暴露功能标志的取值，供分析系统（Analytics）使用。

These features have universal compatibility with any feature flag provider you're already using, like LaunchDarkly, Statsig, or Split, or custom setups.

上述功能与您当前使用的任意功能标志服务商（例如 LaunchDarkly、Statsig 或 Split）或自定义方案完全兼容，具备通用适配能力。

This update lets users on all plans leverage existing feature flag workflows within the Vercel platform and ship safely with more confidence.

本次更新使所有订阅计划的用户均可在 Vercel 平台内无缝复用既有的功能标志工作流，从而更加安全、自信地交付产品。

Check out the [documentation](https://vercel.com/docs/workflow-collaboration/feature-flags/integrate-vercel-platform) to learn more.

请查阅[相关文档](https://vercel.com/docs/workflow-collaboration/feature-flags/integrate-vercel-platform)，了解更多信息。